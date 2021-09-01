// megafunction wizard: %RAM: 2-PORT%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: altsyncram 

// ============================================================
// File Name: ram_element.v
// Megafunction Name(s):
// 			altsyncram
//
// Simulation Library Files(s):
// 			altera_mf
// ============================================================
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//
// 13.0.1 Build 232 06/12/2013 SP 1 SJ Web Edition
// ************************************************************


//Copyright (C) 1991-2013 Altera Corporation
//Your use of Altera Corporation's design tools, logic functions 
//and other software and tools, and its AMPP partner logic 
//functions, and any output files from any of the foregoing 
//(including device programming or simulation files), and any 
//associated documentation or information are expressly subject 
//to the terms and conditions of the Altera Program License 
//Subscription Agreement, Altera MegaCore Function License 
//Agreement, or other applicable license agreement, including, 
//without limitation, that your use is for the sole purpose of 
//programming logic devices manufactured by Altera and sold by 
//Altera or its authorized distributors.  Please refer to the 
//applicable agreement for further details.


//altsyncram ADDRESS_REG_B="CLOCK0" CLOCK_ENABLE_INPUT_A="BYPASS" CLOCK_ENABLE_INPUT_B="BYPASS" CLOCK_ENABLE_OUTPUT_A="BYPASS" CLOCK_ENABLE_OUTPUT_B="BYPASS" DEVICE_FAMILY="Cyclone II" INDATA_REG_B="CLOCK0" INIT_FILE="ram.hex" NUMWORDS_A=256 NUMWORDS_B=256 OPERATION_MODE="BIDIR_DUAL_PORT" OUTDATA_ACLR_A="NONE" OUTDATA_ACLR_B="NONE" OUTDATA_REG_A="UNREGISTERED" OUTDATA_REG_B="UNREGISTERED" POWER_UP_UNINITIALIZED="FALSE" READ_DURING_WRITE_MODE_MIXED_PORTS="OLD_DATA" WIDTH_A=8 WIDTH_B=8 WIDTH_BYTEENA_A=1 WIDTH_BYTEENA_B=1 WIDTHAD_A=8 WIDTHAD_B=8 WRCONTROL_WRADDRESS_REG_B="CLOCK0" address_a address_b clock0 data_a data_b q_a q_b wren_a wren_b
//VERSION_BEGIN 13.0 cbx_altsyncram 2013:06:12:18:03:43:SJ cbx_cycloneii 2013:06:12:18:03:43:SJ cbx_lpm_add_sub 2013:06:12:18:03:43:SJ cbx_lpm_compare 2013:06:12:18:03:43:SJ cbx_lpm_decode 2013:06:12:18:03:43:SJ cbx_lpm_mux 2013:06:12:18:03:43:SJ cbx_mgl 2013:06:12:18:05:10:SJ cbx_stratix 2013:06:12:18:03:43:SJ cbx_stratixii 2013:06:12:18:03:43:SJ cbx_stratixiii 2013:06:12:18:03:43:SJ cbx_stratixv 2013:06:12:18:03:43:SJ cbx_util_mgl 2013:06:12:18:03:43:SJ  VERSION_END
// synthesis VERILOG_INPUT_VERSION VERILOG_2001
// altera message_off 10463


