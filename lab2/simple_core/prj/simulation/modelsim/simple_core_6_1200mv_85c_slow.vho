-- Copyright (C) 1991-2015 Altera Corporation. All rights reserved.
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, the Altera Quartus II License Agreement,
-- the Altera MegaCore Function License Agreement, or other 
-- applicable license agreement, including, without limitation, 
-- that your use is for the sole purpose of programming logic 
-- devices manufactured by Altera and sold by Altera or its 
-- authorized distributors.  Please refer to the applicable 
-- agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus II 64-Bit"
-- VERSION "Version 15.0.0 Build 145 04/22/2015 SJ Full Version"

-- DATE "01/25/2016 12:55:15"

-- 
-- Device: Altera EP4CE40F29C6 Package FBGA780
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY CYCLONEIVE;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE CYCLONEIVE.CYCLONEIVE_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	simple_core IS
    PORT (
	clk : IN std_logic;
	n_reset : IN std_logic;
	alu_result_o : OUT std_logic_vector(31 DOWNTO 0);
	alu_result_valid_o : OUT std_logic;
	stop_o : OUT std_logic
	);
END simple_core;

-- Design Ports Information
-- alu_result_o[0]	=>  Location: PIN_A22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu_result_o[1]	=>  Location: PIN_E18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu_result_o[2]	=>  Location: PIN_F17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu_result_o[3]	=>  Location: PIN_J17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu_result_o[4]	=>  Location: PIN_C20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu_result_o[5]	=>  Location: PIN_C17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu_result_o[6]	=>  Location: PIN_H15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu_result_o[7]	=>  Location: PIN_A18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu_result_o[8]	=>  Location: PIN_B19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu_result_o[9]	=>  Location: PIN_D18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu_result_o[10]	=>  Location: PIN_G18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu_result_o[11]	=>  Location: PIN_D15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu_result_o[12]	=>  Location: PIN_A17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu_result_o[13]	=>  Location: PIN_H14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu_result_o[14]	=>  Location: PIN_J14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu_result_o[15]	=>  Location: PIN_H17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu_result_o[16]	=>  Location: PIN_G17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu_result_o[17]	=>  Location: PIN_K15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu_result_o[18]	=>  Location: PIN_C19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu_result_o[19]	=>  Location: PIN_C15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu_result_o[20]	=>  Location: PIN_F15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu_result_o[21]	=>  Location: PIN_B17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu_result_o[22]	=>  Location: PIN_H16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu_result_o[23]	=>  Location: PIN_G16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu_result_o[24]	=>  Location: PIN_J16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu_result_o[25]	=>  Location: PIN_D16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu_result_o[26]	=>  Location: PIN_D20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu_result_o[27]	=>  Location: PIN_A19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu_result_o[28]	=>  Location: PIN_C16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu_result_o[29]	=>  Location: PIN_B18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu_result_o[30]	=>  Location: PIN_G15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu_result_o[31]	=>  Location: PIN_E17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu_result_valid_o	=>  Location: PIN_B21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- stop_o	=>  Location: PIN_A21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clk	=>  Location: PIN_J1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- n_reset	=>  Location: PIN_D17,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF simple_core IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_clk : std_logic;
SIGNAL ww_n_reset : std_logic;
SIGNAL ww_alu_result_o : std_logic_vector(31 DOWNTO 0);
SIGNAL ww_alu_result_valid_o : std_logic;
SIGNAL ww_stop_o : std_logic;
SIGNAL \clk~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \alu_result_o[0]~output_o\ : std_logic;
SIGNAL \alu_result_o[1]~output_o\ : std_logic;
SIGNAL \alu_result_o[2]~output_o\ : std_logic;
SIGNAL \alu_result_o[3]~output_o\ : std_logic;
SIGNAL \alu_result_o[4]~output_o\ : std_logic;
SIGNAL \alu_result_o[5]~output_o\ : std_logic;
SIGNAL \alu_result_o[6]~output_o\ : std_logic;
SIGNAL \alu_result_o[7]~output_o\ : std_logic;
SIGNAL \alu_result_o[8]~output_o\ : std_logic;
SIGNAL \alu_result_o[9]~output_o\ : std_logic;
SIGNAL \alu_result_o[10]~output_o\ : std_logic;
SIGNAL \alu_result_o[11]~output_o\ : std_logic;
SIGNAL \alu_result_o[12]~output_o\ : std_logic;
SIGNAL \alu_result_o[13]~output_o\ : std_logic;
SIGNAL \alu_result_o[14]~output_o\ : std_logic;
SIGNAL \alu_result_o[15]~output_o\ : std_logic;
SIGNAL \alu_result_o[16]~output_o\ : std_logic;
SIGNAL \alu_result_o[17]~output_o\ : std_logic;
SIGNAL \alu_result_o[18]~output_o\ : std_logic;
SIGNAL \alu_result_o[19]~output_o\ : std_logic;
SIGNAL \alu_result_o[20]~output_o\ : std_logic;
SIGNAL \alu_result_o[21]~output_o\ : std_logic;
SIGNAL \alu_result_o[22]~output_o\ : std_logic;
SIGNAL \alu_result_o[23]~output_o\ : std_logic;
SIGNAL \alu_result_o[24]~output_o\ : std_logic;
SIGNAL \alu_result_o[25]~output_o\ : std_logic;
SIGNAL \alu_result_o[26]~output_o\ : std_logic;
SIGNAL \alu_result_o[27]~output_o\ : std_logic;
SIGNAL \alu_result_o[28]~output_o\ : std_logic;
SIGNAL \alu_result_o[29]~output_o\ : std_logic;
SIGNAL \alu_result_o[30]~output_o\ : std_logic;
SIGNAL \alu_result_o[31]~output_o\ : std_logic;
SIGNAL \alu_result_valid_o~output_o\ : std_logic;
SIGNAL \stop_o~output_o\ : std_logic;
SIGNAL \clk~input_o\ : std_logic;
SIGNAL \clk~inputclkctrl_outclk\ : std_logic;
SIGNAL \n_reset~input_o\ : std_logic;
SIGNAL \pc[1]~2_combout\ : std_logic;
SIGNAL \pc[2]~3_combout\ : std_logic;
SIGNAL \pc[0]~1_combout\ : std_logic;
SIGNAL \imem|Mux4~0_combout\ : std_logic;
SIGNAL \alu|Add0~12_combout\ : std_logic;
SIGNAL \imem|Mux7~0_combout\ : std_logic;
SIGNAL \imem|Mux1~0_combout\ : std_logic;
SIGNAL \imem|Mux0~0_combout\ : std_logic;
SIGNAL \alu|Add0~14_cout\ : std_logic;
SIGNAL \alu|Add0~15_combout\ : std_logic;
SIGNAL \alu|Add0~28_combout\ : std_logic;
SIGNAL \alu_result_o[0]~reg0_q\ : std_logic;
SIGNAL \imem|Mux6~0_combout\ : std_logic;
SIGNAL \alu|Equal0~0_combout\ : std_logic;
SIGNAL \alu|Add0~16\ : std_logic;
SIGNAL \alu|Add0~17_combout\ : std_logic;
SIGNAL \alu|Add0~29_combout\ : std_logic;
SIGNAL \alu_result_o[1]~reg0_q\ : std_logic;
SIGNAL \imem|Mux3~0_combout\ : std_logic;
SIGNAL \alu|Add0~18\ : std_logic;
SIGNAL \alu|Add0~19_combout\ : std_logic;
SIGNAL \alu|Add0~30_combout\ : std_logic;
SIGNAL \alu_result_o[2]~reg0_q\ : std_logic;
SIGNAL \imem|Mux5~0_combout\ : std_logic;
SIGNAL \imem|Mux2~0_combout\ : std_logic;
SIGNAL \alu|Add0~21_combout\ : std_logic;
SIGNAL \alu|Add0~20\ : std_logic;
SIGNAL \alu|Add0~22_combout\ : std_logic;
SIGNAL \alu|Add0~31_combout\ : std_logic;
SIGNAL \alu_result_o[3]~reg0_q\ : std_logic;
SIGNAL \alu|Add0~23\ : std_logic;
SIGNAL \alu|Add0~24_combout\ : std_logic;
SIGNAL \alu|Add0~32_combout\ : std_logic;
SIGNAL \alu_result_o[4]~reg0_q\ : std_logic;
SIGNAL \alu|Add0~25\ : std_logic;
SIGNAL \alu|Add0~26_combout\ : std_logic;
SIGNAL \alu|Add0~33_combout\ : std_logic;
SIGNAL \alu_result_o[5]~reg0feeder_combout\ : std_logic;
SIGNAL \alu_result_o[5]~reg0_q\ : std_logic;
SIGNAL \alu_result_o[6]~reg0feeder_combout\ : std_logic;
SIGNAL \alu_result_o[6]~reg0_q\ : std_logic;
SIGNAL \alu_result_o[7]~reg0feeder_combout\ : std_logic;
SIGNAL \alu_result_o[7]~reg0_q\ : std_logic;
SIGNAL \alu_result_o[8]~reg0feeder_combout\ : std_logic;
SIGNAL \alu_result_o[8]~reg0_q\ : std_logic;
SIGNAL \alu_result_o[9]~reg0feeder_combout\ : std_logic;
SIGNAL \alu_result_o[9]~reg0_q\ : std_logic;
SIGNAL \alu_result_o[10]~reg0feeder_combout\ : std_logic;
SIGNAL \alu_result_o[10]~reg0_q\ : std_logic;
SIGNAL \alu_result_o[11]~reg0feeder_combout\ : std_logic;
SIGNAL \alu_result_o[11]~reg0_q\ : std_logic;
SIGNAL \alu_result_o[12]~reg0feeder_combout\ : std_logic;
SIGNAL \alu_result_o[12]~reg0_q\ : std_logic;
SIGNAL \alu_result_o[13]~reg0feeder_combout\ : std_logic;
SIGNAL \alu_result_o[13]~reg0_q\ : std_logic;
SIGNAL \alu_result_o[14]~reg0feeder_combout\ : std_logic;
SIGNAL \alu_result_o[14]~reg0_q\ : std_logic;
SIGNAL \alu_result_o[15]~reg0feeder_combout\ : std_logic;
SIGNAL \alu_result_o[15]~reg0_q\ : std_logic;
SIGNAL \alu_result_o[16]~reg0_q\ : std_logic;
SIGNAL \alu_result_o[17]~reg0_q\ : std_logic;
SIGNAL \alu_result_o[18]~reg0feeder_combout\ : std_logic;
SIGNAL \alu_result_o[18]~reg0_q\ : std_logic;
SIGNAL \alu_result_o[19]~reg0feeder_combout\ : std_logic;
SIGNAL \alu_result_o[19]~reg0_q\ : std_logic;
SIGNAL \alu_result_o[20]~reg0feeder_combout\ : std_logic;
SIGNAL \alu_result_o[20]~reg0_q\ : std_logic;
SIGNAL \alu_result_o[21]~reg0feeder_combout\ : std_logic;
SIGNAL \alu_result_o[21]~reg0_q\ : std_logic;
SIGNAL \alu_result_o[22]~reg0_q\ : std_logic;
SIGNAL \alu_result_o[23]~reg0_q\ : std_logic;
SIGNAL \alu_result_o[24]~reg0_q\ : std_logic;
SIGNAL \alu_result_o[25]~reg0feeder_combout\ : std_logic;
SIGNAL \alu_result_o[25]~reg0_q\ : std_logic;
SIGNAL \alu_result_o[26]~reg0feeder_combout\ : std_logic;
SIGNAL \alu_result_o[26]~reg0_q\ : std_logic;
SIGNAL \alu_result_o[27]~reg0_q\ : std_logic;
SIGNAL \alu_result_o[28]~reg0feeder_combout\ : std_logic;
SIGNAL \alu_result_o[28]~reg0_q\ : std_logic;
SIGNAL \alu_result_o[29]~reg0feeder_combout\ : std_logic;
SIGNAL \alu_result_o[29]~reg0_q\ : std_logic;
SIGNAL \alu_result_o[30]~reg0feeder_combout\ : std_logic;
SIGNAL \alu_result_o[30]~reg0_q\ : std_logic;
SIGNAL \alu_result_o[31]~reg0_q\ : std_logic;
SIGNAL \pc[2]~0_combout\ : std_logic;
SIGNAL \alu_result_valid_o~reg0_q\ : std_logic;
SIGNAL \alu|Equal0~1_combout\ : std_logic;
SIGNAL \stop_o~reg0_q\ : std_logic;
SIGNAL regFile_to_ALU2 : std_logic_vector(31 DOWNTO 0);
SIGNAL pc : std_logic_vector(2 DOWNTO 0);
SIGNAL regFile_to_ALU1 : std_logic_vector(31 DOWNTO 0);
SIGNAL inst_to_regFile2 : std_logic_vector(3 DOWNTO 0);
SIGNAL inst_to_regFile1 : std_logic_vector(3 DOWNTO 0);

