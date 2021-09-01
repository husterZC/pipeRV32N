`include "core.h"
`include "mem_cache.h"
module mem_cache(
	input									clk,
	input									enable,
	input									write_read,
	input 	[`MEM_CTRL_WIDTH-1:0]			mem_ctrl,
	input		[`REGISTER_WIDTH-1:0]		addr,
	input		[`REGISTER_WIDTH-1:0]		data_in,
	output									read_done,
	output									mem_error,
	output	[`REGISTER_WIDTH-1:0]			data_out,
	//debug
	output		[1:0]						b_h_w,
	output									is_unsign,
	output		[`BYTE_LENGTH-1:0]			data_byte1,data_byte2,data_byte3,data_byte4,
	output		[`FULL_ADDR_WIDTH-1:0]		real_addr,
	output		[`REGISTER_WIDTH-1:0]		data_from_mem
);
//Storage cell
	reg 		[`BYTE_LENGTH-1:0]			mem_cells[`NUMBER_OF_MEM_CELL-1:0];
//Combination circuit
	
	assign	real_addr				=		addr[`FULL_ADDR_WIDTH-1:0];
	assign	data_byte1				=		mem_cells[real_addr];
	assign	data_byte2				=		mem_cells[real_addr+1];
	assign	data_byte3				=		mem_cells[real_addr+2];
	assign	data_byte4				=		mem_cells[real_addr+3];
	
	assign	{is_unsign,b_h_w}		=		mem_ctrl;
	assign	mem_error				=		|addr[`REGISTER_WIDTH-1:`FULL_ADDR_WIDTH];

`ifdef USE_Little_Endian	
	assign	data_from_mem			=		(b_h_w==2'b00)?		{{(`REGISTER_WIDTH-`BYTE_LENGTH){(~is_unsign)&(data_byte1[`BYTE_LENGTH-1])}},data_byte1}:
											(b_h_w==2'b01)?		{{(`REGISTER_WIDTH-2*`BYTE_LENGTH){(~is_unsign)&(data_byte2[`BYTE_LENGTH-1])}},data_byte2,data_byte1}:
											(b_h_w==2'b10)?		{data_byte4,data_byte3,data_byte2,data_byte1}:
																				{`REGISTER_WIDTH{1'bx}};											
`else
	assign	data_from_mem			=		(b_h_w==2'b00)?		{{(`REGISTER_WIDTH-`BYTE_LENGTH){(~is_unsign)&(data_byte1[`BYTE_LENGTH-1])}},data_byte1}:
											(b_h_w==2'b01)?		{{(`REGISTER_WIDTH-2*`BYTE_LENGTH){(~is_unsign)&(data_byte1[`BYTE_LENGTH-1])}},data_byte1,data_byte2}:
											(b_h_w==2'b10)?		{data_byte1,data_byte2,data_byte3,data_byte4}:
																				{`REGISTER_WIDTH{1'bx}};
`endif
								
	assign 	data_out					=	(enable&(~write_read)&(~mem_error))?	data_from_mem:{`REGISTER_WIDTH{1'bx}};

	assign	read_done	=					1'b1;
	
//Initialization
	initial begin
		mem_cells[0]	=	`BYTE_LENGTH'd0;
		mem_cells[1]	=	`BYTE_LENGTH'd1;
		mem_cells[2]	=	`BYTE_LENGTH'd2;
		mem_cells[3]	=	`BYTE_LENGTH'd3;
		mem_cells[4]	=	`BYTE_LENGTH'd11;
		mem_cells[5]	=	`BYTE_LENGTH'd12;
		mem_cells[6]	=	`BYTE_LENGTH'd23;
		mem_cells[7]	=	`BYTE_LENGTH'd34;
		mem_cells[8]	=	`BYTE_LENGTH'ha1;
		mem_cells[9]	=	`BYTE_LENGTH'hb1;
		mem_cells[10]	=	`BYTE_LENGTH'hc1;
		mem_cells[11]	=	`BYTE_LENGTH'hd1;
	end

//always block													
	always @(posedge clk) begin
		if(enable&write_read&(~mem_error)) begin
		`ifdef USE_Little_Endian
			if(b_h_w==2'b00) begin
				mem_cells[real_addr] <= data_in[`BYTE_LENGTH-1:0];
			end
			else if(b_h_w==2'b01) begin
				mem_cells[real_addr] <= data_in[`BYTE_LENGTH-1:0];
				mem_cells[real_addr+1] <= data_in[2*`BYTE_LENGTH-1:`BYTE_LENGTH];
			end
			else if(b_h_w==2'b10) begin
				mem_cells[real_addr] <= data_in[`BYTE_LENGTH-1:0];
				mem_cells[real_addr+1] <= data_in[2*`BYTE_LENGTH-1:`BYTE_LENGTH];
				mem_cells[real_addr+2] <= data_in[3*`BYTE_LENGTH-1:2*`BYTE_LENGTH];
				mem_cells[real_addr+3] <= data_in[4*`BYTE_LENGTH-1:3*`BYTE_LENGTH];
			end
		`else
			if(b_h_w==2'b00) begin
				mem_cells[real_addr] <= data_in[`BYTE_LENGTH-1:0];
			end
			else if(b_h_w==2'b01) begin
				mem_cells[real_addr+1] <= data_in[`BYTE_LENGTH-1:0];
				mem_cells[real_addr] <= data_in[2*`BYTE_LENGTH-1:`BYTE_LENGTH];
			end
			else if(b_h_w==2'b10) begin
				mem_cells[real_addr+3] <= data_in[`BYTE_LENGTH-1:0];
				mem_cells[real_addr+2] <= data_in[2*`BYTE_LENGTH-1:`BYTE_LENGTH];
				mem_cells[real_addr+1] <= data_in[3*`BYTE_LENGTH-1:2*`BYTE_LENGTH];
				mem_cells[real_addr] <= data_in[4*`BYTE_LENGTH-1:3*`BYTE_LENGTH];
			end
		`endif
		end
	end
	

endmodule
