/*
*Auther:  		Chi Zhang
*Contact: 		chizhang@student.ethz.ch
*Date: 			2021/8/10
*Description:	main memory--a dual port RAM with 32-bit data and address width 
*/
`include "core.h"
`include "main_memory.h"
module main_memory(
	input clk,
	//porta
	input 	[`REGISTER_WIDTH-1:0] 		addr_a,
	output	[`REGISTER_WIDTH-1:0] 		data_out_a,
	output								error_a,
	//portb
	input								enable,
	input								write_en_b,
	input 	[`MEM_CTRL_WIDTH-1:0]		mem_ctrl_b,
	input	[`REGISTER_WIDTH-1:0]		addr_b,
	input	[`REGISTER_WIDTH-1:0]		data_in_b,
	output	[`REGISTER_WIDTH-1:0]		data_out_b,
	output								error_b,
	output								done_b,
	//debug
	output	[7:0]						debug_addr_b1,debug_addr_b2,debug_addr_b3,debug_addr_b4,
	output	[7:0]						debug_data_b1,debug_data_b2,debug_data_b3,debug_data_b4
);

	wire	[7:0]						__addr_a, __out_a1, __out_a2, __out_a3, __out_a4;
	
	wire	[7:0]						__addr_b[3:0];
	
	reg		[7:0]						__data_in_b[3:0];
	
	wire	[7:0]						__data_out_b[3:0];
	
	reg									__write_en_b[3:0];
	
	wire	[1:0]						b_h_w;
	
	wire								is_unsign;
	
	reg		[`REGISTER_WIDTH-1:0]		__data_out_b_all;
	
	assign	__addr_a				=		{addr_a[7:2],2'b00};
	assign	data_out_a 				=		{__out_a4,__out_a3,__out_a2,__out_a1};
	
	assign	__addr_b[0]				=		(addr_b[1:0]==2'b00)?		addr_b[7:0]:{addr_b[7:2],2'b00}+8'd4;
	assign	__addr_b[1]				=		(addr_b[1]==1'b0)?			{addr_b[7:2],2'b01}:{addr_b[7:2],2'b01}+8'd4;
	assign	__addr_b[2]				=		(addr_b[1:0]==2'b11)?		{addr_b[7:2],2'b10}+8'd4:{addr_b[7:2],2'b10};
	assign	__addr_b[3]				=									{addr_b[7:2],2'b11};
	
	assign	{is_unsign,b_h_w}		=		mem_ctrl_b;
	
	assign	data_out_b				=		write_en_b?	{`REGISTER_WIDTH{1'bx}}:__data_out_b_all;	
	
//debug
	assign 	debug_addr_b1			=		__addr_b[0];
	assign 	debug_addr_b2			=		__addr_b[1];
	assign 	debug_addr_b3			=		__addr_b[2];
	assign 	debug_addr_b4			=		__addr_b[3];
	assign	debug_data_b1			=		__data_out_b[0];
	assign	debug_data_b2			=		__data_out_b[1];
	assign	debug_data_b3			=		__data_out_b[2];
	assign	debug_data_b4			=		__data_out_b[3];
//Read done
	reg __read_done_b;//TODO
	initial	__read_done_b = 1'b0;
	always @(posedge clk) __read_done_b <= enable&(~write_en_b);
	assign	done_b = __read_done_b|write_en_b;
	
//Comb always
	always @(*) begin
		__write_en_b[0]=1'b0;
		__write_en_b[1]=1'b0;
		__write_en_b[2]=1'b0;
		__write_en_b[3]=1'b0;
		case (b_h_w)
			2'b00: begin
				//write
				__data_in_b[addr_b[1:0]]	=	data_in_b[7:0];
				__write_en_b[addr_b[1:0]]	=	1'b1&write_en_b;
				//read
				__data_out_b_all = {{(`REGISTER_WIDTH-`BYTE_LENGTH){(~is_unsign)&(__data_out_b[addr_b[1:0]][`BYTE_LENGTH-1])}},__data_out_b[addr_b[1:0]]};
			end
			2'b01: begin
				//write
				__data_in_b[addr_b[1:0]]	=	data_in_b[7:0];
				__data_in_b[addr_b[1:0]+2'd1]	=	data_in_b[15:8];
				__write_en_b[addr_b[1:0]]	=	1'b1&write_en_b;
				__write_en_b[addr_b[1:0]+2'd1]	=	1'b1&write_en_b;
				//read
				__data_out_b_all = {{(`REGISTER_WIDTH-2*`BYTE_LENGTH){(~is_unsign)&(__data_out_b[addr_b[1:0]+2'd1][`BYTE_LENGTH-1])}},__data_out_b[addr_b[1:0]+2'd1],__data_out_b[addr_b[1:0]]};
			end
			default: begin
				//write
				__data_in_b[addr_b[1:0]]	=	data_in_b[7:0];
				__data_in_b[addr_b[1:0]+2'd1]	=	data_in_b[15:8];
				__data_in_b[addr_b[1:0]+2'd2]	=	data_in_b[23:16];
				__data_in_b[addr_b[1:0]+2'd3]	=	data_in_b[31:24];
				__write_en_b[0]	=	1'b1&write_en_b;
				__write_en_b[1]	=	1'b1&write_en_b;
				__write_en_b[2]	=	1'b1&write_en_b;
				__write_en_b[3]	=	1'b1&write_en_b;
				//read
				__data_out_b_all = {	__data_out_b[addr_b[1:0]+2'd3],
											__data_out_b[addr_b[1:0]+2'd2],
											__data_out_b[addr_b[1:0]+2'd1],
											__data_out_b[addr_b[1:0]]};
			end
		endcase
	end

ram_element ram1(
	.clock(clk),
	.address_a(__addr_a),
	.data_a(8'b0),
	.wren_a(1'b0),
	.q_a(__out_a1),
	.address_b(__addr_b[0]),
	.data_b(__data_in_b[0]),
	.wren_b(__write_en_b[0]),
	.q_b(__data_out_b[0])
	);
	
ram_element ram2(
	.clock(clk),
	.address_a(__addr_a|2'b01),
	.data_a(8'b0),
	.wren_a(1'b0),
	.q_a(__out_a2),
	.address_b(__addr_b[1]),
	.data_b(__data_in_b[1]),
	.wren_b(__write_en_b[1]),
	.q_b(__data_out_b[1])
	);

ram_element ram3(
	.clock(clk),
	.address_a(__addr_a|2'b10),
	.data_a(8'b0),
	.wren_a(1'b0),
	.q_a(__out_a3),
	.address_b(__addr_b[2]),
	.data_b(__data_in_b[2]),
	.wren_b(__write_en_b[2]),
	.q_b(__data_out_b[2])
	);
	
ram_element ram4(
	.clock(clk),
	.address_a(__addr_a|2'b11),
	.data_a(8'b0),
	.wren_a(1'b0),
	.q_a(__out_a4),
	.address_b(__addr_b[3]),
	.data_b(__data_in_b[3]),
	.wren_b(__write_en_b[3]),
	.q_b(__data_out_b[3])
	);
	
endmodule

