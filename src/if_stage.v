/*
*Auther:  		Chi Zhang
*Contact: 		chizhang@student.ethz.ch
*Date: 			2021/8/1
*Description:	instruction fetching stage of pipeRV32N
*/
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

`define  	IF_STATUE_WIDTH 	2
`define 	IF_STAGE_IDLE		`IF_STATUE_WIDTH'd0
`define 	IF_STAGE_WORK		`IF_STATUE_WIDTH'd1
`define 	IF_STAGE_DISABLE	`IF_STATUE_WIDTH'd2


`define 	INSTRUCTION_START_ADDR	32'd0

`define 	USE_INSTRUCTION_FROM_MAIN_MEMORY
/*******************************************/
//module
module if_stage(
	//input contrl line 
	input 										clk, reset,enable, nop,
	input 		[`IF_ADDR_MODE_WIDTH-1:0] 		addr_mode,
	//output contrl line
	output 										done,
	//output reg data
	output 		[`INSTRUCTION_WIDTH-1:0] 		instruction,
	output reg 	[`REGISTER_WIDTH-1:0] 			current_pc_addr,
	output reg 									nop_statue, 
	output reg 	[`CORE_ERROR_WIDTH-1:0]			error_code,
	//input data path
	input 		[`REGISTER_WIDTH-1:0]			reg_addr_input,
	input	 		[`IMM_WIDTH-1:0]			imm_addr_input,
	//interface to main memory
	output		[`REGISTER_WIDTH-1:0] 			addr_to_main_memory,
	input		[`INSTRUCTION_WIDTH-1:0] 		inst_from_main_memory,
	input										main_memory_error
);
//If stage statue
	reg			[`IF_STATUE_WIDTH-1:0]			if_stage_statue;
//Cache inside
	reg 		[`REGISTER_WIDTH-1:0]  			instruction_cache[255:0];
//next out reg data line
	wire 		[`INSTRUCTION_WIDTH-1:0] 		__instruction;
	wire 		[`REGISTER_WIDTH-1:0] 			__next_pc_addr;
	wire 										__nop_statue;
	wire 		[`CORE_ERROR_WIDTH-1:0]  		__error_code;
//instruction reg
	reg  		[`INSTRUCTION_WIDTH-1:0]		__instruction_reg;
	
`ifdef USE_INSTRUCTION_FROM_MAIN_MEMORY
//register to store instruction from main memory
	reg  		[`INSTRUCTION_WIDTH-1:0]		__instruction_from_memory_reg;
`endif
//intermidiate wires
	wire 		[`REGISTER_WIDTH-1:0] 			__add_left,__add_right;
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
	assign __instruction 	= 	instruction_cache[__next_pc_addr[9:2]];//pc+4
	assign __nop_statue		= 	1'b0;//never make nop to ID
	assign done				= 	1'b1;

`ifdef USE_INSTRUCTION_FROM_MAIN_MEMORY
	assign instruction		= 	(if_stage_statue == `IF_STAGE_DISABLE)? __instruction_from_memory_reg :inst_from_main_memory;
`else
	assign instruction		= 	__instruction_reg;
`endif
//to main memory
	assign addr_to_main_memory	=	__next_pc_addr;
											
	
//Initialization
	initial begin
		__instruction_reg	= 		`INSTRUCTION_WIDTH'b0;
		current_pc_addr 	= 		`INSTRUCTION_START_ADDR;
		nop_statue			=		1'b1;
		error_code			=		`CORE_ERROR_NO;
		if_stage_statue		=		`IF_STAGE_IDLE;
	end

	//store some instructions for debuging
	initial begin
	instruction_cache[0] = {//lui x1, 20'habcde
		20'habcde,
		`x1,
		`U_TYPE_IMM
	};
	instruction_cache[1] = {//jalr x5, x0, 0
		12'h000,
		`x0,
		3'b0,
		`x7,
		`J_TYPE_JALR
	};
	instruction_cache[2] = `INSTRUCTION_WIDTH'd0;
	end
	
//Always block	
	always @(posedge clk) begin
		if(reset) begin
			__instruction_reg	<= 		`INSTRUCTION_WIDTH'b0;
			current_pc_addr 	<= 		`INSTRUCTION_START_ADDR;
			nop_statue			<=		1'b1;
			error_code			<=		`CORE_ERROR_NO;
			if_stage_statue		<=		`IF_STAGE_IDLE;
		end
		else begin //enable, nop
		
		`ifdef USE_INSTRUCTION_FROM_MAIN_MEMORY
			__instruction_from_memory_reg <= inst_from_main_memory;
		`endif
			if(enable & (~nop)) begin
				__instruction_reg	<= 		__instruction;
				current_pc_addr 	<= 		__next_pc_addr;
				nop_statue			<=		__nop_statue;
				error_code			<=		__error_code;
				if_stage_statue		<=		`IF_STAGE_WORK;
			end
			else begin
				if_stage_statue		<=		`IF_STAGE_DISABLE;
			end
		end
	end



endmodule
