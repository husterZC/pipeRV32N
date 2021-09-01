`include "core.h"
//definition
`define	x0	5'd0
`define	x1	5'd1
`define	x2	5'd2
`define	x3	5'd3
`define	x4	5'd4
`define	x5	5'd5
`define	x6	5'd6
`define	x7	5'd7

`define  IF_STATUE_WIDTH 	2
`define 	IF_STAGE_IDLE		`IF_STATUE_WIDTH'd0
`define 	IF_STAGE_WORK		`IF_STATUE_WIDTH'd1
`define 	IF_STAGE_DISABLE	`IF_STATUE_WIDTH'd2


`define 	INSTRUCTION_START_ADDR	32'd0

`define 	USE_INSTRUCTION_FROM_MAIN_MEMORY
/*******************************************/
//module
module if_stage(
	//input contrl line 
	input 												clk, reset,enable, nop,
	input 		[`IF_ADDR_MODE_WIDTH-1:0] 		addr_mode,
	//output contrl line
	output 												done,
	//output reg data
	output 		[`INSTRUCTION_WIDTH-1:0] 		instruction,
	output reg 	[`REGISTER_WIDTH-1:0] 			current_pc_addr,
	output reg 											nop_statue, 
	output reg 	[`CORE_ERROR_WIDTH-1:0]			error_code,
	//input data path
	input 		[`REGISTER_WIDTH-1:0]			reg_addr_input,
	input	 		[`IMM_WIDTH-1:0]					imm_addr_input,
	//interface to main memory
	output		[`REGISTER_WIDTH-1:0] 			addr_to_main_memory,
	input			[`INSTRUCTION_WIDTH-1:0] 		inst_from_main_memory,
	input													main_memory_error
);
//If stage statue
	reg			[`IF_STATUE_WIDTH-1:0]					if_stage_statue;
//Cache inside
	reg [`REGISTER_WIDTH-1:0]  instruction_cache[255:0];
//next out reg data line
	wire [`INSTRUCTION_WIDTH-1:0] __instruction;
	wire [`REGISTER_WIDTH-1:0] 	__next_pc_addr;
	wire 									__nop_statue;
	wire [`CORE_ERROR_WIDTH-1:0]  __error_code;
//instruction reg
	reg  [`INSTRUCTION_WIDTH-1:0]	__instruction_reg;
	
`ifdef USE_INSTRUCTION_FROM_MAIN_MEMORY
//register to store instruction from main memory
	reg  [`INSTRUCTION_WIDTH-1:0]	__instruction_from_memory_reg;
`endif
//intermidiate wires
	wire [`REGISTER_WIDTH-1:0] __add_left,__add_right;
