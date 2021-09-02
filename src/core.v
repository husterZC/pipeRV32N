/*
*Auther:  		Chi Zhang
*Contact: 		chizhang@student.ethz.ch
*Data: 			2021/8/13
*Description:	top level of pipeRV32N core
*/
`include "core.h"
module core(
	input clk, reset,
	//Debug wires showing on Modelsim
	/*if to id*/
	output [`INSTRUCTION_WIDTH-1:0] 					if_instruction,
	output [`REGISTER_WIDTH-1:0] 						if_current_pc_addr,
	output 												if_nop_statue,
	output [`CORE_ERROR_WIDTH-1:0]						if_error_code,
	/*id to ex*/
	output [`REGISTER_WIDTH-1:0] 						id_data_x,
	output								 				id_is_x_reg,
	output [`REGISTER_WIDTH-1:0] 						id_data_y,
	output 								 				id_is_y_reg,
	output [`CPU_REGISTER_INDEX_WIDTH-1:0]				id_dest,
	output [`ALU_CTRL_WIDTH-1:0]						id_alu_ctrl,
	output [`WB_CTRL_WIDTH-1:0]							id_wb_ctrl,	
	output [`MEM_CTRL_WIDTH-1:0]						id_mem_ctrl,
	output [`IMM_WIDTH-1:0] 							id_data_imm,
	output [`CPU_REGISTER_INDEX_WIDTH-1:0]				id_reg_extra,
	output 												id_nop_statue,
	output [`CORE_ERROR_WIDTH-1:0]						id_error_code,
	/*ex to wb/mem*/
	output [`REGISTER_WIDTH-1:0] 						ex_res,
	output [`CPU_REGISTER_INDEX_WIDTH-1:0]				ex_dest,
	output [`WB_CTRL_WIDTH-1:0]							ex_wb_ctrl,
	output [`MEM_CTRL_WIDTH-1:0]						ex_mem_ctrl,
	output [`IMM_WIDTH-1:0] 							ex_data_imm,
	output [`CPU_REGISTER_INDEX_WIDTH-1:0]				ex_reg_extra,
	output 												ex_nop_statue, 
	output [`CORE_ERROR_WIDTH-1:0]						ex_error_code,
	/*control line form stages*/
	output 												if_done,id_done,ex_done,wb_mem_done,
	output 												id_req_nop,id_req_jal,
	output 												wb_error_stop,wb_req,wb_req_jalr_branch,
	/*control line to stages*/
	output 												if_enable,id_enable,ex_enable,wb_mem_enable,
	output 												if_nop,id_nop,ex_nop,wb_mem_nop,
	output [`IF_ADDR_MODE_WIDTH-1:0] 					if_addr_mode,
	/*data monitoring */
	output [`CPU_REGISTER_INDEX_WIDTH-1:0]				ex_rs1,
	output [`CPU_REGISTER_INDEX_WIDTH-1:0]				ex_rs2,
	output												wb_register_file_write_en,
	output [`REGISTER_WIDTH-1:0]						a_x1,a_x2,a_x3,a_x4,a_x5,a_x6,a_x7,
	output [`REGISTER_WIDTH-1:0] 						if_addr_to_main_memory,
	output [`INSTRUCTION_WIDTH-1:0] 					if_inst_from_main_memory
);
	wire [`REGISTER_WIDTH-1:0]							if_reg_addr_to_if;
	wire [`IMM_WIDTH-1:0]								if_imm_addr_to_if;

	wire [`REGISTER_WIDTH-1:0] 							id_current_pc_addr;
	wire [`REGISTER_WIDTH-1:0] 							ex_current_pc_addr;
	wire [`IMM_WIDTH-1:0] 								imm_addr_from_id;
	wire [`IMM_WIDTH-1:0] 								imm_addr_from_wb;
	wire [`REGISTER_WIDTH-1:0]							wb_rs1_data;
	wire [`REGISTER_WIDTH-1:0]							wb_rs2_data;
	//interface to main memory
	wire												external_mem_enable;
	wire												external_mem_write_read;
	wire	[`REGISTER_WIDTH-1:0]						external_mem_data_from_mem;
	wire	[`REGISTER_WIDTH-1:0]						external_mem_data_to_mem;
	wire 	[`MEM_CTRL_WIDTH-1:0]						external_mem_ctrl;
	wire 	[`REGISTER_WIDTH-1:0] 						external_mem_addr;
	wire												external_mem_done;

//instance stages
if_stage		cpu_if_stage(
	//input contrl line 
	.clk(clk), 
	.reset(reset),
	.enable(if_enable), 
	.nop(if_nop),
	.addr_mode(if_addr_mode),
	//output contrl line
	.done(if_done),
	//output reg data
	.instruction(if_instruction),
	.current_pc_addr(if_current_pc_addr),
	.nop_statue(if_nop_statue), 
	.error_code(if_error_code),
	//input data path
	.reg_addr_input(if_reg_addr_to_if),
	.imm_addr_input(if_imm_addr_to_if),
	//interface to main memory
	.addr_to_main_memory(if_addr_to_main_memory),
	.inst_from_main_memory(if_inst_from_main_memory)
);

