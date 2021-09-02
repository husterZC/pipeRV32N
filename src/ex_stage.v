/*
*Auther:  		Chi Zhang
*Contact: 		chizhang@student.ethz.ch
*Date: 			2021/8/9
*Description:	execution stage of pipeRV32N
*/
`include "core.h"
module ex_stage(
	//input contrl line 
	input 											clk, reset,enable, nop,
	//output contrl line
	output 											done,
	//output reg data
	output reg [`REGISTER_WIDTH-1:0] 				res,
	output reg [`REGISTER_WIDTH-1:0] 				current_pc_addr,
	output reg [`CPU_REGISTER_INDEX_WIDTH-1:0]		dest,
	output reg [`WB_CTRL_WIDTH-1:0]					wb_ctrl,	
	output reg [`MEM_CTRL_WIDTH-1:0]				mem_ctrl,
	output reg [`IMM_WIDTH-1:0] 					data_imm,
	output reg [`CPU_REGISTER_INDEX_WIDTH-1:0]		reg_extra,
	output reg 										nop_statue, 
	output reg [`CORE_ERROR_WIDTH-1:0]				error_code,
	//output data path
	output [`CPU_REGISTER_INDEX_WIDTH-1:0]			rs1,
	output [`CPU_REGISTER_INDEX_WIDTH-1:0]			rs2,
	//input data path
	input [`REGISTER_WIDTH-1:0]						rs1_data,
	input [`REGISTER_WIDTH-1:0]						rs2_data,
	//input pipe data
	input [`REGISTER_WIDTH-1:0] 					id_data_x,
	input								 			id_is_x_reg,
	input [`REGISTER_WIDTH-1:0] 					id_data_y,
	input 								 			id_is_y_reg,
	input [`REGISTER_WIDTH-1:0] 					id_current_pc_addr,
	input [`CPU_REGISTER_INDEX_WIDTH-1:0]			id_dest,
	input [`ALU_CTRL_WIDTH-1:0]						id_alu_ctrl,
	input [`WB_CTRL_WIDTH-1:0]						id_wb_ctrl,	
	input [`MEM_CTRL_WIDTH-1:0]						id_mem_ctrl,
	input [`IMM_WIDTH-1:0] 							id_data_imm,
	input [`CPU_REGISTER_INDEX_WIDTH-1:0]			id_reg_extra,
	input 											id_nop_statue, 
	input [`CORE_ERROR_WIDTH-1:0]					id_error_code
);

//Next out reg data line
	wire [`REGISTER_WIDTH-1:0] 						__res;
	wire [`REGISTER_WIDTH-1:0] 						__current_pc_addr;
	wire [`CPU_REGISTER_INDEX_WIDTH-1:0]			__dest;
	wire [`WB_CTRL_WIDTH-1:0]						__wb_ctrl;
	wire [`MEM_CTRL_WIDTH-1:0]						__mem_ctrl;
	wire [`IMM_WIDTH-1:0] 							__data_imm;
	wire [`CPU_REGISTER_INDEX_WIDTH-1:0]			__reg_extra;
	wire 											__nop_statue; 
	wire [`CORE_ERROR_WIDTH-1:0]					__error_code;
//Intermidiate wires
	wire [2:0]										alu_op;
	wire											sub_arth_mode;
	wire [`REGISTER_WIDTH-1:0]						signed_real_data_x;
	wire [`REGISTER_WIDTH-1:0]						real_data_x;
	wire [`REGISTER_WIDTH-1:0]						real_data_y;
	wire [`REGISTER_WIDTH-1:0]						real_data_y_for_add;
	wire 											data_x_from_wb_valid;
	wire 											data_y_from_wb_valid;
//Combination circuit
	assign	{sub_arth_mode,alu_op}			=	id_alu_ctrl;

	assign	rs1								=	id_data_x[2:0];
	assign	rs2								=	id_data_y[2:0];
	
	assign	data_x_from_wb_valid			=	(nop_statue==1'b0) && (error_code==`CORE_ERROR_NO) && (dest!=3'b0) && (rs1==dest);
	assign	data_y_from_wb_valid			=	(nop_statue==1'b0) && (error_code==`CORE_ERROR_NO) && (dest!=3'b0) && (rs2==dest);
	
	assign	real_data_x						=	(~id_is_x_reg)? 				id_data_x:
												(data_x_from_wb_valid)?			res:
																				rs1_data;
																								
	assign	signed_real_data_x				=	$signed(real_data_x);
																													
	assign	real_data_y						=	(~id_is_y_reg)? 				id_data_y:
												(data_y_from_wb_valid)?			res:
																				rs2_data;
	
	assign	real_data_y_for_add				=	(sub_arth_mode)? ~real_data_y:real_data_y;
	
	assign 	__res 							= 	(alu_op==`ALU_ADD)?				real_data_x+real_data_y_for_add+sub_arth_mode:
												(alu_op==`ALU_SLL)?				real_data_x << (real_data_y[4:0]):
												(alu_op==`ALU_SLT)?				($signed(real_data_x) < $signed(real_data_y)):
												(alu_op==`ALU_SLTU)?			($unsigned(real_data_x) < $unsigned(real_data_y)):
												(alu_op==`ALU_XOR)?				real_data_x^real_data_y:
												((alu_op==`ALU_SHR) && (sub_arth_mode==1'b1))?
																				signed_real_data_x >>> (real_data_y[4:0]):
												((alu_op==`ALU_SHR) && (sub_arth_mode==1'b0))?						
																				(real_data_x) >> (real_data_y[4:0]):
												(alu_op==`ALU_OR)?				real_data_x|real_data_y:
												(alu_op==`ALU_AND)?				real_data_x&real_data_y:
																				{`REGISTER_WIDTH{1'bx}};
																								
	assign __nop_statue						= 	nop|id_nop_statue;
	
	assign __error_code						=	id_error_code;
	
	assign __current_pc_addr				=	id_current_pc_addr;
	
	assign __dest							=	id_dest;
	
	assign __wb_ctrl						=	id_wb_ctrl;
	
	assign __mem_ctrl						=	id_mem_ctrl;
	
	assign __data_imm						=	id_data_imm;
	
	assign __reg_extra						=	id_reg_extra;
	
	assign done								=	1'b1;


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
				res					<=			__res;
				current_pc_addr 	<= 			__current_pc_addr;
				dest				<=			__dest;
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