BEGIN

ww_clk <= clk;
ww_n_reset <= n_reset;
alu_result_o <= ww_alu_result_o;
alu_result_valid_o <= ww_alu_result_valid_o;
stop_o <= ww_stop_o;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\clk~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \clk~input_o\);

-- Location: IOOBUF_X52_Y43_N2
\alu_result_o[0]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \alu_result_o[0]~reg0_q\,
	devoe => ww_devoe,
	o => \alu_result_o[0]~output_o\);

-- Location: IOOBUF_X52_Y43_N23
\alu_result_o[1]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \alu_result_o[1]~reg0_q\,
	devoe => ww_devoe,
	o => \alu_result_o[1]~output_o\);

-- Location: IOOBUF_X48_Y43_N30
\alu_result_o[2]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \alu_result_o[2]~reg0_q\,
	devoe => ww_devoe,
	o => \alu_result_o[2]~output_o\);

-- Location: IOOBUF_X43_Y43_N16
\alu_result_o[3]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \alu_result_o[3]~reg0_q\,
	devoe => ww_devoe,
	o => \alu_result_o[3]~output_o\);

-- Location: IOOBUF_X50_Y43_N9
\alu_result_o[4]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \alu_result_o[4]~reg0_q\,
	devoe => ww_devoe,
	o => \alu_result_o[4]~output_o\);