//Combination circuit
	assign __add_left 		= 	(addr_mode == `IF_ADDR_MODE_PC_4)? 			current_pc_addr:
										(addr_mode == `IF_ADDR_MODE_PC_IMM)?		current_pc_addr:
																								reg_addr_input;
	assign __add_right		= 	(addr_mode == `IF_ADDR_MODE_PC_4)? 			`REGISTER_WIDTH'd4 :
										(addr_mode == `IF_ADDR_MODE_PC_IMM)?		imm_addr_input:
										(addr_mode == `IF_ADDR_MODE_REG_IMM)?		imm_addr_input:
																								`REGISTER_WIDTH'd0 ;
										
										
	assign __next_pc_addr	= 	(if_stage_statue == `IF_STAGE_IDLE)? `INSTRUCTION_START_ADDR:__add_left + __add_right;
	assign __error_code		=	(|__next_pc_addr[31:10])? `CORE_ERROR_IF:`CORE_ERROR_NO;
	assign __instruction 	= instruction_cache[__next_pc_addr[9:2]];//pc+4
	assign __nop_statue		= 1'b0;//never make nop to ID
	assign done					= 1'b1;
`ifdef USE_INSTRUCTION_FROM_MAIN_MEMORY
	assign instruction		= (if_stage_statue == `IF_STAGE_DISABLE)? __instruction_from_memory_reg :inst_from_main_memory;
`else
	assign instruction		= __instruction_reg;
`endif
//to main memory
	assign addr_to_main_memory	=	__next_pc_addr;
											
	
//Initialization
	initial begin
		__instruction_reg	= 		`INSTRUCTION_WIDTH'b0;
		current_pc_addr 	= 		`INSTRUCTION_START_ADDR;
		nop_statue			=		1'b1;
		error_code			=		`CORE_ERROR_NO;
		if_stage_statue	=		`IF_STAGE_IDLE;
	end
	
	initial begin
		instruction_cache[0] = {//lui x1, 20'habcde
	20'habcde,
	`x1,
	`U_TYPE_IMM
};
		instruction_cache[1] = {//addi x1, x0, 16
	12'h64d,
	`x0,
	3'b000,
	`x1,
	`I_TYPE_CALC
};
		instruction_cache[2] = {//auipc x2, 20'h0
	20'h0,
	`x2,
	`U_TYPE_AUIPC
};
		instruction_cache[3] = {//addi x2, x2, 1
	12'b1,
	`x2,
	3'b000,
	`x2,
	`I_TYPE_CALC
};
		instruction_cache[4] = {//add x3, x2, x1
	7'b0,
	`x2,
	`x1,
	3'b000,
	`x3,
	`R_TYPE
};
		instruction_cache[5] = {//sw x3, 0{x0}
	7'b0,
	`x3,
	`x0,
	3'b010,
	5'b0,
	`S_TYPE
};
		instruction_cache[6] = {//lw x4, 0{x0}
	12'b0,
	`x0,
	3'b010,
	`x4,
	`I_TYPE_LOAD
};
		instruction_cache[7] = {//lb x4, 8{x0}
	12'd8,
	`x0,
	3'b000,
	`x4,
	`I_TYPE_LOAD
};
		instruction_cache[8] = {//lh x4, 8{x0}
	12'd8,
	`x0,
	3'b001,
	`x4,
	`I_TYPE_LOAD
};
		instruction_cache[9] = {//lbu x4, 8{x0}
	12'd8,
	`x0,
	3'b100,
	`x4,
	`I_TYPE_LOAD
};
		instruction_cache[10] = {//lhu x4, 8{x0}
	12'd8,
	`x0,
	3'b101,
	`x4,
	`I_TYPE_LOAD
};
		instruction_cache[11] = {//sb x1, 4{x0}
	7'b0,
	`x1,
	`x0,
	3'b000,
	5'd4,
	`S_TYPE
};
		instruction_cache[12] = {//sh x1, 5{x0}
	7'b0,
	`x1,
	`x0,
	3'b001,
	5'd5,
	`S_TYPE
};
		instruction_cache[13] = {//lw x4, 4{x0}
	12'd4,
	`x0,
	3'b010,
	`x4,
	`I_TYPE_LOAD
};
		instruction_cache[14] = {//addi x4, x4, 17
	12'd17,
	`x4,
	3'b000,
	`x4,
	`I_TYPE_CALC
};
/*		instruction_cache[15] = {//addi x1, x1, -17
	-12'd17,
	`x1,
	3'b000,
	`x1,
	`I_TYPE_CALC
};
		instruction_cache[16] = {//slti x5, x1, 12'h54d
	12'h54d,
	`x1,
	3'b010,
	`x5,
	`I_TYPE_CALC
};
		instruction_cache[17] = {//slti x5, x1, 12'h74d
	12'h74d,
	`x1,
	3'b010,
	`x5,
	`I_TYPE_CALC
};
		instruction_cache[18] = {//slti x5, x1, -12'd12
	-12'd12,
	`x1,
	3'b010,
	`x5,
	`I_TYPE_CALC
};
		instruction_cache[19] = {//sltiu x5, x1, -12'd12
	-12'd12,
	`x1,
	3'b011,
	`x5,
	`I_TYPE_CALC
};
		instruction_cache[20] = {//sltiu x5, x1, 12'h54d
	12'h54d,
	`x1,
	3'b011,
	`x5,
	`I_TYPE_CALC
};
		instruction_cache[21] = {//xori x5, x1, 12'hfff
	12'hfff,
	`x1,
	3'b100,
	`x5,
	`I_TYPE_CALC
};
		instruction_cache[22] = {//ori x5, x1, 12'hfff
	12'hfff,
	`x1,
	3'b110,
	`x5,
	`I_TYPE_CALC
};
		instruction_cache[23] = {//andi x5, x1, 12'hfff
	12'hfff,
	`x1,
	3'b111,
	`x5,
	`I_TYPE_CALC
};
		instruction_cache[24] = {//addi x1, x0, -1
	-12'h1,
	`x0,
	3'b000,
	`x1,
	`I_TYPE_CALC
};
		instruction_cache[25] = {//slli x5, x1, 12'h2
	12'h2,
	`x1,
	3'b001,
	`x5,
	`I_TYPE_CALC
};
		instruction_cache[26] = {//slli x5, x1, 12'h4
	12'h4,
	`x1,
	3'b001,
	`x5,
	`I_TYPE_CALC
};
		instruction_cache[27] = {//srli x5, x1, 12'h4
	12'h4,
	`x1,
	3'b101,
	`x5,
	`I_TYPE_CALC
};
		instruction_cache[28] = {//slli x5, x1, 12'h4
	12'h4,
	`x1,
	3'b001,
	`x5,
	`I_TYPE_CALC
};
		instruction_cache[29] = {//srai x5, x5, 12'h4
	12'h404,
	`x5,
	3'b101,
	`x5,
	`I_TYPE_CALC
};*/

/*		instruction_cache[7] = {//bltu x2, x1, -16
	1'b1,
	6'b111111,
	`x1,
	`x2,
	3'b110,
	4'h8,
	1'b1,
	`B_TYPE
};*/
/*		instruction_cache[7] = {//jal x5, 0
	//1'b1,
	//10'b1111111000, -16
	//1'b1,
	//8'hff,
	20'b0,
	`x5,
	`J_TYPE_JAL
};*/
		instruction_cache[15] = {//jalr x5, x0, 12
	12'h00c,
	`x0,
	3'b0,
	`x7,
	`J_TYPE_JALR
};
		instruction_cache[16] = `INSTRUCTION_WIDTH'd0;
	end
	
//Always block	
	always @(posedge clk) begin
		if(reset) begin
			__instruction_reg	<= 		`INSTRUCTION_WIDTH'b0;
			current_pc_addr 	<= 		`INSTRUCTION_START_ADDR;
			nop_statue			<=			1'b1;
			error_code			<=			`CORE_ERROR_NO;
			if_stage_statue	<=			`IF_STAGE_IDLE;
		end
		else begin //enable, nop
		
		`ifdef USE_INSTRUCTION_FROM_MAIN_MEMORY
			__instruction_from_memory_reg <= inst_from_main_memory;
		`endif
			if(enable & (~nop)) begin
				__instruction_reg	<= 		__instruction;
				current_pc_addr 	<= 		__next_pc_addr;
				nop_statue			<=			__nop_statue;
				error_code			<=			__error_code;
				if_stage_statue	<=			`IF_STAGE_WORK;
			end
			else begin
				if_stage_statue	<=			`IF_STAGE_DISABLE;
			end
		end
	end



endmodule
