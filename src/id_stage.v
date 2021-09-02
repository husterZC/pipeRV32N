/*
*Auther:  		Chi Zhang
*Contact: 		chizhang@student.ethz.ch
*Date: 			2021/8/3
*Description:	instruction decoding stage of pipeRV32N
*/
`include "core.h"
module id_stage(
	//input contrl line 
	input 											clk, reset,enable, nop,
	//output contrl line
	output 											done,req_nop,req_jal,
	//output reg data
	output reg [`REGISTER_WIDTH-1:0] 				data_x,
	output reg 								 		is_x_reg,
	output reg [`REGISTER_WIDTH-1:0] 				data_y,
	output reg 								 		is_y_reg,
	output reg [`REGISTER_WIDTH-1:0] 				current_pc_addr,
	output reg [`CPU_REGISTER_INDEX_WIDTH-1:0]		dest,
	output reg [`ALU_CTRL_WIDTH-1:0]				alu_ctrl,
	output reg [`WB_CTRL_WIDTH-1:0]					wb_ctrl,	
	output reg [`MEM_CTRL_WIDTH-1:0]				mem_ctrl,
	output reg [`IMM_WIDTH-1:0] 					data_imm,
	output reg [`CPU_REGISTER_INDEX_WIDTH-1:0]		reg_extra,
	output reg 										nop_statue, 
	output reg [`CORE_ERROR_WIDTH-1:0]				error_code,
	//output data path
	output [`IMM_WIDTH-1:0] 						imm_to_if,
	//input pipe data
	input [`INSTRUCTION_WIDTH-1:0] 					if_instruction,
	input [`REGISTER_WIDTH-1:0] 					if_current_pc_addr,
	input 											if_nop_statue, 
	input [`CORE_ERROR_WIDTH-1:0]					if_error_code
);
//Next out reg data line
	wire [`REGISTER_WIDTH-1:0] 						__data_x;
	wire 								 			__is_x_reg;
	wire [`REGISTER_WIDTH-1:0] 						__data_y;
	wire 								 			__is_y_reg;
	wire [`REGISTER_WIDTH-1:0] 						__current_pc_addr;
	wire [`CPU_REGISTER_INDEX_WIDTH-1:0]			__dest;
	wire [`ALU_CTRL_WIDTH-1:0]						__alu_ctrl;
	wire [`WB_CTRL_WIDTH-1:0]						__wb_ctrl;
	wire [`MEM_CTRL_WIDTH-1:0]						__mem_ctrl;
	wire [`IMM_WIDTH-1:0] 							__data_imm;
	wire [`CPU_REGISTER_INDEX_WIDTH-1:0]			__reg_extra;
	wire 											__nop_statue; 
	wire [`CORE_ERROR_WIDTH-1:0]					__error_code;
//Intermidiate wires
	wire [6:0] 	opcode,funct7;
	wire [4:0]	rd,rs1,rs2;
	wire [2:0]	funct3;
	wire [`IMM_WIDTH-1:0] imm_upper,imm_jal,imm_signext12, imm_zeroext12, imm_branch, imm_save;
