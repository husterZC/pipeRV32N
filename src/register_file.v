`include "core.h"
`include "register_file.h"
module register_file(
	input clk,
	/*********READ**********/
	//input data path
	input [`CPU_REGISTER_INDEX_WIDTH-1:0]			rs1,
	input [`CPU_REGISTER_INDEX_WIDTH-1:0]			rs2,
	input [`CPU_REGISTER_INDEX_WIDTH-1:0]			rs3,
	//output data path
	output [`REGISTER_WIDTH-1:0]					rs1_data,
	output [`REGISTER_WIDTH-1:0]					rs2_data,
	output [`REGISTER_WIDTH-1:0]					rs3_data,
	/*********WRITE*********/
	input [`CPU_REGISTER_INDEX_WIDTH-1:0]			write_rd,
	input [`REGISTER_WIDTH-1:0]						data_in,
	input											write_en,
	//debug
	output [`REGISTER_WIDTH-1:0]					x0,x1,x2,x3,x4,x5,x6,x7
);
//Register file
	reg	[`REGISTER_WIDTH-1:0]						register_file_cluster[`REGISTER_FILE_NUMBER_OF_REG-1:0];	
//Combination circuit
	assign rs1_data	=	register_file_cluster[rs1];
	assign rs2_data	=	register_file_cluster[rs2];
	assign rs3_data	=	register_file_cluster[rs3];
	
	assign x0			= 	register_file_cluster[0];
	assign x1			= 	register_file_cluster[1];
	assign x2			= 	register_file_cluster[2];
	assign x3			= 	register_file_cluster[3];
	assign x4			= 	register_file_cluster[4];
	assign x5			= 	register_file_cluster[5];
	assign x6			= 	register_file_cluster[6];
	assign x7			= 	register_file_cluster[7];
//Initialization
initial begin
	register_file_cluster[0] = `REGISTER_WIDTH'b0;
	register_file_cluster[1] = `REGISTER_WIDTH'b0;
	register_file_cluster[2] = `REGISTER_WIDTH'b0;
	register_file_cluster[3] = `REGISTER_WIDTH'b0;
	register_file_cluster[4] = `REGISTER_WIDTH'b0;
	register_file_cluster[5] = `REGISTER_WIDTH'b0;
	register_file_cluster[6] = `REGISTER_WIDTH'b0;
	register_file_cluster[7] = `REGISTER_WIDTH'b0;
end

//Always	Block
	always @(posedge clk) begin
		if((write_en==1'b1) && (write_rd!=`CPU_REGISTER_INDEX_WIDTH'd0)) begin
			register_file_cluster[write_rd]	<=	data_in;
		end
	end

endmodule