-- Location: IOOBUF_X48_Y43_N9
\alu_result_o[5]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \alu_result_o[5]~reg0_q\,
	devoe => ww_devoe,
	o => \alu_result_o[5]~output_o\);

-- Location: IOOBUF_X48_Y43_N23
\alu_result_o[6]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \alu_result_o[6]~reg0_q\,
	devoe => ww_devoe,
	o => \alu_result_o[6]~output_o\);

-- Location: IOOBUF_X45_Y43_N23
\alu_result_o[7]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \alu_result_o[7]~reg0_q\,
	devoe => ww_devoe,
	o => \alu_result_o[7]~output_o\);

-- Location: IOOBUF_X45_Y43_N16
\alu_result_o[8]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \alu_result_o[8]~reg0_q\,
	devoe => ww_devoe,
	o => \alu_result_o[8]~output_o\);

-- Location: IOOBUF_X50_Y43_N2
\alu_result_o[9]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \alu_result_o[9]~reg0_q\,
	devoe => ww_devoe,
	o => \alu_result_o[9]~output_o\);

-- Location: IOOBUF_X48_Y43_N16
\alu_result_o[10]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \alu_result_o[10]~reg0_q\,
	devoe => ww_devoe,
	o => \alu_result_o[10]~output_o\);

-- Location: IOOBUF_X36_Y43_N23
\alu_result_o[11]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \alu_result_o[11]~reg0_q\,
	devoe => ww_devoe,
	o => \alu_result_o[11]~output_o\);

-- Location: IOOBUF_X38_Y43_N23
\alu_result_o[12]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \alu_result_o[12]~reg0_q\,
	devoe => ww_devoe,
	o => \alu_result_o[12]~output_o\);

-- Location: IOOBUF_X38_Y43_N9
\alu_result_o[13]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \alu_result_o[13]~reg0_q\,
	devoe => ww_devoe,
	o => \alu_result_o[13]~output_o\);

-- Location: IOOBUF_X36_Y43_N9
\alu_result_o[14]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \alu_result_o[14]~reg0_q\,
	devoe => ww_devoe,
	o => \alu_result_o[14]~output_o\);

-- Location: IOOBUF_X50_Y43_N16
\alu_result_o[15]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \alu_result_o[15]~reg0_q\,
	devoe => ww_devoe,
	o => \alu_result_o[15]~output_o\);

-- Location: IOOBUF_X50_Y43_N23
\alu_result_o[16]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \alu_result_o[16]~reg0_q\,
	devoe => ww_devoe,
	o => \alu_result_o[16]~output_o\);

-- Location: IOOBUF_X38_Y43_N16
\alu_result_o[17]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \alu_result_o[17]~reg0_q\,
	devoe => ww_devoe,
	o => \alu_result_o[17]~output_o\);

-- Location: IOOBUF_X48_Y43_N2
\alu_result_o[18]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \alu_result_o[18]~reg0_q\,
	devoe => ww_devoe,
	o => \alu_result_o[18]~output_o\);

-- Location: IOOBUF_X36_Y43_N16
\alu_result_o[19]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \alu_result_o[19]~reg0_q\,
	devoe => ww_devoe,
	o => \alu_result_o[19]~output_o\);

-- Location: IOOBUF_X41_Y43_N2
\alu_result_o[20]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \alu_result_o[20]~reg0_q\,
	devoe => ww_devoe,
	o => \alu_result_o[20]~output_o\);

-- Location: IOOBUF_X38_Y43_N30
\alu_result_o[21]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \alu_result_o[21]~reg0_q\,
	devoe => ww_devoe,
	o => \alu_result_o[21]~output_o\);

-- Location: IOOBUF_X43_Y43_N23
\alu_result_o[22]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \alu_result_o[22]~reg0_q\,
	devoe => ww_devoe,
	o => \alu_result_o[22]~output_o\);

-- Location: IOOBUF_X43_Y43_N30
\alu_result_o[23]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \alu_result_o[23]~reg0_q\,
	devoe => ww_devoe,
	o => \alu_result_o[23]~output_o\);

-- Location: IOOBUF_X43_Y43_N9
\alu_result_o[24]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \alu_result_o[24]~reg0_q\,
	devoe => ww_devoe,
	o => \alu_result_o[24]~output_o\);

-- Location: IOOBUF_X38_Y43_N2
\alu_result_o[25]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \alu_result_o[25]~reg0_q\,
	devoe => ww_devoe,
	o => \alu_result_o[25]~output_o\);

-- Location: IOOBUF_X50_Y43_N30
\alu_result_o[26]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \alu_result_o[26]~reg0_q\,
	devoe => ww_devoe,
	o => \alu_result_o[26]~output_o\);

-- Location: IOOBUF_X45_Y43_N9
\alu_result_o[27]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \alu_result_o[27]~reg0_q\,
	devoe => ww_devoe,
	o => \alu_result_o[27]~output_o\);

