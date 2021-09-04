/*
*Auther:  		Chi Zhang
*Contact: 		chizhang@student.ethz.ch
*Date: 			2021/8/10
*Description:	memory and write back stage of pipeRV32N
*/
`include "core.h"

//Definition
`define WB_MEM_STAGE_STATUE_WIDTH	1
`define WB_MEM_STAGE_STATUE_NORMAL	`WB_MEM_STAGE_STATUE_WIDTH'b0
`define WB_MEM_STAGE_STATUE_WAIT	`WB_MEM_STAGE_STATUE_WIDTH'b1
//`define USE_EMBBED_MEM
/*************/

module wb_mem_stage(
	//input contrl line 
	input 											clk, reset,enable,
	//output contrl line
	output 											done,error_stop,wb_req,req_jalr_branch,
	//output data path
	output [`REGISTER_WIDTH-1:0]					rs1_data,
	output [`REGISTER_WIDTH-1:0]					rs2_data,
	output [`REGISTER_WIDTH-1:0]					reg_addr_to_if,
	output [`IMM_WIDTH-1:0]							imm_to_if,
	//input data path
	input [`CPU_REGISTER_INDEX_WIDTH-1:0]			rs1,
	input [`CPU_REGISTER_INDEX_WIDTH-1:0]			rs2,
	//input pipe data
	input [`REGISTER_WIDTH-1:0] 					ex_res,
	input [`REGISTER_WIDTH-1:0] 					ex_current_pc_addr,
	input [`CPU_REGISTER_INDEX_WIDTH-1:0]			ex_dest,
	input [`WB_CTRL_WIDTH-1:0]						ex_wb_ctrl,	
	input [`MEM_CTRL_WIDTH-1:0]						ex_mem_ctrl,
	input [`IMM_WIDTH-1:0] 							ex_data_imm,
	input [`CPU_REGISTER_INDEX_WIDTH-1:0]			ex_reg_extra,
	input 											ex_nop_statue, 
	input [`CORE_ERROR_WIDTH-1:0]					ex_error_code,
	//interface to external memory
	output											external_mem_enable,
	output											external_mem_write_read,
	input		[`REGISTER_WIDTH-1:0]				external_mem_data_from_mem,
	output	[`REGISTER_WIDTH-1:0]					external_mem_data_to_mem,
	output 	[`MEM_CTRL_WIDTH-1:0]					external_mem_ctrl,
	output 	[`REGISTER_WIDTH-1:0] 					external_mem_addr,
	input											external_mem_done,
	//debug output
	output											register_file_write_en,
	output											mem_enable,
	output											mem_write_read,
	output	[`REGISTER_WIDTH-1:0]					x0,x1,x2,x3,x4,x5,x6,x7,
	output	[`REGISTER_WIDTH-1:0]					data_to_register_file,
	output	[`REGISTER_WIDTH-1:0]					data_from_mem,
	output	[`REGISTER_WIDTH-1:0]					data_from_regfile
);
//Intermidiate wires
	wire		__mem_done;
	wire		embbed_mem_done;
//Register file
	register_file	cpu_register_file(
	.clk(clk),
	.rs1(rs1),
	.rs2(rs2),
	.rs3(ex_reg_extra),
	.rs1_data(rs1_data),
	.rs2_data(rs2_data),
	.rs3_data(data_from_regfile),
	.write_rd(ex_dest),
	.data_in(data_to_register_file),
	.write_en(register_file_write_en),
	.x0(x0),
	.x1(x1),
	.x2(x2),
	.x3(x3),
	.x4(x4),
	.x5(x5),
	.x6(x6),
	.x7(x7)
	);
	
`ifdef USE_EMBBED_MEM
//Main memory
main_memory mm(
	.clk(clk),
	//portb
	.enable(mem_enable),
	.write_en_b(mem_write_read),
	.mem_ctrl_b(ex_mem_ctrl),
	.addr_b(ex_res),
	.data_in_b(data_from_regfile),
	.data_out_b(data_from_mem),
	.done_b(embbed_mem_done)
);
`endif
//reg
	reg 		statue;