//synthesis_resources = M4K 1 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
(* ALTERA_ATTRIBUTE = {"OPTIMIZE_POWER_DURING_SYNTHESIS=NORMAL_COMPILATION"} *)
module  ram_element_altsyncram
	( 
	address_a,
	address_b,
	clock0,
	data_a,
	data_b,
	q_a,
	q_b,
	wren_a,
	wren_b) /* synthesis synthesis_clearbox=1 */;
	input   [7:0]  address_a;
	input   [7:0]  address_b;
	input   clock0;
	input   [7:0]  data_a;
	input   [7:0]  data_b;
	output   [7:0]  q_a;
	output   [7:0]  q_b;
	input   wren_a;
	input   wren_b;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri1   [7:0]  address_b;
	tri1   clock0;
	tri1   [7:0]  data_a;
	tri1   [7:0]  data_b;
	tri0   wren_a;
	tri0   wren_b;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	wire  [0:0]   wire_ram_block1a_0portadataout;
	wire  [0:0]   wire_ram_block1a_1portadataout;
	wire  [0:0]   wire_ram_block1a_2portadataout;
	wire  [0:0]   wire_ram_block1a_3portadataout;
	wire  [0:0]   wire_ram_block1a_4portadataout;
	wire  [0:0]   wire_ram_block1a_5portadataout;
	wire  [0:0]   wire_ram_block1a_6portadataout;
	wire  [0:0]   wire_ram_block1a_7portadataout;
	wire  [0:0]   wire_ram_block1a_0portbdataout;
	wire  [0:0]   wire_ram_block1a_1portbdataout;
	wire  [0:0]   wire_ram_block1a_2portbdataout;
	wire  [0:0]   wire_ram_block1a_3portbdataout;
	wire  [0:0]   wire_ram_block1a_4portbdataout;
	wire  [0:0]   wire_ram_block1a_5portbdataout;
	wire  [0:0]   wire_ram_block1a_6portbdataout;
	wire  [0:0]   wire_ram_block1a_7portbdataout;
	wire  [7:0]  address_a_wire;
	wire  [7:0]  address_b_wire;

	cycloneii_ram_block   ram_block1a_0
	( 
	.clk0(clock0),
	.portaaddr({address_a_wire[7:0]}),
	.portadatain({data_a[0]}),
	.portadataout(wire_ram_block1a_0portadataout[0:0]),
	.portawe(wren_a),
	.portbaddr({address_b_wire[7:0]}),
	.portbdatain({data_b[0]}),
	.portbdataout(wire_ram_block1a_0portbdataout[0:0]),
	.portbrewe(wren_b)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.clk1(1'b0),
	.clr0(1'b0),
	.clr1(1'b0),
	.ena0(1'b1),
	.ena1(1'b1),
	.portaaddrstall(1'b0),
	.portabyteenamasks({1{1'b1}}),
	.portbaddrstall(1'b0),
	.portbbyteenamasks({1{1'b1}})
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	// synopsys translate_off
	,
	.devclrn(1'b1),
	.devpor(1'b1)
	// synopsys translate_on
	);
	defparam
		ram_block1a_0.connectivity_checking = "OFF",
		ram_block1a_0.init_file = "ram.hex",
		ram_block1a_0.init_file_layout = "port_a",
		ram_block1a_0.logical_ram_name = "ALTSYNCRAM",
		ram_block1a_0.mem_init0 = 256'h0000000000000000000000000000000000000000000000000000000000000001,
		ram_block1a_0.mixed_port_feed_through_mode = "old",
		ram_block1a_0.operation_mode = "bidir_dual_port",
		ram_block1a_0.port_a_address_width = 8,
		ram_block1a_0.port_a_data_width = 1,
		ram_block1a_0.port_a_disable_ce_on_input_registers = "on",
		ram_block1a_0.port_a_disable_ce_on_output_registers = "on",
		ram_block1a_0.port_a_first_address = 0,
		ram_block1a_0.port_a_first_bit_number = 0,
		ram_block1a_0.port_a_last_address = 255,
		ram_block1a_0.port_a_logical_ram_depth = 256,
		ram_block1a_0.port_a_logical_ram_width = 8,
		ram_block1a_0.port_b_address_clock = "clock0",
		ram_block1a_0.port_b_address_width = 8,
		ram_block1a_0.port_b_data_in_clock = "clock0",
		ram_block1a_0.port_b_data_width = 1,
		ram_block1a_0.port_b_disable_ce_on_input_registers = "on",
		ram_block1a_0.port_b_disable_ce_on_output_registers = "on",
		ram_block1a_0.port_b_first_address = 0,
		ram_block1a_0.port_b_first_bit_number = 0,
		ram_block1a_0.port_b_last_address = 255,
		ram_block1a_0.port_b_logical_ram_depth = 256,
		ram_block1a_0.port_b_logical_ram_width = 8,
		ram_block1a_0.port_b_read_enable_write_enable_clock = "clock0",
		ram_block1a_0.power_up_uninitialized = "false",
		ram_block1a_0.ram_block_type = "AUTO",
		ram_block1a_0.lpm_type = "cycloneii_ram_block",
		ram_block1a_0.lpm_hint = "DONT_POWER_OPTIMIZE=ON";
	cycloneii_ram_block   ram_block1a_1
	( 
	.clk0(clock0),
	.portaaddr({address_a_wire[7:0]}),
	.portadatain({data_a[1]}),
	.portadataout(wire_ram_block1a_1portadataout[0:0]),
	.portawe(wren_a),
	.portbaddr({address_b_wire[7:0]}),
	.portbdatain({data_b[1]}),
	.portbdataout(wire_ram_block1a_1portbdataout[0:0]),
	.portbrewe(wren_b)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.clk1(1'b0),
	.clr0(1'b0),
	.clr1(1'b0),
	.ena0(1'b1),
	.ena1(1'b1),
	.portaaddrstall(1'b0),
	.portabyteenamasks({1{1'b1}}),
	.portbaddrstall(1'b0),
	.portbbyteenamasks({1{1'b1}})
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	// synopsys translate_off
	,
	.devclrn(1'b1),
	.devpor(1'b1)
	// synopsys translate_on
	);
	defparam
		ram_block1a_1.connectivity_checking = "OFF",
		ram_block1a_1.init_file = "ram.hex",
		ram_block1a_1.init_file_layout = "port_a",
		ram_block1a_1.logical_ram_name = "ALTSYNCRAM",
		ram_block1a_1.mem_init0 = 256'h0000000000000000000000000000000000000000000000000000000000000002,
		ram_block1a_1.mixed_port_feed_through_mode = "old",
		ram_block1a_1.operation_mode = "bidir_dual_port",
		ram_block1a_1.port_a_address_width = 8,
		ram_block1a_1.port_a_data_width = 1,
		ram_block1a_1.port_a_disable_ce_on_input_registers = "on",
		ram_block1a_1.port_a_disable_ce_on_output_registers = "on",
		ram_block1a_1.port_a_first_address = 0,
		ram_block1a_1.port_a_first_bit_number = 1,
		ram_block1a_1.port_a_last_address = 255,
		ram_block1a_1.port_a_logical_ram_depth = 256,
		ram_block1a_1.port_a_logical_ram_width = 8,
		ram_block1a_1.port_b_address_clock = "clock0",
		ram_block1a_1.port_b_address_width = 8,
		ram_block1a_1.port_b_data_in_clock = "clock0",
		ram_block1a_1.port_b_data_width = 1,
		ram_block1a_1.port_b_disable_ce_on_input_registers = "on",
		ram_block1a_1.port_b_disable_ce_on_output_registers = "on",
		ram_block1a_1.port_b_first_address = 0,
		ram_block1a_1.port_b_first_bit_number = 1,
		ram_block1a_1.port_b_last_address = 255,
		ram_block1a_1.port_b_logical_ram_depth = 256,
		ram_block1a_1.port_b_logical_ram_width = 8,
		ram_block1a_1.port_b_read_enable_write_enable_clock = "clock0",
		ram_block1a_1.power_up_uninitialized = "false",
		ram_block1a_1.ram_block_type = "AUTO",
		ram_block1a_1.lpm_type = "cycloneii_ram_block",
		ram_block1a_1.lpm_hint = "DONT_POWER_OPTIMIZE=ON";
	cycloneii_ram_block   ram_block1a_2
	( 
	.clk0(clock0),
	.portaaddr({address_a_wire[7:0]}),
	.portadatain({data_a[2]}),
	.portadataout(wire_ram_block1a_2portadataout[0:0]),
	.portawe(wren_a),
	.portbaddr({address_b_wire[7:0]}),
	.portbdatain({data_b[2]}),
	.portbdataout(wire_ram_block1a_2portbdataout[0:0]),
	.portbrewe(wren_b)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.clk1(1'b0),
	.clr0(1'b0),
	.clr1(1'b0),
	.ena0(1'b1),
	.ena1(1'b1),
	.portaaddrstall(1'b0),
	.portabyteenamasks({1{1'b1}}),
	.portbaddrstall(1'b0),
	.portbbyteenamasks({1{1'b1}})
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	// synopsys translate_off
	,
	.devclrn(1'b1),
	.devpor(1'b1)
	// synopsys translate_on
	);
	defparam
		ram_block1a_2.connectivity_checking = "OFF",
		ram_block1a_2.init_file = "ram.hex",
		ram_block1a_2.init_file_layout = "port_a",
		ram_block1a_2.logical_ram_name = "ALTSYNCRAM",
		ram_block1a_2.mem_init0 = 256'h0000000000000000000000000000000000000000000000000000000000000000,
		ram_block1a_2.mixed_port_feed_through_mode = "old",
		ram_block1a_2.operation_mode = "bidir_dual_port",
		ram_block1a_2.port_a_address_width = 8,
		ram_block1a_2.port_a_data_width = 1,
		ram_block1a_2.port_a_disable_ce_on_input_registers = "on",
		ram_block1a_2.port_a_disable_ce_on_output_registers = "on",
		ram_block1a_2.port_a_first_address = 0,
		ram_block1a_2.port_a_first_bit_number = 2,
		ram_block1a_2.port_a_last_address = 255,
		ram_block1a_2.port_a_logical_ram_depth = 256,
		ram_block1a_2.port_a_logical_ram_width = 8,
		ram_block1a_2.port_b_address_clock = "clock0",
		ram_block1a_2.port_b_address_width = 8,
		ram_block1a_2.port_b_data_in_clock = "clock0",
		ram_block1a_2.port_b_data_width = 1,
		ram_block1a_2.port_b_disable_ce_on_input_registers = "on",
		ram_block1a_2.port_b_disable_ce_on_output_registers = "on",
		ram_block1a_2.port_b_first_address = 0,
		ram_block1a_2.port_b_first_bit_number = 2,
		ram_block1a_2.port_b_last_address = 255,
		ram_block1a_2.port_b_logical_ram_depth = 256,
		ram_block1a_2.port_b_logical_ram_width = 8,
		ram_block1a_2.port_b_read_enable_write_enable_clock = "clock0",
		ram_block1a_2.power_up_uninitialized = "false",
		ram_block1a_2.ram_block_type = "AUTO",
		ram_block1a_2.lpm_type = "cycloneii_ram_block",
		ram_block1a_2.lpm_hint = "DONT_POWER_OPTIMIZE=ON";
	cycloneii_ram_block   ram_block1a_3
	( 
	.clk0(clock0),
	.portaaddr({address_a_wire[7:0]}),
	.portadatain({data_a[3]}),
	.portadataout(wire_ram_block1a_3portadataout[0:0]),
	.portawe(wren_a),
	.portbaddr({address_b_wire[7:0]}),
	.portbdatain({data_b[3]}),
	.portbdataout(wire_ram_block1a_3portbdataout[0:0]),
	.portbrewe(wren_b)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.clk1(1'b0),
	.clr0(1'b0),
	.clr1(1'b0),
	.ena0(1'b1),
	.ena1(1'b1),
	.portaaddrstall(1'b0),
	.portabyteenamasks({1{1'b1}}),
	.portbaddrstall(1'b0),
	.portbbyteenamasks({1{1'b1}})
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	// synopsys translate_off
	,
	.devclrn(1'b1),
	.devpor(1'b1)
	// synopsys translate_on
	);
	defparam
		ram_block1a_3.connectivity_checking = "OFF",
		ram_block1a_3.init_file = "ram.hex",
		ram_block1a_3.init_file_layout = "port_a",
		ram_block1a_3.logical_ram_name = "ALTSYNCRAM",
		ram_block1a_3.mem_init0 = 256'h0000000000000000000000000000000000000000000000000000000000000000,
		ram_block1a_3.mixed_port_feed_through_mode = "old",
		ram_block1a_3.operation_mode = "bidir_dual_port",
		ram_block1a_3.port_a_address_width = 8,
		ram_block1a_3.port_a_data_width = 1,
		ram_block1a_3.port_a_disable_ce_on_input_registers = "on",
		ram_block1a_3.port_a_disable_ce_on_output_registers = "on",
		ram_block1a_3.port_a_first_address = 0,
		ram_block1a_3.port_a_first_bit_number = 3,
		ram_block1a_3.port_a_last_address = 255,
		ram_block1a_3.port_a_logical_ram_depth = 256,
		ram_block1a_3.port_a_logical_ram_width = 8,
		ram_block1a_3.port_b_address_clock = "clock0",
		ram_block1a_3.port_b_address_width = 8,
		ram_block1a_3.port_b_data_in_clock = "clock0",
		ram_block1a_3.port_b_data_width = 1,
		ram_block1a_3.port_b_disable_ce_on_input_registers = "on",
		ram_block1a_3.port_b_disable_ce_on_output_registers = "on",
		ram_block1a_3.port_b_first_address = 0,
		ram_block1a_3.port_b_first_bit_number = 3,
		ram_block1a_3.port_b_last_address = 255,
		ram_block1a_3.port_b_logical_ram_depth = 256,
		ram_block1a_3.port_b_logical_ram_width = 8,
		ram_block1a_3.port_b_read_enable_write_enable_clock = "clock0",
		ram_block1a_3.power_up_uninitialized = "false",
		ram_block1a_3.ram_block_type = "AUTO",
		ram_block1a_3.lpm_type = "cycloneii_ram_block",
		ram_block1a_3.lpm_hint = "DONT_POWER_OPTIMIZE=ON";
	cycloneii_ram_block   ram_block1a_4
	( 
	.clk0(clock0),
	.portaaddr({address_a_wire[7:0]}),
	.portadatain({data_a[4]}),
	.portadataout(wire_ram_block1a_4portadataout[0:0]),
	.portawe(wren_a),
	.portbaddr({address_b_wire[7:0]}),
	.portbdatain({data_b[4]}),
	.portbdataout(wire_ram_block1a_4portbdataout[0:0]),
	.portbrewe(wren_b)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.clk1(1'b0),
	.clr0(1'b0),
	.clr1(1'b0),
	.ena0(1'b1),
	.ena1(1'b1),
	.portaaddrstall(1'b0),
	.portabyteenamasks({1{1'b1}}),
	.portbaddrstall(1'b0),
	.portbbyteenamasks({1{1'b1}})
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	// synopsys translate_off
	,
	.devclrn(1'b1),
	.devpor(1'b1)
	// synopsys translate_on
	);
	defparam
		ram_block1a_4.connectivity_checking = "OFF",
		ram_block1a_4.init_file = "ram.hex",
		ram_block1a_4.init_file_layout = "port_a",
		ram_block1a_4.logical_ram_name = "ALTSYNCRAM",
		ram_block1a_4.mem_init0 = 256'h0000000000000000000000000000000000000000000000000000000000000000,
		ram_block1a_4.mixed_port_feed_through_mode = "old",
		ram_block1a_4.operation_mode = "bidir_dual_port",
		ram_block1a_4.port_a_address_width = 8,
		ram_block1a_4.port_a_data_width = 1,
		ram_block1a_4.port_a_disable_ce_on_input_registers = "on",
		ram_block1a_4.port_a_disable_ce_on_output_registers = "on",
		ram_block1a_4.port_a_first_address = 0,
		ram_block1a_4.port_a_first_bit_number = 4,
		ram_block1a_4.port_a_last_address = 255,
		ram_block1a_4.port_a_logical_ram_depth = 256,
		ram_block1a_4.port_a_logical_ram_width = 8,
		ram_block1a_4.port_b_address_clock = "clock0",
		ram_block1a_4.port_b_address_width = 8,
		ram_block1a_4.port_b_data_in_clock = "clock0",
		ram_block1a_4.port_b_data_width = 1,
		ram_block1a_4.port_b_disable_ce_on_input_registers = "on",
		ram_block1a_4.port_b_disable_ce_on_output_registers = "on",
		ram_block1a_4.port_b_first_address = 0,
		ram_block1a_4.port_b_first_bit_number = 4,
		ram_block1a_4.port_b_last_address = 255,
		ram_block1a_4.port_b_logical_ram_depth = 256,
		ram_block1a_4.port_b_logical_ram_width = 8,
		ram_block1a_4.port_b_read_enable_write_enable_clock = "clock0",
		ram_block1a_4.power_up_uninitialized = "false",
		ram_block1a_4.ram_block_type = "AUTO",
		ram_block1a_4.lpm_type = "cycloneii_ram_block",
		ram_block1a_4.lpm_hint = "DONT_POWER_OPTIMIZE=ON";
	cycloneii_ram_block   ram_block1a_5
	( 
	.clk0(clock0),
	.portaaddr({address_a_wire[7:0]}),
	.portadatain({data_a[5]}),
	.portadataout(wire_ram_block1a_5portadataout[0:0]),
	.portawe(wren_a),
	.portbaddr({address_b_wire[7:0]}),
	.portbdatain({data_b[5]}),
	.portbdataout(wire_ram_block1a_5portbdataout[0:0]),
	.portbrewe(wren_b)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.clk1(1'b0),
	.clr0(1'b0),
	.clr1(1'b0),
	.ena0(1'b1),
	.ena1(1'b1),
	.portaaddrstall(1'b0),
	.portabyteenamasks({1{1'b1}}),
	.portbaddrstall(1'b0),
	.portbbyteenamasks({1{1'b1}})
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	// synopsys translate_off
	,
	.devclrn(1'b1),
	.devpor(1'b1)
	// synopsys translate_on
	);
	defparam
		ram_block1a_5.connectivity_checking = "OFF",
		ram_block1a_5.init_file = "ram.hex",
		ram_block1a_5.init_file_layout = "port_a",
		ram_block1a_5.logical_ram_name = "ALTSYNCRAM",
		ram_block1a_5.mem_init0 = 256'h0000000000000000000000000000000000000000000000000000000000000000,
		ram_block1a_5.mixed_port_feed_through_mode = "old",
		ram_block1a_5.operation_mode = "bidir_dual_port",
		ram_block1a_5.port_a_address_width = 8,
		ram_block1a_5.port_a_data_width = 1,
		ram_block1a_5.port_a_disable_ce_on_input_registers = "on",
		ram_block1a_5.port_a_disable_ce_on_output_registers = "on",
		ram_block1a_5.port_a_first_address = 0,
		ram_block1a_5.port_a_first_bit_number = 5,
		ram_block1a_5.port_a_last_address = 255,
		ram_block1a_5.port_a_logical_ram_depth = 256,
		ram_block1a_5.port_a_logical_ram_width = 8,
		ram_block1a_5.port_b_address_clock = "clock0",
		ram_block1a_5.port_b_address_width = 8,
		ram_block1a_5.port_b_data_in_clock = "clock0",
		ram_block1a_5.port_b_data_width = 1,
		ram_block1a_5.port_b_disable_ce_on_input_registers = "on",
		ram_block1a_5.port_b_disable_ce_on_output_registers = "on",
		ram_block1a_5.port_b_first_address = 0,
		ram_block1a_5.port_b_first_bit_number = 5,
		ram_block1a_5.port_b_last_address = 255,
		ram_block1a_5.port_b_logical_ram_depth = 256,
		ram_block1a_5.port_b_logical_ram_width = 8,
		ram_block1a_5.port_b_read_enable_write_enable_clock = "clock0",
		ram_block1a_5.power_up_uninitialized = "false",
		ram_block1a_5.ram_block_type = "AUTO",
		ram_block1a_5.lpm_type = "cycloneii_ram_block",
		ram_block1a_5.lpm_hint = "DONT_POWER_OPTIMIZE=ON";
	cycloneii_ram_block   ram_block1a_6
	( 
	.clk0(clock0),
	.portaaddr({address_a_wire[7:0]}),
	.portadatain({data_a[6]}),
	.portadataout(wire_ram_block1a_6portadataout[0:0]),
	.portawe(wren_a),
	.portbaddr({address_b_wire[7:0]}),
	.portbdatain({data_b[6]}),
	.portbdataout(wire_ram_block1a_6portbdataout[0:0]),
	.portbrewe(wren_b)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.clk1(1'b0),
	.clr0(1'b0),
	.clr1(1'b0),
	.ena0(1'b1),
	.ena1(1'b1),
	.portaaddrstall(1'b0),
	.portabyteenamasks({1{1'b1}}),
	.portbaddrstall(1'b0),
	.portbbyteenamasks({1{1'b1}})
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	// synopsys translate_off
	,
	.devclrn(1'b1),
	.devpor(1'b1)
	// synopsys translate_on
	);
	defparam
		ram_block1a_6.connectivity_checking = "OFF",
		ram_block1a_6.init_file = "ram.hex",
		ram_block1a_6.init_file_layout = "port_a",
		ram_block1a_6.logical_ram_name = "ALTSYNCRAM",
		ram_block1a_6.mem_init0 = 256'h0000000000000000000000000000000000000000000000000000000000000000,
		ram_block1a_6.mixed_port_feed_through_mode = "old",
		ram_block1a_6.operation_mode = "bidir_dual_port",
		ram_block1a_6.port_a_address_width = 8,
		ram_block1a_6.port_a_data_width = 1,
		ram_block1a_6.port_a_disable_ce_on_input_registers = "on",
		ram_block1a_6.port_a_disable_ce_on_output_registers = "on",
		ram_block1a_6.port_a_first_address = 0,
		ram_block1a_6.port_a_first_bit_number = 6,
		ram_block1a_6.port_a_last_address = 255,
		ram_block1a_6.port_a_logical_ram_depth = 256,
		ram_block1a_6.port_a_logical_ram_width = 8,
		ram_block1a_6.port_b_address_clock = "clock0",
		ram_block1a_6.port_b_address_width = 8,
		ram_block1a_6.port_b_data_in_clock = "clock0",
		ram_block1a_6.port_b_data_width = 1,
		ram_block1a_6.port_b_disable_ce_on_input_registers = "on",
		ram_block1a_6.port_b_disable_ce_on_output_registers = "on",
		ram_block1a_6.port_b_first_address = 0,
		ram_block1a_6.port_b_first_bit_number = 6,
		ram_block1a_6.port_b_last_address = 255,
		ram_block1a_6.port_b_logical_ram_depth = 256,
		ram_block1a_6.port_b_logical_ram_width = 8,
		ram_block1a_6.port_b_read_enable_write_enable_clock = "clock0",
		ram_block1a_6.power_up_uninitialized = "false",
		ram_block1a_6.ram_block_type = "AUTO",
		ram_block1a_6.lpm_type = "cycloneii_ram_block",
		ram_block1a_6.lpm_hint = "DONT_POWER_OPTIMIZE=ON";
	cycloneii_ram_block   ram_block1a_7
	( 
	.clk0(clock0),
	.portaaddr({address_a_wire[7:0]}),
	.portadatain({data_a[7]}),
	.portadataout(wire_ram_block1a_7portadataout[0:0]),
	.portawe(wren_a),
	.portbaddr({address_b_wire[7:0]}),
	.portbdatain({data_b[7]}),
	.portbdataout(wire_ram_block1a_7portbdataout[0:0]),
	.portbrewe(wren_b)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.clk1(1'b0),
	.clr0(1'b0),
	.clr1(1'b0),
	.ena0(1'b1),
	.ena1(1'b1),
	.portaaddrstall(1'b0),
	.portabyteenamasks({1{1'b1}}),
	.portbaddrstall(1'b0),
	.portbbyteenamasks({1{1'b1}})
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	// synopsys translate_off
	,
	.devclrn(1'b1),
	.devpor(1'b1)
	// synopsys translate_on
	);
	defparam
		ram_block1a_7.connectivity_checking = "OFF",
		ram_block1a_7.init_file = "ram.hex",
		ram_block1a_7.init_file_layout = "port_a",
		ram_block1a_7.logical_ram_name = "ALTSYNCRAM",
		ram_block1a_7.mem_init0 = 256'h0000000000000000000000000000000000000000000000000000000000000000,
		ram_block1a_7.mixed_port_feed_through_mode = "old",
		ram_block1a_7.operation_mode = "bidir_dual_port",
		ram_block1a_7.port_a_address_width = 8,
		ram_block1a_7.port_a_data_width = 1,
		ram_block1a_7.port_a_disable_ce_on_input_registers = "on",
		ram_block1a_7.port_a_disable_ce_on_output_registers = "on",
		ram_block1a_7.port_a_first_address = 0,
		ram_block1a_7.port_a_first_bit_number = 7,
		ram_block1a_7.port_a_last_address = 255,
		ram_block1a_7.port_a_logical_ram_depth = 256,
		ram_block1a_7.port_a_logical_ram_width = 8,
		ram_block1a_7.port_b_address_clock = "clock0",
		ram_block1a_7.port_b_address_width = 8,
		ram_block1a_7.port_b_data_in_clock = "clock0",
		ram_block1a_7.port_b_data_width = 1,
		ram_block1a_7.port_b_disable_ce_on_input_registers = "on",
		ram_block1a_7.port_b_disable_ce_on_output_registers = "on",
		ram_block1a_7.port_b_first_address = 0,
		ram_block1a_7.port_b_first_bit_number = 7,
		ram_block1a_7.port_b_last_address = 255,
		ram_block1a_7.port_b_logical_ram_depth = 256,
		ram_block1a_7.port_b_logical_ram_width = 8,
		ram_block1a_7.port_b_read_enable_write_enable_clock = "clock0",
		ram_block1a_7.power_up_uninitialized = "false",
		ram_block1a_7.ram_block_type = "AUTO",
		ram_block1a_7.lpm_type = "cycloneii_ram_block",
		ram_block1a_7.lpm_hint = "DONT_POWER_OPTIMIZE=ON";
	assign
		address_a_wire = address_a,
		address_b_wire = address_b,
		q_a = {wire_ram_block1a_7portadataout[0], wire_ram_block1a_6portadataout[0], wire_ram_block1a_5portadataout[0], wire_ram_block1a_4portadataout[0], wire_ram_block1a_3portadataout[0], wire_ram_block1a_2portadataout[0], wire_ram_block1a_1portadataout[0], wire_ram_block1a_0portadataout[0]},
		q_b = {wire_ram_block1a_7portbdataout[0], wire_ram_block1a_6portbdataout[0], wire_ram_block1a_5portbdataout[0], wire_ram_block1a_4portbdataout[0], wire_ram_block1a_3portbdataout[0], wire_ram_block1a_2portbdataout[0], wire_ram_block1a_1portbdataout[0], wire_ram_block1a_0portbdataout[0]};
endmodule //ram_element_altsyncram
//VALID FILE


// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module ram_element (
	address_a,
	address_b,
	clock,
	data_a,
	data_b,
	wren_a,
	wren_b,
	q_a,
	q_b)/* synthesis synthesis_clearbox = 1 */;

	input	[7:0]  address_a;
	input	[7:0]  address_b;
	input	  clock;
	input	[7:0]  data_a;
	input	[7:0]  data_b;
	input	  wren_a;
	input	  wren_b;
	output	[7:0]  q_a;
	output	[7:0]  q_b;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri1	  clock;
	tri0	  wren_a;
	tri0	  wren_b;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	wire [7:0] sub_wire0;
	wire [7:0] sub_wire1;
	wire [7:0] q_a = sub_wire0[7:0];
	wire [7:0] q_b = sub_wire1[7:0];

	ram_element_altsyncram	ram_element_altsyncram_component (
				.clock0 (clock),
				.wren_a (wren_a),
				.address_b (address_b),
				.data_b (data_b),
				.wren_b (wren_b),
				.address_a (address_a),
				.data_a (data_a),
				.q_a (sub_wire0),
				.q_b (sub_wire1));

endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: PRIVATE: ADDRESSSTALL_A NUMERIC "0"
// Retrieval info: PRIVATE: ADDRESSSTALL_B NUMERIC "0"
// Retrieval info: PRIVATE: BYTEENA_ACLR_A NUMERIC "0"
// Retrieval info: PRIVATE: BYTEENA_ACLR_B NUMERIC "0"
// Retrieval info: PRIVATE: BYTE_ENABLE_A NUMERIC "0"
// Retrieval info: PRIVATE: BYTE_ENABLE_B NUMERIC "0"
// Retrieval info: PRIVATE: BYTE_SIZE NUMERIC "8"
// Retrieval info: PRIVATE: BlankMemory NUMERIC "0"
// Retrieval info: PRIVATE: CLOCK_ENABLE_INPUT_A NUMERIC "0"
// Retrieval info: PRIVATE: CLOCK_ENABLE_INPUT_B NUMERIC "0"
// Retrieval info: PRIVATE: CLOCK_ENABLE_OUTPUT_A NUMERIC "0"
// Retrieval info: PRIVATE: CLOCK_ENABLE_OUTPUT_B NUMERIC "0"
// Retrieval info: PRIVATE: CLRdata NUMERIC "0"
// Retrieval info: PRIVATE: CLRq NUMERIC "0"
// Retrieval info: PRIVATE: CLRrdaddress NUMERIC "0"
// Retrieval info: PRIVATE: CLRrren NUMERIC "0"
// Retrieval info: PRIVATE: CLRwraddress NUMERIC "0"
// Retrieval info: PRIVATE: CLRwren NUMERIC "0"
// Retrieval info: PRIVATE: Clock NUMERIC "0"
// Retrieval info: PRIVATE: Clock_A NUMERIC "0"
// Retrieval info: PRIVATE: Clock_B NUMERIC "0"
// Retrieval info: PRIVATE: IMPLEMENT_IN_LES NUMERIC "0"
// Retrieval info: PRIVATE: INDATA_ACLR_B NUMERIC "0"
// Retrieval info: PRIVATE: INDATA_REG_B NUMERIC "1"
// Retrieval info: PRIVATE: INIT_FILE_LAYOUT STRING "PORT_A"
// Retrieval info: PRIVATE: INIT_TO_SIM_X NUMERIC "0"
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone II"
// Retrieval info: PRIVATE: JTAG_ENABLED NUMERIC "0"
// Retrieval info: PRIVATE: JTAG_ID STRING "NONE"
// Retrieval info: PRIVATE: MAXIMUM_DEPTH NUMERIC "0"
// Retrieval info: PRIVATE: MEMSIZE NUMERIC "2048"
// Retrieval info: PRIVATE: MEM_IN_BITS NUMERIC "0"
// Retrieval info: PRIVATE: MIFfilename STRING "ram.hex"
// Retrieval info: PRIVATE: OPERATION_MODE NUMERIC "3"
// Retrieval info: PRIVATE: OUTDATA_ACLR_B NUMERIC "0"
// Retrieval info: PRIVATE: OUTDATA_REG_B NUMERIC "0"
// Retrieval info: PRIVATE: RAM_BLOCK_TYPE NUMERIC "0"
// Retrieval info: PRIVATE: READ_DURING_WRITE_MODE_MIXED_PORTS NUMERIC "1"
// Retrieval info: PRIVATE: READ_DURING_WRITE_MODE_PORT_A NUMERIC "3"
// Retrieval info: PRIVATE: READ_DURING_WRITE_MODE_PORT_B NUMERIC "3"
// Retrieval info: PRIVATE: REGdata NUMERIC "1"
// Retrieval info: PRIVATE: REGq NUMERIC "0"
// Retrieval info: PRIVATE: REGrdaddress NUMERIC "0"
// Retrieval info: PRIVATE: REGrren NUMERIC "0"
// Retrieval info: PRIVATE: REGwraddress NUMERIC "1"
// Retrieval info: PRIVATE: REGwren NUMERIC "1"
// Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "1"
// Retrieval info: PRIVATE: USE_DIFF_CLKEN NUMERIC "0"
// Retrieval info: PRIVATE: UseDPRAM NUMERIC "1"
// Retrieval info: PRIVATE: VarWidth NUMERIC "0"
// Retrieval info: PRIVATE: WIDTH_READ_A NUMERIC "8"
// Retrieval info: PRIVATE: WIDTH_READ_B NUMERIC "8"
// Retrieval info: PRIVATE: WIDTH_WRITE_A NUMERIC "8"
// Retrieval info: PRIVATE: WIDTH_WRITE_B NUMERIC "8"
// Retrieval info: PRIVATE: WRADDR_ACLR_B NUMERIC "0"
// Retrieval info: PRIVATE: WRADDR_REG_B NUMERIC "1"
// Retrieval info: PRIVATE: WRCTRL_ACLR_B NUMERIC "0"
// Retrieval info: PRIVATE: enable NUMERIC "0"
// Retrieval info: PRIVATE: rden NUMERIC "0"
// Retrieval info: LIBRARY: altera_mf altera_mf.altera_mf_components.all
// Retrieval info: CONSTANT: ADDRESS_REG_B STRING "CLOCK0"
// Retrieval info: CONSTANT: CLOCK_ENABLE_INPUT_A STRING "BYPASS"
// Retrieval info: CONSTANT: CLOCK_ENABLE_INPUT_B STRING "BYPASS"
// Retrieval info: CONSTANT: CLOCK_ENABLE_OUTPUT_A STRING "BYPASS"
// Retrieval info: CONSTANT: CLOCK_ENABLE_OUTPUT_B STRING "BYPASS"
// Retrieval info: CONSTANT: INDATA_REG_B STRING "CLOCK0"
// Retrieval info: CONSTANT: INIT_FILE STRING "ram.hex"
// Retrieval info: CONSTANT: INTENDED_DEVICE_FAMILY STRING "Cyclone II"
// Retrieval info: CONSTANT: LPM_TYPE STRING "altsyncram"
// Retrieval info: CONSTANT: NUMWORDS_A NUMERIC "256"
// Retrieval info: CONSTANT: NUMWORDS_B NUMERIC "256"
// Retrieval info: CONSTANT: OPERATION_MODE STRING "BIDIR_DUAL_PORT"
// Retrieval info: CONSTANT: OUTDATA_ACLR_A STRING "NONE"
// Retrieval info: CONSTANT: OUTDATA_ACLR_B STRING "NONE"
// Retrieval info: CONSTANT: OUTDATA_REG_A STRING "UNREGISTERED"
// Retrieval info: CONSTANT: OUTDATA_REG_B STRING "UNREGISTERED"
// Retrieval info: CONSTANT: POWER_UP_UNINITIALIZED STRING "FALSE"
// Retrieval info: CONSTANT: READ_DURING_WRITE_MODE_MIXED_PORTS STRING "OLD_DATA"
// Retrieval info: CONSTANT: WIDTHAD_A NUMERIC "8"
// Retrieval info: CONSTANT: WIDTHAD_B NUMERIC "8"
// Retrieval info: CONSTANT: WIDTH_A NUMERIC "8"
// Retrieval info: CONSTANT: WIDTH_B NUMERIC "8"
// Retrieval info: CONSTANT: WIDTH_BYTEENA_A NUMERIC "1"
// Retrieval info: CONSTANT: WIDTH_BYTEENA_B NUMERIC "1"
// Retrieval info: CONSTANT: WRCONTROL_WRADDRESS_REG_B STRING "CLOCK0"
// Retrieval info: USED_PORT: address_a 0 0 8 0 INPUT NODEFVAL "address_a[7..0]"
// Retrieval info: USED_PORT: address_b 0 0 8 0 INPUT NODEFVAL "address_b[7..0]"
// Retrieval info: USED_PORT: clock 0 0 0 0 INPUT VCC "clock"
// Retrieval info: USED_PORT: data_a 0 0 8 0 INPUT NODEFVAL "data_a[7..0]"
// Retrieval info: USED_PORT: data_b 0 0 8 0 INPUT NODEFVAL "data_b[7..0]"
// Retrieval info: USED_PORT: q_a 0 0 8 0 OUTPUT NODEFVAL "q_a[7..0]"
// Retrieval info: USED_PORT: q_b 0 0 8 0 OUTPUT NODEFVAL "q_b[7..0]"
// Retrieval info: USED_PORT: wren_a 0 0 0 0 INPUT GND "wren_a"
// Retrieval info: USED_PORT: wren_b 0 0 0 0 INPUT GND "wren_b"
// Retrieval info: CONNECT: @address_a 0 0 8 0 address_a 0 0 8 0
// Retrieval info: CONNECT: @address_b 0 0 8 0 address_b 0 0 8 0
// Retrieval info: CONNECT: @clock0 0 0 0 0 clock 0 0 0 0
// Retrieval info: CONNECT: @data_a 0 0 8 0 data_a 0 0 8 0
// Retrieval info: CONNECT: @data_b 0 0 8 0 data_b 0 0 8 0
// Retrieval info: CONNECT: @wren_a 0 0 0 0 wren_a 0 0 0 0
// Retrieval info: CONNECT: @wren_b 0 0 0 0 wren_b 0 0 0 0
// Retrieval info: CONNECT: q_a 0 0 8 0 @q_a 0 0 8 0
// Retrieval info: CONNECT: q_b 0 0 8 0 @q_b 0 0 8 0
// Retrieval info: GEN_FILE: TYPE_NORMAL ram_element.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL ram_element.inc FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL ram_element.cmp FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL ram_element.bsf FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL ram_element_inst.v FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL ram_element_bb.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL ram_element_syn.v TRUE
// Retrieval info: LIB_FILE: altera_mf