-- Location: IOOBUF_X41_Y43_N16
\alu_result_o[28]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \alu_result_o[28]~reg0_q\,
	devoe => ww_devoe,
	o => \alu_result_o[28]~output_o\);

-- Location: IOOBUF_X45_Y43_N30
\alu_result_o[29]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \alu_result_o[29]~reg0_q\,
	devoe => ww_devoe,
	o => \alu_result_o[29]~output_o\);

-- Location: IOOBUF_X41_Y43_N9
\alu_result_o[30]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \alu_result_o[30]~reg0_q\,
	devoe => ww_devoe,
	o => \alu_result_o[30]~output_o\);

-- Location: IOOBUF_X43_Y43_N2
\alu_result_o[31]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \alu_result_o[31]~reg0_q\,
	devoe => ww_devoe,
	o => \alu_result_o[31]~output_o\);

-- Location: IOOBUF_X52_Y43_N16
\alu_result_valid_o~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \alu_result_valid_o~reg0_q\,
	devoe => ww_devoe,
	o => \alu_result_valid_o~output_o\);

-- Location: IOOBUF_X52_Y43_N9
\stop_o~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \stop_o~reg0_q\,
	devoe => ww_devoe,
	o => \stop_o~output_o\);

-- Location: IOIBUF_X0_Y21_N8
\clk~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clk,
	o => \clk~input_o\);

-- Location: CLKCTRL_G2
\clk~inputclkctrl\ : cycloneive_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \clk~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \clk~inputclkctrl_outclk\);

-- Location: IOIBUF_X45_Y43_N1
\n_reset~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_n_reset,
	o => \n_reset~input_o\);

