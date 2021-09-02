/*
*Auther:  		Chi Zhang
*Contact: 		chizhang@student.ethz.ch
*/
`ifndef _CORE_H
`define _CORE_H

/*****************************************************************************************************************
******************************Interface definition****************************************************************
*****************************************************************************************************************/

//data width
`define INSTRUCTION_WIDTH 	32
`define REGISTER_WIDTH 		32
`define IMM_WIDTH				32

//error code
`define CORE_ERROR_WIDTH	2
`define CORE_ERROR_NO			`CORE_ERROR_WIDTH'd0
`define CORE_ERROR_IF			`CORE_ERROR_WIDTH'd1
`define CORE_ERROR_ID			`CORE_ERROR_WIDTH'd2
`define CORE_ERROR_EX			`CORE_ERROR_WIDTH'd3

/**********IF stage**************/
`define IF_ADDR_MODE_WIDTH		2
`define IF_ADDR_MODE_PC_4			`IF_ADDR_MODE_WIDTH'd0
`define IF_ADDR_MODE_PC_IMM		`IF_ADDR_MODE_WIDTH'd1
`define IF_ADDR_MODE_REG_IMM		`IF_ADDR_MODE_WIDTH'd2
`define IF_ADDR_MODE_REG_TO_PC	`IF_ADDR_MODE_WIDTH'd3

/**********ID stage**************/
//opcode list
`define B_TYPE			7'b1100011
`define S_TYPE			7'b0100011
`define R_TYPE			7'b0110011
`define U_TYPE_IMM	7'b0110111
`define U_TYPE_AUIPC	7'b0010111
`define J_TYPE_JAL	7'b1101111
`define J_TYPE_JALR	7'b1100111
`define I_TYPE_LOAD	7'b0000011
`define I_TYPE_CALC	7'b0010011
`define I_TYPE_FENCE	7'b0001111
`define I_TYPE_SYS	7'b1110011

/**********EX stage**************/
`define ALU_CTRL_WIDTH 4
//ALU_CTRL_2_0
`define ALU_ADD 	3'b000
`define ALU_SLL 	3'b001
`define ALU_SLT 	3'b010
`define ALU_SLTU 	3'b011
`define ALU_XOR 	3'b100
`define ALU_SHR 	3'b101
`define ALU_OR	 	3'b110
`define ALU_AND 	3'b111

//ALU_SUB_MODE_3
`define ALU_NOR_MODE  			1'b0
`define ALU_SUB_OR_ARTH_MODE  1'b1


/**********MEM/WB stage**************/
`define MEM_CTRL_WIDTH			3

`define WB_CTRL_WIDTH			3
`define WB_CTRL_NORMAL			`WB_CTRL_WIDTH'd0
`define WB_CTRL_JALR				`WB_CTRL_WIDTH'd1
`define WB_CTRL_LOAD				`WB_CTRL_WIDTH'd2
`define WB_CTRL_STORE			`WB_CTRL_WIDTH'd3
`define WB_CTRL_BEZ				`WB_CTRL_WIDTH'd4
`define WB_CTRL_BNZ				`WB_CTRL_WIDTH'd5

/**********Register File**************/
`define CPU_REGISTER_INDEX_WIDTH		3



`endif