//Combination circuit
	assign 	imm_to_if					=	ex_data_imm;
	assign	reg_addr_to_if				=	((ex_wb_ctrl==`WB_CTRL_BEZ) || (ex_wb_ctrl==`WB_CTRL_BNZ))?	ex_current_pc_addr:
																																	data_from_regfile;
																															
	
	assign	error_stop					=	(ex_nop_statue==1'b0)&&(ex_error_code!=`CORE_ERROR_NO);
	
	assign	wb_req						=	((ex_nop_statue==1'b1)||(ex_error_code!=`CORE_ERROR_NO))?				1'b0:
											(ex_wb_ctrl==`WB_CTRL_JALR)?											1'b1:
											((ex_wb_ctrl==`WB_CTRL_BEZ)&&(ex_res==`REGISTER_WIDTH'b0))?				1'b1:
											((ex_wb_ctrl==`WB_CTRL_BNZ)&&(ex_res!=`REGISTER_WIDTH'b0))?				1'b1:
																													1'b0;
																																
	assign	req_jalr_branch				=	(ex_wb_ctrl==`WB_CTRL_JALR)?											1'b1:1'b0;
	
	
	assign	register_file_write_en		=	((ex_nop_statue==1'b1)||(ex_error_code!=`CORE_ERROR_NO))?				1'b0:
											(ex_wb_ctrl==`WB_CTRL_NORMAL)?											1'b1:
											(ex_wb_ctrl==`WB_CTRL_JALR)?											1'b1:
											(ex_wb_ctrl==`WB_CTRL_LOAD)?											1'b1:
																													1'b0;
`ifdef USE_EMBBED_MEM	
	assign	__mem_done					=	embbed_mem_done;
`else
	assign	__mem_done					=	external_mem_done;
`endif																														
	
	assign	mem_enable					=	(statue == `WB_MEM_STAGE_STATUE_WAIT)?									1'b0:
											((ex_nop_statue==1'b1)||(ex_error_code!=`CORE_ERROR_NO))?				1'b0:
											(ex_wb_ctrl==`WB_CTRL_LOAD)?											1'b1:
											(ex_wb_ctrl==`WB_CTRL_STORE)?											1'b1:
																													1'b0;
																																
	assign	mem_write_read				=	((ex_nop_statue==1'b1)||(ex_error_code!=`CORE_ERROR_NO))?				1'b0:
											(ex_wb_ctrl==`WB_CTRL_STORE)?											1'b1:
																													1'b0;
`ifdef USE_EMBBED_MEM																																
	assign	data_to_register_file		=	(ex_wb_ctrl==`WB_CTRL_LOAD)?					data_from_mem : ex_res;
`else
	assign	data_to_register_file		=	(ex_wb_ctrl==`WB_CTRL_LOAD)?					external_mem_data_from_mem : ex_res;
`endif
//wire to external memory
	assign	external_mem_enable			=	mem_enable;
	assign	external_mem_write_read		=	mem_write_read;
	assign	external_mem_data_to_mem	=	data_from_regfile;
	assign	external_mem_ctrl			=	ex_mem_ctrl;	
	assign	external_mem_addr			=	ex_res;
	
//sequence block
	initial 	statue = `WB_MEM_STAGE_STATUE_NORMAL;
	assign	done							=	(
														(
															(statue == `WB_MEM_STAGE_STATUE_NORMAL) 	&&
															(ex_nop_statue==1'b0)							&&
															(ex_error_code==`CORE_ERROR_NO)				&&
															(
																(ex_wb_ctrl==`WB_CTRL_LOAD)					||
																(ex_wb_ctrl==`WB_CTRL_STORE)					
															)&&
															(__mem_done==1'b0)
														)||
														(
															(statue == `WB_MEM_STAGE_STATUE_WAIT) 	&&
															(__mem_done==1'b0)
														)
													)?	1'b0:1'b1;
	always @(posedge clk) begin
		if(
				(statue == `WB_MEM_STAGE_STATUE_NORMAL) 	&&
				(ex_nop_statue==1'b0)							&&
				(ex_error_code==`CORE_ERROR_NO)				&&
					(
						(ex_wb_ctrl==`WB_CTRL_LOAD)					||
						(ex_wb_ctrl==`WB_CTRL_STORE)					
					)&&
				(__mem_done==1'b0)
			) statue <= `WB_MEM_STAGE_STATUE_WAIT;
		else if (
						(statue == `WB_MEM_STAGE_STATUE_WAIT) 	&&
						(__mem_done==1'b1)
					) statue <= `WB_MEM_STAGE_STATUE_NORMAL;
	end
	
	

endmodule