-- Location: LCCOMB_X43_Y42_N26
\pc[1]~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \pc[1]~2_combout\ = (\n_reset~input_o\ & ((pc(0) & ((pc(2)) # (!pc(1)))) # (!pc(0) & ((pc(1))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => pc(0),
	datab => pc(2),
	datac => pc(1),
	datad => \n_reset~input_o\,
	combout => \pc[1]~2_combout\);

-- Location: FF_X43_Y42_N27
\pc[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \pc[1]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => pc(1));

-- Location: LCCOMB_X43_Y42_N24
\pc[2]~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \pc[2]~3_combout\ = (\n_reset~input_o\ & ((pc(2)) # ((pc(0) & pc(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => pc(0),
	datab => pc(1),
	datac => pc(2),
	datad => \n_reset~input_o\,
	combout => \pc[2]~3_combout\);

-- Location: FF_X43_Y42_N25
\pc[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \pc[2]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => pc(2));

-- Location: LCCOMB_X43_Y42_N0
\pc[0]~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \pc[0]~1_combout\ = (\n_reset~input_o\ & (((pc(2) & pc(1))) # (!pc(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000101000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \n_reset~input_o\,
	datab => pc(2),
	datac => pc(0),
	datad => pc(1),
	combout => \pc[0]~1_combout\);

-- Location: FF_X43_Y42_N1
\pc[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \pc[0]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => pc(0));

-- Location: LCCOMB_X44_Y42_N10
\imem|Mux4~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \imem|Mux4~0_combout\ = (pc(2) & (pc(0) $ (pc(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110011000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => pc(0),
	datab => pc(1),
	datad => pc(2),
	combout => \imem|Mux4~0_combout\);

-- Location: FF_X44_Y42_N11
\inst_to_regFile2[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \imem|Mux4~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => inst_to_regFile2(0));

-- Location: FF_X43_Y42_N23
\regFile_to_ALU2[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => inst_to_regFile2(0),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => regFile_to_ALU2(0));

-- Location: LCCOMB_X43_Y42_N22
\alu|Add0~12\ : cycloneive_lcell_comb
-- Equation(s):
-- \alu|Add0~12_combout\ = regFile_to_ALU2(0) $ (((!pc(0) & (pc(1) $ (!pc(2))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101001011100001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => pc(1),
	datab => pc(0),
	datac => regFile_to_ALU2(0),
	datad => pc(2),
	combout => \alu|Add0~12_combout\);

-- Location: LCCOMB_X44_Y42_N8
\imem|Mux7~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \imem|Mux7~0_combout\ = (!pc(0) & (!pc(1) & pc(2)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => pc(0),
	datab => pc(1),
	datad => pc(2),
	combout => \imem|Mux7~0_combout\);

-- Location: FF_X44_Y42_N9
\inst_to_regFile1[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \imem|Mux7~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => inst_to_regFile1(0));

-- Location: FF_X43_Y42_N7
\regFile_to_ALU1[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => inst_to_regFile1(0),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => regFile_to_ALU1(0));

-- Location: LCCOMB_X43_Y42_N30
\imem|Mux1~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \imem|Mux1~0_combout\ = (pc(1) & ((pc(2)))) # (!pc(1) & (!pc(0) & !pc(2)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101000010001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => pc(1),
	datab => pc(0),
	datad => pc(2),
	combout => \imem|Mux1~0_combout\);

-- Location: LCCOMB_X43_Y42_N18
\imem|Mux0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \imem|Mux0~0_combout\ = (pc(1) & (pc(0) $ (!pc(2)))) # (!pc(1) & ((pc(0)) # (pc(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110101100110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => pc(1),
	datab => pc(0),
	datad => pc(2),
	combout => \imem|Mux0~0_combout\);

-- Location: LCCOMB_X43_Y42_N4
\alu|Add0~14\ : cycloneive_lcell_comb
-- Equation(s):
-- \alu|Add0~14_cout\ = CARRY((\imem|Mux0~0_combout\) # (!\imem|Mux1~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011011101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \imem|Mux1~0_combout\,
	datab => \imem|Mux0~0_combout\,
	datad => VCC,
	cout => \alu|Add0~14_cout\);

-- Location: LCCOMB_X43_Y42_N6
\alu|Add0~15\ : cycloneive_lcell_comb
-- Equation(s):
-- \alu|Add0~15_combout\ = (\alu|Add0~12_combout\ & ((regFile_to_ALU1(0) & (!\alu|Add0~14_cout\)) # (!regFile_to_ALU1(0) & ((\alu|Add0~14_cout\) # (GND))))) # (!\alu|Add0~12_combout\ & ((regFile_to_ALU1(0) & (\alu|Add0~14_cout\ & VCC)) # (!regFile_to_ALU1(0) 
-- & (!\alu|Add0~14_cout\))))
-- \alu|Add0~16\ = CARRY((\alu|Add0~12_combout\ & ((!\alu|Add0~14_cout\) # (!regFile_to_ALU1(0)))) # (!\alu|Add0~12_combout\ & (!regFile_to_ALU1(0) & !\alu|Add0~14_cout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100100101011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \alu|Add0~12_combout\,
	datab => regFile_to_ALU1(0),
	datad => VCC,
	cin => \alu|Add0~14_cout\,
	combout => \alu|Add0~15_combout\,
	cout => \alu|Add0~16\);

-- Location: LCCOMB_X44_Y42_N28
\alu|Add0~28\ : cycloneive_lcell_comb
-- Equation(s):
-- \alu|Add0~28_combout\ = (\alu|Add0~15_combout\ & ((!pc(1)) # (!pc(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => pc(0),
	datac => \alu|Add0~15_combout\,
	datad => pc(1),
	combout => \alu|Add0~28_combout\);

-- Location: FF_X44_Y42_N29
\alu_result_o[0]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \alu|Add0~28_combout\,
	ena => \n_reset~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \alu_result_o[0]~reg0_q\);

-- Location: LCCOMB_X44_Y42_N30
\imem|Mux6~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \imem|Mux6~0_combout\ = (pc(0) & (!pc(1))) # (!pc(0) & (pc(1) & pc(2)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110011000100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => pc(0),
	datab => pc(1),
	datad => pc(2),
	combout => \imem|Mux6~0_combout\);

-- Location: FF_X44_Y42_N31
\inst_to_regFile1[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \imem|Mux6~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => inst_to_regFile1(1));

-- Location: FF_X43_Y42_N9
\regFile_to_ALU1[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => inst_to_regFile1(1),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => regFile_to_ALU1(1));

-- Location: LCCOMB_X43_Y42_N20
\alu|Equal0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \alu|Equal0~0_combout\ = (!pc(0) & (pc(1) $ (!pc(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010001000010001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => pc(1),
	datab => pc(0),
	datad => pc(2),
	combout => \alu|Equal0~0_combout\);

-- Location: LCCOMB_X43_Y42_N8
\alu|Add0~17\ : cycloneive_lcell_comb
-- Equation(s):
-- \alu|Add0~17_combout\ = ((regFile_to_ALU1(1) $ (\alu|Equal0~0_combout\ $ (\alu|Add0~16\)))) # (GND)
-- \alu|Add0~18\ = CARRY((regFile_to_ALU1(1) & ((!\alu|Add0~16\) # (!\alu|Equal0~0_combout\))) # (!regFile_to_ALU1(1) & (!\alu|Equal0~0_combout\ & !\alu|Add0~16\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000101011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => regFile_to_ALU1(1),
	datab => \alu|Equal0~0_combout\,
	datad => VCC,
	cin => \alu|Add0~16\,
	combout => \alu|Add0~17_combout\,
	cout => \alu|Add0~18\);

-- Location: LCCOMB_X44_Y42_N6
\alu|Add0~29\ : cycloneive_lcell_comb
-- Equation(s):
-- \alu|Add0~29_combout\ = (\alu|Add0~17_combout\ & ((!pc(1)) # (!pc(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111011100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => pc(0),
	datab => pc(1),
	datad => \alu|Add0~17_combout\,
	combout => \alu|Add0~29_combout\);

-- Location: FF_X44_Y42_N7
\alu_result_o[1]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \alu|Add0~29_combout\,
	ena => \n_reset~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \alu_result_o[1]~reg0_q\);

-- Location: LCCOMB_X45_Y42_N0
\imem|Mux3~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \imem|Mux3~0_combout\ = (pc(2) & !pc(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => pc(2),
	datad => pc(0),
	combout => \imem|Mux3~0_combout\);

-- Location: FF_X45_Y42_N1
\inst_to_regFile2[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \imem|Mux3~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => inst_to_regFile2(2));

-- Location: FF_X43_Y42_N11
\regFile_to_ALU2[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => inst_to_regFile2(2),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => regFile_to_ALU2(2));

-- Location: LCCOMB_X43_Y42_N10
\alu|Add0~19\ : cycloneive_lcell_comb
-- Equation(s):
-- \alu|Add0~19_combout\ = (\alu|Add0~18\ & (regFile_to_ALU2(2) $ ((\alu|Equal0~0_combout\)))) # (!\alu|Add0~18\ & ((regFile_to_ALU2(2) $ (!\alu|Equal0~0_combout\)) # (GND)))
-- \alu|Add0~20\ = CARRY((regFile_to_ALU2(2) $ (\alu|Equal0~0_combout\)) # (!\alu|Add0~18\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100101101111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => regFile_to_ALU2(2),
	datab => \alu|Equal0~0_combout\,
	datad => VCC,
	cin => \alu|Add0~18\,
	combout => \alu|Add0~19_combout\,
	cout => \alu|Add0~20\);

-- Location: LCCOMB_X44_Y42_N0
\alu|Add0~30\ : cycloneive_lcell_comb
-- Equation(s):
-- \alu|Add0~30_combout\ = (\alu|Add0~19_combout\ & ((!pc(1)) # (!pc(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111011100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => pc(0),
	datab => pc(1),
	datad => \alu|Add0~19_combout\,
	combout => \alu|Add0~30_combout\);

-- Location: FF_X44_Y42_N1
\alu_result_o[2]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \alu|Add0~30_combout\,
	ena => \n_reset~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \alu_result_o[2]~reg0_q\);

-- Location: LCCOMB_X44_Y42_N14
\imem|Mux5~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \imem|Mux5~0_combout\ = (!pc(2) & (pc(0) $ (!pc(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010011001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => pc(0),
	datab => pc(1),
	datad => pc(2),
	combout => \imem|Mux5~0_combout\);

-- Location: FF_X44_Y42_N15
\inst_to_regFile1[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \imem|Mux5~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => inst_to_regFile1(3));

-- Location: FF_X43_Y42_N13
\regFile_to_ALU1[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => inst_to_regFile1(3),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => regFile_to_ALU1(3));

-- Location: LCCOMB_X44_Y42_N12
\imem|Mux2~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \imem|Mux2~0_combout\ = (!pc(0) & (pc(1) & !pc(2)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => pc(0),
	datab => pc(1),
	datad => pc(2),
	combout => \imem|Mux2~0_combout\);

-- Location: FF_X44_Y42_N13
\inst_to_regFile2[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \imem|Mux2~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => inst_to_regFile2(3));

-- Location: FF_X43_Y42_N3
\regFile_to_ALU2[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => inst_to_regFile2(3),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => regFile_to_ALU2(3));

-- Location: LCCOMB_X43_Y42_N2
\alu|Add0~21\ : cycloneive_lcell_comb
-- Equation(s):
-- \alu|Add0~21_combout\ = regFile_to_ALU2(3) $ (((!pc(0) & (pc(1) $ (!pc(2))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000001101001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => pc(1),
	datab => pc(2),
	datac => regFile_to_ALU2(3),
	datad => pc(0),
	combout => \alu|Add0~21_combout\);

-- Location: LCCOMB_X43_Y42_N12
\alu|Add0~22\ : cycloneive_lcell_comb
-- Equation(s):
-- \alu|Add0~22_combout\ = ((regFile_to_ALU1(3) $ (\alu|Add0~21_combout\ $ (\alu|Add0~20\)))) # (GND)
-- \alu|Add0~23\ = CARRY((regFile_to_ALU1(3) & ((!\alu|Add0~20\) # (!\alu|Add0~21_combout\))) # (!regFile_to_ALU1(3) & (!\alu|Add0~21_combout\ & !\alu|Add0~20\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000101011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => regFile_to_ALU1(3),
	datab => \alu|Add0~21_combout\,
	datad => VCC,
	cin => \alu|Add0~20\,
	combout => \alu|Add0~22_combout\,
	cout => \alu|Add0~23\);

-- Location: LCCOMB_X44_Y42_N26
\alu|Add0~31\ : cycloneive_lcell_comb
-- Equation(s):
-- \alu|Add0~31_combout\ = (\alu|Add0~22_combout\ & ((!pc(1)) # (!pc(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111011100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => pc(0),
	datab => pc(1),
	datad => \alu|Add0~22_combout\,
	combout => \alu|Add0~31_combout\);

-- Location: FF_X44_Y42_N27
\alu_result_o[3]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \alu|Add0~31_combout\,
	ena => \n_reset~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \alu_result_o[3]~reg0_q\);

-- Location: LCCOMB_X43_Y42_N14
\alu|Add0~24\ : cycloneive_lcell_comb
-- Equation(s):
-- \alu|Add0~24_combout\ = (\imem|Mux1~0_combout\ & ((\imem|Mux0~0_combout\ & (!\alu|Add0~23\)) # (!\imem|Mux0~0_combout\ & ((\alu|Add0~23\) # (GND))))) # (!\imem|Mux1~0_combout\ & (((!\alu|Add0~23\))))
-- \alu|Add0~25\ = CARRY(((\imem|Mux1~0_combout\ & !\imem|Mux0~0_combout\)) # (!\alu|Add0~23\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010110100101111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \imem|Mux1~0_combout\,
	datab => \imem|Mux0~0_combout\,
	datad => VCC,
	cin => \alu|Add0~23\,
	combout => \alu|Add0~24_combout\,
	cout => \alu|Add0~25\);

-- Location: LCCOMB_X44_Y42_N4
\alu|Add0~32\ : cycloneive_lcell_comb
-- Equation(s):
-- \alu|Add0~32_combout\ = (\alu|Add0~24_combout\ & ((!pc(1)) # (!pc(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111011100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => pc(0),
	datab => pc(1),
	datad => \alu|Add0~24_combout\,
	combout => \alu|Add0~32_combout\);

-- Location: FF_X44_Y42_N5
\alu_result_o[4]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \alu|Add0~32_combout\,
	ena => \n_reset~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \alu_result_o[4]~reg0_q\);

-- Location: LCCOMB_X43_Y42_N16
\alu|Add0~26\ : cycloneive_lcell_comb
-- Equation(s):
-- \alu|Add0~26_combout\ = \alu|Add0~25\ $ (((\imem|Mux1~0_combout\ & !\imem|Mux0~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000001011010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \imem|Mux1~0_combout\,
	datad => \imem|Mux0~0_combout\,
	cin => \alu|Add0~25\,
	combout => \alu|Add0~26_combout\);

-- Location: LCCOMB_X43_Y42_N28
\alu|Add0~33\ : cycloneive_lcell_comb
-- Equation(s):
-- \alu|Add0~33_combout\ = (\alu|Add0~26_combout\ & ((!pc(1)) # (!pc(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => pc(0),
	datac => pc(1),
	datad => \alu|Add0~26_combout\,
	combout => \alu|Add0~33_combout\);

-- Location: LCCOMB_X42_Y42_N16
\alu_result_o[5]~reg0feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \alu_result_o[5]~reg0feeder_combout\ = \alu|Add0~33_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \alu|Add0~33_combout\,
	combout => \alu_result_o[5]~reg0feeder_combout\);

-- Location: FF_X42_Y42_N17
\alu_result_o[5]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \alu_result_o[5]~reg0feeder_combout\,
	ena => \n_reset~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \alu_result_o[5]~reg0_q\);

-- Location: LCCOMB_X44_Y42_N18
\alu_result_o[6]~reg0feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \alu_result_o[6]~reg0feeder_combout\ = \alu|Add0~33_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \alu|Add0~33_combout\,
	combout => \alu_result_o[6]~reg0feeder_combout\);

-- Location: FF_X44_Y42_N19
\alu_result_o[6]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \alu_result_o[6]~reg0feeder_combout\,
	ena => \n_reset~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \alu_result_o[6]~reg0_q\);

-- Location: LCCOMB_X44_Y42_N20
\alu_result_o[7]~reg0feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \alu_result_o[7]~reg0feeder_combout\ = \alu|Add0~33_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \alu|Add0~33_combout\,
	combout => \alu_result_o[7]~reg0feeder_combout\);

-- Location: FF_X44_Y42_N21
\alu_result_o[7]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \alu_result_o[7]~reg0feeder_combout\,
	ena => \n_reset~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \alu_result_o[7]~reg0_q\);

-- Location: LCCOMB_X42_Y42_N26
\alu_result_o[8]~reg0feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \alu_result_o[8]~reg0feeder_combout\ = \alu|Add0~33_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \alu|Add0~33_combout\,
	combout => \alu_result_o[8]~reg0feeder_combout\);

-- Location: FF_X42_Y42_N27
\alu_result_o[8]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \alu_result_o[8]~reg0feeder_combout\,
	ena => \n_reset~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \alu_result_o[8]~reg0_q\);

-- Location: LCCOMB_X44_Y42_N22
\alu_result_o[9]~reg0feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \alu_result_o[9]~reg0feeder_combout\ = \alu|Add0~33_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \alu|Add0~33_combout\,
	combout => \alu_result_o[9]~reg0feeder_combout\);

-- Location: FF_X44_Y42_N23
\alu_result_o[9]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \alu_result_o[9]~reg0feeder_combout\,
	ena => \n_reset~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \alu_result_o[9]~reg0_q\);

-- Location: LCCOMB_X44_Y42_N24
\alu_result_o[10]~reg0feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \alu_result_o[10]~reg0feeder_combout\ = \alu|Add0~33_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \alu|Add0~33_combout\,
	combout => \alu_result_o[10]~reg0feeder_combout\);

-- Location: FF_X44_Y42_N25
\alu_result_o[10]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \alu_result_o[10]~reg0feeder_combout\,
	ena => \n_reset~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \alu_result_o[10]~reg0_q\);

-- Location: LCCOMB_X42_Y42_N20
\alu_result_o[11]~reg0feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \alu_result_o[11]~reg0feeder_combout\ = \alu|Add0~33_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \alu|Add0~33_combout\,
	combout => \alu_result_o[11]~reg0feeder_combout\);

-- Location: FF_X42_Y42_N21
\alu_result_o[11]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \alu_result_o[11]~reg0feeder_combout\,
	ena => \n_reset~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \alu_result_o[11]~reg0_q\);

-- Location: LCCOMB_X42_Y42_N18
\alu_result_o[12]~reg0feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \alu_result_o[12]~reg0feeder_combout\ = \alu|Add0~33_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \alu|Add0~33_combout\,
	combout => \alu_result_o[12]~reg0feeder_combout\);

-- Location: FF_X42_Y42_N19
\alu_result_o[12]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \alu_result_o[12]~reg0feeder_combout\,
	ena => \n_reset~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \alu_result_o[12]~reg0_q\);

-- Location: LCCOMB_X42_Y42_N24
\alu_result_o[13]~reg0feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \alu_result_o[13]~reg0feeder_combout\ = \alu|Add0~33_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \alu|Add0~33_combout\,
	combout => \alu_result_o[13]~reg0feeder_combout\);

-- Location: FF_X42_Y42_N25
\alu_result_o[13]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \alu_result_o[13]~reg0feeder_combout\,
	ena => \n_reset~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \alu_result_o[13]~reg0_q\);

-- Location: LCCOMB_X42_Y42_N30
\alu_result_o[14]~reg0feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \alu_result_o[14]~reg0feeder_combout\ = \alu|Add0~33_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \alu|Add0~33_combout\,
	combout => \alu_result_o[14]~reg0feeder_combout\);

-- Location: FF_X42_Y42_N31
\alu_result_o[14]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \alu_result_o[14]~reg0feeder_combout\,
	ena => \n_reset~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \alu_result_o[14]~reg0_q\);

-- Location: LCCOMB_X44_Y42_N2
\alu_result_o[15]~reg0feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \alu_result_o[15]~reg0feeder_combout\ = \alu|Add0~33_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \alu|Add0~33_combout\,
	combout => \alu_result_o[15]~reg0feeder_combout\);

-- Location: FF_X44_Y42_N3
\alu_result_o[15]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \alu_result_o[15]~reg0feeder_combout\,
	ena => \n_reset~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \alu_result_o[15]~reg0_q\);

-- Location: FF_X43_Y42_N15
\alu_result_o[16]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \alu|Add0~33_combout\,
	sload => VCC,
	ena => \n_reset~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \alu_result_o[16]~reg0_q\);

-- Location: FF_X43_Y42_N5
\alu_result_o[17]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \alu|Add0~33_combout\,
	sload => VCC,
	ena => \n_reset~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \alu_result_o[17]~reg0_q\);

-- Location: LCCOMB_X42_Y42_N12
\alu_result_o[18]~reg0feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \alu_result_o[18]~reg0feeder_combout\ = \alu|Add0~33_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \alu|Add0~33_combout\,
	combout => \alu_result_o[18]~reg0feeder_combout\);

-- Location: FF_X42_Y42_N13
\alu_result_o[18]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \alu_result_o[18]~reg0feeder_combout\,
	ena => \n_reset~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \alu_result_o[18]~reg0_q\);

-- Location: LCCOMB_X42_Y42_N22
\alu_result_o[19]~reg0feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \alu_result_o[19]~reg0feeder_combout\ = \alu|Add0~33_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \alu|Add0~33_combout\,
	combout => \alu_result_o[19]~reg0feeder_combout\);

-- Location: FF_X42_Y42_N23
\alu_result_o[19]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \alu_result_o[19]~reg0feeder_combout\,
	ena => \n_reset~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \alu_result_o[19]~reg0_q\);

-- Location: LCCOMB_X42_Y42_N28
\alu_result_o[20]~reg0feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \alu_result_o[20]~reg0feeder_combout\ = \alu|Add0~33_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \alu|Add0~33_combout\,
	combout => \alu_result_o[20]~reg0feeder_combout\);

-- Location: FF_X42_Y42_N29
\alu_result_o[20]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \alu_result_o[20]~reg0feeder_combout\,
	ena => \n_reset~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \alu_result_o[20]~reg0_q\);