//Combination circuit
	assign {funct7,rs2,rs1,funct3,rd,opcode} = if_instruction;
	
	assign imm_upper 		= 	{{funct7,rs2,rs1,funct3},{12{1'b0}}};
	assign imm_jal			=	{{12{if_instruction[31]}},if_instruction[19:12],if_instruction[20],if_instruction[30:21],1'b0};
	assign imm_signext12 	= 	{{20{funct7[6]}},{funct7,rs2}};
	assign imm_zeroext12 	= 	{{20{1'b0}},{funct7,rs2}};
	assign imm_branch 		= 	{{20{funct7[6]}},{rd[0],funct7[5:0],rd[4:1],1'b0}};
	assign imm_save 		= 	{{20{funct7[6]}},{funct7,rd}};
	
	assign __data_x			= 		(opcode == `U_TYPE_IMM)? 	`REGISTER_WIDTH'd0:
									(opcode == `U_TYPE_AUIPC)? if_current_pc_addr:
									(opcode == `J_TYPE_JAL)? 	if_current_pc_addr:
									(opcode == `J_TYPE_JALR)? 	if_current_pc_addr:
									(opcode == `B_TYPE)? 		{29'b0,rs1[2:0]}:
									(opcode == `I_TYPE_LOAD)? 	{29'b0,rs1[2:0]}:
									(opcode == `S_TYPE)? 		{29'b0,rs1[2:0]}:
									(opcode == `I_TYPE_CALC)?	{29'b0,rs1[2:0]}:
									(opcode == `R_TYPE)? 		{29'b0,rs1[2:0]}:
																`REGISTER_WIDTH'd0;
																		
	assign __is_x_reg		=		(opcode == `B_TYPE)? 		1'b1:
									(opcode == `I_TYPE_LOAD)? 	1'b1:
									(opcode == `S_TYPE)? 		1'b1:
									(opcode == `I_TYPE_CALC)?	1'b1:
									(opcode == `R_TYPE)? 		1'b1:
																1'b0;
																		
	assign __data_y			= 		(opcode == `U_TYPE_IMM)? 	imm_upper:
									(opcode == `U_TYPE_AUIPC)? 	imm_upper:
									(opcode == `J_TYPE_JAL)? 	`REGISTER_WIDTH'd4:
									(opcode == `J_TYPE_JALR)? 	`REGISTER_WIDTH'd4:
									(opcode == `B_TYPE)? 		{29'b0,rs2[2:0]}:
									(opcode == `I_TYPE_LOAD)? 	imm_signext12:
									(opcode == `S_TYPE)? 		imm_save:
									((opcode == `I_TYPE_CALC) && ((funct3 == 3'b011) || (funct3[2] == 1'b1)))?	imm_zeroext12:
									((opcode == `I_TYPE_CALC) && ((funct3 != 3'b011) && (funct3[2] == 1'b0)))?	imm_signext12:
									(opcode == `R_TYPE)? 		{29'b0,rs2[2:0]}:
																`REGISTER_WIDTH'd0;
																		
	assign __is_y_reg		=		(opcode == `B_TYPE)? 		1'b1:
									(opcode == `R_TYPE)? 		1'b1:
																1'b0;
																		
	assign __current_pc_addr = 		if_current_pc_addr;
	
	assign __dest			=		(opcode == `B_TYPE)? 		`CPU_REGISTER_INDEX_WIDTH'b0:
									(opcode == `S_TYPE)? 		`CPU_REGISTER_INDEX_WIDTH'b0:
																rd[2:0];
	
	assign __alu_ctrl		= 		((opcode == `B_TYPE) && (funct3[2:1]==2'b00))?		{`ALU_SUB_OR_ARTH_MODE,`ALU_ADD}:
									((opcode == `B_TYPE) && (funct3[2:1]==2'b10))?		{`ALU_NOR_MODE,`ALU_SLT}:
									((opcode == `B_TYPE) && (funct3[2:1]==2'b11))?		{`ALU_NOR_MODE,`ALU_SLTU}:
									((opcode == `I_TYPE_CALC) && (funct3 == 3'b101))?	{funct7[5],funct3}:
									((opcode == `I_TYPE_CALC) && (funct3 != 3'b101))?	{`ALU_NOR_MODE,funct3}:
									(opcode == `R_TYPE)? 										{funct7[5],funct3}:
																										{`ALU_NOR_MODE,`ALU_ADD};
																										
																										
	assign __wb_ctrl		=		((opcode == `B_TYPE) && (funct3[0]^funct3[2]==1'b0))? 		`WB_CTRL_BEZ:
									((opcode == `B_TYPE) && (funct3[0]^funct3[2]==1'b1))? 		`WB_CTRL_BNZ:
									(opcode == `J_TYPE_JALR)? 									`WB_CTRL_JALR:
									(opcode == `I_TYPE_LOAD)? 									`WB_CTRL_LOAD:
									(opcode == `S_TYPE)? 										`WB_CTRL_STORE:
																								`WB_CTRL_NORMAL;
	
	assign __data_imm		=		(opcode == `B_TYPE)? 			imm_branch:
									(opcode == `J_TYPE_JALR)? 		imm_signext12:
																	imm_jal;
	
	assign __reg_extra		=		(opcode == `J_TYPE_JALR)? 		rs1[2:0]:rs2[2:0];
	
	assign __mem_ctrl		=		funct3;
	
	assign __nop_statue		= 		nop|if_nop_statue;//loop warning 
	
	assign __error_code		=		((opcode == `J_TYPE_JALR) && ((rs1[4:3]!=2'b00) || (rd[4:3]!=2'b00)))?						`CORE_ERROR_ID:
									((opcode == `B_TYPE) && ((rs1[4:3]!=2'b00) || (rs2[4:3]!=2'b00)))?							`CORE_ERROR_ID:
									((opcode == `S_TYPE) && ((rs1[4:3]!=2'b00) || (rs2[4:3]!=2'b00)))?							`CORE_ERROR_ID:
									((opcode == `I_TYPE_LOAD) && ((rs1[4:3]!=2'b00) || (rd[4:3]!=2'b00)))?						`CORE_ERROR_ID:
									((opcode == `I_TYPE_CALC) && ((rs1[4:3]!=2'b00) || (rd[4:3]!=2'b00)))?						`CORE_ERROR_ID:
									((opcode == `R_TYPE) && ((rs1[4:3]!=2'b00) || (rs2[4:3]!=2'b00) || (rd[4:3]!=2'b00)))?		`CORE_ERROR_ID:
									(
									(opcode != `U_TYPE_IMM) && (opcode != `U_TYPE_AUIPC) && (opcode != `J_TYPE_JAL) &&
									(opcode != `J_TYPE_JALR) && (opcode != `B_TYPE) && (opcode != `I_TYPE_LOAD) &&
									(opcode != `S_TYPE) && (opcode != `I_TYPE_CALC) && (opcode != `R_TYPE)
									)? 																							`CORE_ERROR_ID:
																																if_error_code;
																																						
	assign imm_to_if		=		imm_jal;
	
	assign done				=		1'b1;
	
	assign req_jal			=	(
									(if_nop_statue == 1'b0) && 
									(opcode == `J_TYPE_JAL)  
									)? 					1'b1:1'b0;
									
	assign req_nop			=	(
									(__error_code == `CORE_ERROR_NO) && 
									(if_nop_statue == 1'b0) && 
									(nop_statue == 1'b0) && 
									(error_code == `CORE_ERROR_NO) &&
									(dest!=`CPU_REGISTER_INDEX_WIDTH'b0)	&&
									(wb_ctrl == `WB_CTRL_LOAD) &&	
										(
											((opcode == `B_TYPE) && ((rs1[2:0]==dest)||(rs2[2:0]==dest)))  ||
											((opcode == `R_TYPE) && ((rs1[2:0]==dest)||(rs2[2:0]==dest)))  ||
											((opcode == `I_TYPE_LOAD) && (rs1[2:0]==dest))  ||
											((opcode == `S_TYPE) && (rs1[2:0]==dest))  ||
											((opcode == `I_TYPE_CALC) && (rs1[2:0]==dest))  
										)
									)? 					1'b1:1'b0;
									
//Initialization
	initial begin
		nop_statue			=		1'b1;
		error_code			=		`CORE_ERROR_NO;
	end
	
//Always block
	always @(posedge clk) begin
		if(reset) begin
			nop_statue			<=		1'b1;
			error_code			<=		`CORE_ERROR_NO;
		end
		else begin //enable
			if(enable) begin
				data_x				<=			__data_x;
				is_x_reg			<=			__is_x_reg;
				data_y				<=			__data_y;
				is_y_reg			<=			__is_y_reg;
				current_pc_addr 	<= 			__current_pc_addr;
				dest				<=			__dest;
				alu_ctrl			<=			__alu_ctrl;
				wb_ctrl				<=			__wb_ctrl;
				mem_ctrl			<=			__mem_ctrl;
				data_imm			<=			__data_imm;
				reg_extra			<=			__reg_extra;
				nop_statue			<=			__nop_statue;
				error_code			<=			__error_code;
			end
		end
	end
									
	

endmodule