id_stage 	cpu_id_stage(
	//input contrl line 
	.clk(clk), 
	.reset(reset),
	.enable(id_enable), 
	.nop(id_nop),
	//output contrl line
	.done(id_done ),
	.req_nop(id_req_nop),
	.req_jal(id_req_jal),
	//output reg data
	.data_x(id_data_x),
	.is_x_reg(id_is_x_reg),
	.data_y(id_data_y),
	.is_y_reg(id_is_y_reg),
	.current_pc_addr(id_current_pc_addr),
	.dest(id_dest),
	.alu_ctrl(id_alu_ctrl),
	.wb_ctrl(id_wb_ctrl),	
	.mem_ctrl(id_mem_ctrl),
	.data_imm(id_data_imm),
	.reg_extra(id_reg_extra),
	.nop_statue(id_nop_statue), 
	.error_code(id_error_code),
	//output data path
	.imm_to_if(imm_addr_from_id),
	//input pipe data
	.if_instruction(if_instruction),
	.if_current_pc_addr(if_current_pc_addr),
	.if_nop_statue(if_nop_statue), 
	.if_error_code(if_error_code)
);

ex_stage 	cpu_ex_stage(
	//input contrl line 
	.clk(clk), 
	.reset(reset),
	.enable(ex_enable), 
	.nop(ex_nop),
	//output contrl line
	.done(ex_done),
	//output reg data
	.res(ex_res),
	.current_pc_addr(ex_current_pc_addr),
	.dest(ex_dest),
	.wb_ctrl(ex_wb_ctrl),	
	.mem_ctrl(ex_mem_ctrl),
	.data_imm(ex_data_imm ),
	.reg_extra(ex_reg_extra),
	.nop_statue(ex_nop_statue), 
	.error_code(ex_error_code),
	//output data path
	.rs1(ex_rs1),
	.rs2(ex_rs2),
	//input data path
	.rs1_data(wb_rs1_data),
	.rs2_data(wb_rs2_data),
	//input pipe data
	.id_data_x(id_data_x),
	.id_is_x_reg(id_is_x_reg),
	.id_data_y(id_data_y),
	.id_is_y_reg(id_is_y_reg),
	.id_current_pc_addr(id_current_pc_addr),
	.id_dest(id_dest),
	.id_alu_ctrl(id_alu_ctrl),
	.id_wb_ctrl(id_wb_ctrl),	
	.id_mem_ctrl(id_mem_ctrl),
	.id_data_imm(id_data_imm),
	.id_reg_extra(id_reg_extra),
	.id_nop_statue(id_nop_statue), 
	.id_error_code(id_error_code)
);

wb_mem_stage	cpu_wb_mem_stage(
	//input contrl line 
	.clk(clk), 
	.reset(reset),
	.enable(wb_mem_enable),
	//output contrl line
	.done(wb_mem_done),
	.error_stop(wb_error_stop),
	.wb_req(wb_req),
	.req_jalr_branch(wb_req_jalr_branch),
	//output data path
	.rs1_data(wb_rs1_data),
	.rs2_data(wb_rs2_data),
	.reg_addr_to_if(if_reg_addr_to_if),
	.imm_to_if(imm_addr_from_wb),
	//input data path
	.rs1(ex_rs1),
	.rs2(ex_rs2),
	//input pipe data
	.ex_res(ex_res),
	.ex_current_pc_addr(ex_current_pc_addr),
	.ex_dest(ex_dest),
	.ex_wb_ctrl(ex_wb_ctrl),	
	.ex_mem_ctrl(ex_mem_ctrl),
	.ex_data_imm(ex_data_imm),
	.ex_reg_extra(ex_reg_extra),
	.ex_nop_statue(ex_nop_statue), 
	.ex_error_code(ex_error_code),
	//interface to main memory
	.external_mem_enable(external_mem_enable),
	.external_mem_write_read(external_mem_write_read),
	.external_mem_data_from_mem(external_mem_data_from_mem),
	.external_mem_data_to_mem(external_mem_data_to_mem),
	.external_mem_ctrl(external_mem_ctrl),
	.external_mem_addr(external_mem_addr),
	.external_mem_done(external_mem_done),
	//debug output
	.register_file_write_en(wb_register_file_write_en),
	.x1(a_x1),
	.x2(a_x2),
	.x3(a_x3),
	.x4(a_x4),
	.x5(a_x5),
	.x6(a_x6),
	.x7(a_x7)
);

//Main memory
main_memory mm(
	.clk(clk),
	//porta
	.addr_a(if_addr_to_main_memory),
	.data_out_a(if_inst_from_main_memory),
	//portb
	.enable(external_mem_enable),
	.write_en_b(external_mem_write_read),
	.mem_ctrl_b(external_mem_ctrl),
	.addr_b(external_mem_addr),
	.data_in_b(external_mem_data_to_mem),
	.data_out_b(external_mem_data_from_mem),
	.done_b(external_mem_done)
);

//combination circuit
	assign if_imm_addr_to_if		=	wb_req?	imm_addr_from_wb: imm_addr_from_id;
	
	assign if_addr_mode				=	(wb_req&wb_req_jalr_branch)?		`IF_ADDR_MODE_REG_IMM:
										(wb_req&(~wb_req_jalr_branch))?		`IF_ADDR_MODE_REG_IMM:
										id_req_jal?							`IF_ADDR_MODE_PC_IMM:
																			`IF_ADDR_MODE_PC_4;
	
	assign if_enable				=	if_done & id_done & ex_done & wb_mem_done & (~wb_error_stop);
	assign id_enable				=	if_done & id_done & ex_done & wb_mem_done & (~wb_error_stop);
	assign ex_enable				=	if_done & id_done & ex_done & wb_mem_done & (~wb_error_stop);
	assign wb_mem_enable			=	if_done & id_done & ex_done & wb_mem_done & (~wb_error_stop);
	
	assign wb_mem_nop				=	1'b0;
	
	assign {if_nop,id_nop,ex_nop}	=	wb_req?		3'b011:
										id_req_nop?	3'b110:
													3'b000;
	

endmodule