-- Location: LCCOMB_X42_Y42_N2
\alu_result_o[21]~reg0feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \alu_result_o[21]~reg0feeder_combout\ = \alu|Add0~33_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \alu|Add0~33_combout\,
	combout => \alu_result_o[21]~reg0feeder_combout\);

-- Location: FF_X42_Y42_N3
\alu_result_o[21]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \alu_result_o[21]~reg0feeder_combout\,
	ena => \n_reset~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \alu_result_o[21]~reg0_q\);

-- Location: FF_X43_Y42_N21
\alu_result_o[22]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \alu|Add0~33_combout\,
	sload => VCC,
	ena => \n_reset~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \alu_result_o[22]~reg0_q\);

-- Location: FF_X43_Y42_N31
\alu_result_o[23]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \alu|Add0~33_combout\,
	sload => VCC,
	ena => \n_reset~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \alu_result_o[23]~reg0_q\);

-- Location: FF_X43_Y42_N19
\alu_result_o[24]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \alu|Add0~33_combout\,
	sload => VCC,
	ena => \n_reset~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \alu_result_o[24]~reg0_q\);

-- Location: LCCOMB_X42_Y42_N8
\alu_result_o[25]~reg0feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \alu_result_o[25]~reg0feeder_combout\ = \alu|Add0~33_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \alu|Add0~33_combout\,
	combout => \alu_result_o[25]~reg0feeder_combout\);

-- Location: FF_X42_Y42_N9
\alu_result_o[25]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \alu_result_o[25]~reg0feeder_combout\,
	ena => \n_reset~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \alu_result_o[25]~reg0_q\);

-- Location: LCCOMB_X42_Y42_N14
\alu_result_o[26]~reg0feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \alu_result_o[26]~reg0feeder_combout\ = \alu|Add0~33_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \alu|Add0~33_combout\,
	combout => \alu_result_o[26]~reg0feeder_combout\);

-- Location: FF_X42_Y42_N15
\alu_result_o[26]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \alu_result_o[26]~reg0feeder_combout\,
	ena => \n_reset~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \alu_result_o[26]~reg0_q\);

-- Location: FF_X43_Y42_N17
\alu_result_o[27]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \alu|Add0~33_combout\,
	sload => VCC,
	ena => \n_reset~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \alu_result_o[27]~reg0_q\);

-- Location: LCCOMB_X42_Y42_N0
\alu_result_o[28]~reg0feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \alu_result_o[28]~reg0feeder_combout\ = \alu|Add0~33_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \alu|Add0~33_combout\,
	combout => \alu_result_o[28]~reg0feeder_combout\);

-- Location: FF_X42_Y42_N1
\alu_result_o[28]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \alu_result_o[28]~reg0feeder_combout\,
	ena => \n_reset~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \alu_result_o[28]~reg0_q\);

-- Location: LCCOMB_X44_Y42_N16
\alu_result_o[29]~reg0feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \alu_result_o[29]~reg0feeder_combout\ = \alu|Add0~33_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \alu|Add0~33_combout\,
	combout => \alu_result_o[29]~reg0feeder_combout\);

-- Location: FF_X44_Y42_N17
\alu_result_o[29]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \alu_result_o[29]~reg0feeder_combout\,
	ena => \n_reset~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \alu_result_o[29]~reg0_q\);

-- Location: LCCOMB_X42_Y42_N10
\alu_result_o[30]~reg0feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \alu_result_o[30]~reg0feeder_combout\ = \alu|Add0~33_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \alu|Add0~33_combout\,
	combout => \alu_result_o[30]~reg0feeder_combout\);

-- Location: FF_X42_Y42_N11
\alu_result_o[30]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \alu_result_o[30]~reg0feeder_combout\,
	ena => \n_reset~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \alu_result_o[30]~reg0_q\);

-- Location: FF_X43_Y42_N29
\alu_result_o[31]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \alu|Add0~33_combout\,
	ena => \n_reset~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \alu_result_o[31]~reg0_q\);

-- Location: LCCOMB_X45_Y42_N4
\pc[2]~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \pc[2]~0_combout\ = (!pc(1)) # (!pc(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => pc(0),
	datad => pc(1),
	combout => \pc[2]~0_combout\);

-- Location: FF_X45_Y42_N5
\alu_result_valid_o~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \pc[2]~0_combout\,
	ena => \n_reset~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \alu_result_valid_o~reg0_q\);

-- Location: LCCOMB_X45_Y42_N30
\alu|Equal0~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \alu|Equal0~1_combout\ = (pc(0) & (pc(2) & pc(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => pc(0),
	datac => pc(2),
	datad => pc(1),
	combout => \alu|Equal0~1_combout\);

-- Location: FF_X45_Y42_N31
\stop_o~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \alu|Equal0~1_combout\,
	ena => \n_reset~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \stop_o~reg0_q\);

ww_alu_result_o(0) <= \alu_result_o[0]~output_o\;

ww_alu_result_o(1) <= \alu_result_o[1]~output_o\;

ww_alu_result_o(2) <= \alu_result_o[2]~output_o\;

ww_alu_result_o(3) <= \alu_result_o[3]~output_o\;

ww_alu_result_o(4) <= \alu_result_o[4]~output_o\;

ww_alu_result_o(5) <= \alu_result_o[5]~output_o\;

ww_alu_result_o(6) <= \alu_result_o[6]~output_o\;

ww_alu_result_o(7) <= \alu_result_o[7]~output_o\;

ww_alu_result_o(8) <= \alu_result_o[8]~output_o\;

ww_alu_result_o(9) <= \alu_result_o[9]~output_o\;

ww_alu_result_o(10) <= \alu_result_o[10]~output_o\;

ww_alu_result_o(11) <= \alu_result_o[11]~output_o\;

ww_alu_result_o(12) <= \alu_result_o[12]~output_o\;

ww_alu_result_o(13) <= \alu_result_o[13]~output_o\;

ww_alu_result_o(14) <= \alu_result_o[14]~output_o\;

ww_alu_result_o(15) <= \alu_result_o[15]~output_o\;

ww_alu_result_o(16) <= \alu_result_o[16]~output_o\;

ww_alu_result_o(17) <= \alu_result_o[17]~output_o\;

ww_alu_result_o(18) <= \alu_result_o[18]~output_o\;

ww_alu_result_o(19) <= \alu_result_o[19]~output_o\;

ww_alu_result_o(20) <= \alu_result_o[20]~output_o\;

ww_alu_result_o(21) <= \alu_result_o[21]~output_o\;

ww_alu_result_o(22) <= \alu_result_o[22]~output_o\;

ww_alu_result_o(23) <= \alu_result_o[23]~output_o\;

ww_alu_result_o(24) <= \alu_result_o[24]~output_o\;

ww_alu_result_o(25) <= \alu_result_o[25]~output_o\;

ww_alu_result_o(26) <= \alu_result_o[26]~output_o\;

ww_alu_result_o(27) <= \alu_result_o[27]~output_o\;

ww_alu_result_o(28) <= \alu_result_o[28]~output_o\;

ww_alu_result_o(29) <= \alu_result_o[29]~output_o\;

ww_alu_result_o(30) <= \alu_result_o[30]~output_o\;

ww_alu_result_o(31) <= \alu_result_o[31]~output_o\;

ww_alu_result_valid_o <= \alu_result_valid_o~output_o\;

ww_stop_o <= \stop_o~output_o\;
END structure;


