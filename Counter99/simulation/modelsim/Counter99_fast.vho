-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus II 64-Bit"
-- VERSION "Version 13.0.1 Build 232 06/12/2013 Service Pack 1 SJ Web Edition"

-- DATE "09/15/2025 08:27:46"

-- 
-- Device: Altera EP2C35F672C6 Package FBGA672
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY CYCLONEII;
LIBRARY IEEE;
USE CYCLONEII.CYCLONEII_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	Counter99 IS
    PORT (
	RST : IN std_logic;
	CLK : IN std_logic;
	EN : IN std_logic;
	CLR : IN std_logic;
	LD : IN std_logic;
	LOAD : IN std_logic_vector(7 DOWNTO 0);
	Q : OUT std_logic_vector(7 DOWNTO 0)
	);
END Counter99;

-- Design Ports Information
-- Q[0]	=>  Location: PIN_G15,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- Q[1]	=>  Location: PIN_D16,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- Q[2]	=>  Location: PIN_H15,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- Q[3]	=>  Location: PIN_H16,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- Q[4]	=>  Location: PIN_F15,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- Q[5]	=>  Location: PIN_B16,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- Q[6]	=>  Location: PIN_C16,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- Q[7]	=>  Location: PIN_E15,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
-- LOAD[0]	=>  Location: PIN_C13,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- LD	=>  Location: PIN_D13,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- CLR	=>  Location: PIN_F16,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- CLK	=>  Location: PIN_P2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- RST	=>  Location: PIN_P1,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- EN	=>  Location: PIN_G14,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- LOAD[1]	=>  Location: PIN_B15,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- LOAD[2]	=>  Location: PIN_B17,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- LOAD[3]	=>  Location: PIN_D17,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- LOAD[4]	=>  Location: PIN_G16,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- LOAD[5]	=>  Location: PIN_C15,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- LOAD[6]	=>  Location: PIN_D15,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- LOAD[7]	=>  Location: PIN_A17,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default


ARCHITECTURE structure OF Counter99 IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_RST : std_logic;
SIGNAL ww_CLK : std_logic;
SIGNAL ww_EN : std_logic;
SIGNAL ww_CLR : std_logic;
SIGNAL ww_LD : std_logic;
SIGNAL ww_LOAD : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_Q : std_logic_vector(7 DOWNTO 0);
SIGNAL \CLK~clkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \RST~clkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \units_counter|CONT~5_combout\ : std_logic;
SIGNAL \EN~combout\ : std_logic;
SIGNAL \CLK~combout\ : std_logic;
SIGNAL \CLK~clkctrl_outclk\ : std_logic;
SIGNAL \LD~combout\ : std_logic;
SIGNAL \tens_counter|CONT[0]~0_combout\ : std_logic;
SIGNAL \units_counter|CONT~4_combout\ : std_logic;
SIGNAL \clr_int~0_combout\ : std_logic;
SIGNAL \units_counter|CONT~6_combout\ : std_logic;
SIGNAL \RST~combout\ : std_logic;
SIGNAL \RST~clkctrl_outclk\ : std_logic;
SIGNAL \units_counter|CONT[0]~2_combout\ : std_logic;
SIGNAL \units_counter|CONT[0]~3_combout\ : std_logic;
SIGNAL \units_counter|CONT[2]~7_combout\ : std_logic;
SIGNAL \units_counter|CONT[2]~8_combout\ : std_logic;
SIGNAL \units_counter|CONT[2]~9_combout\ : std_logic;
SIGNAL \units_counter|Add0~0_combout\ : std_logic;
SIGNAL \units_counter|CONT[3]~10_combout\ : std_logic;
SIGNAL \units_counter|CONT[3]~11_combout\ : std_logic;
SIGNAL \clr_int~1_combout\ : std_logic;
SIGNAL \clr_int~2_combout\ : std_logic;
SIGNAL \tens_counter|CONT[0]~3_combout\ : std_logic;
SIGNAL \tens_counter|CONT[1]~4_combout\ : std_logic;
SIGNAL \tens_counter|CONT[1]~5_combout\ : std_logic;
SIGNAL \tens_counter|CONT[2]~6_combout\ : std_logic;
SIGNAL \tens_counter|CONT[2]~7_combout\ : std_logic;
SIGNAL \tens_counter|CONT[2]~8_combout\ : std_logic;
SIGNAL \tens_counter|CONT[3]~9_combout\ : std_logic;
SIGNAL \tens_counter|CONT[3]~1_combout\ : std_logic;
SIGNAL \tens_counter|CONT[3]~2_combout\ : std_logic;
SIGNAL \tens_counter|CONT[3]~10_combout\ : std_logic;
SIGNAL \CLR~combout\ : std_logic;
SIGNAL \units_counter|CONT~0_combout\ : std_logic;
SIGNAL \units_counter|CONT~1_combout\ : std_logic;
SIGNAL \tens_counter|CONT\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \units_counter|CONT\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \LOAD~combout\ : std_logic_vector(7 DOWNTO 0);

BEGIN

ww_RST <= RST;
ww_CLK <= CLK;
ww_EN <= EN;
ww_CLR <= CLR;
ww_LD <= LD;
ww_LOAD <= LOAD;
Q <= ww_Q;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\CLK~clkctrl_INCLK_bus\ <= (gnd & gnd & gnd & \CLK~combout\);

\RST~clkctrl_INCLK_bus\ <= (gnd & gnd & gnd & \RST~combout\);

-- Location: LCCOMB_X41_Y35_N22
\units_counter|CONT~5\ : cycloneii_lcell_comb
-- Equation(s):
-- \units_counter|CONT~5_combout\ = (!\CLR~combout\ & !\tens_counter|CONT\(3))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001010101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CLR~combout\,
	datad => \tens_counter|CONT\(3),
	combout => \units_counter|CONT~5_combout\);

-- Location: PIN_C13,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\LOAD[0]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_LOAD(0),
	combout => \LOAD~combout\(0));

-- Location: PIN_G14,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\EN~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_EN,
	combout => \EN~combout\);

-- Location: PIN_B15,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\LOAD[1]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_LOAD(1),
	combout => \LOAD~combout\(1));

-- Location: PIN_C15,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\LOAD[5]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_LOAD(5),
	combout => \LOAD~combout\(5));

-- Location: PIN_A17,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\LOAD[7]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_LOAD(7),
	combout => \LOAD~combout\(7));

-- Location: PIN_P2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\CLK~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_CLK,
	combout => \CLK~combout\);

-- Location: CLKCTRL_G3
\CLK~clkctrl\ : cycloneii_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \CLK~clkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \CLK~clkctrl_outclk\);

-- Location: PIN_D13,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\LD~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_LD,
	combout => \LD~combout\);

-- Location: PIN_D15,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\LOAD[6]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_LOAD(6),
	combout => \LOAD~combout\(6));

-- Location: PIN_G16,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\LOAD[4]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_LOAD(4),
	combout => \LOAD~combout\(4));

-- Location: LCCOMB_X41_Y35_N8
\tens_counter|CONT[0]~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \tens_counter|CONT[0]~0_combout\ = (\LD~combout\ & (\LOAD~combout\(4))) # (!\LD~combout\ & ((!\tens_counter|CONT\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011110011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \LD~combout\,
	datac => \LOAD~combout\(4),
	datad => \tens_counter|CONT\(0),
	combout => \tens_counter|CONT[0]~0_combout\);

-- Location: PIN_B17,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\LOAD[2]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_LOAD(2),
	combout => \LOAD~combout\(2));

-- Location: LCCOMB_X41_Y35_N16
\units_counter|CONT~4\ : cycloneii_lcell_comb
-- Equation(s):
-- \units_counter|CONT~4_combout\ = (\LD~combout\ & (\LOAD~combout\(1))) # (!\LD~combout\ & ((\units_counter|CONT\(0) $ (\units_counter|CONT\(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000101110111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \LOAD~combout\(1),
	datab => \LD~combout\,
	datac => \units_counter|CONT\(0),
	datad => \units_counter|CONT\(1),
	combout => \units_counter|CONT~4_combout\);

-- Location: LCCOMB_X41_Y35_N24
\clr_int~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \clr_int~0_combout\ = (\tens_counter|CONT\(2) & \tens_counter|CONT\(1))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \tens_counter|CONT\(2),
	datad => \tens_counter|CONT\(1),
	combout => \clr_int~0_combout\);

-- Location: LCCOMB_X42_Y35_N22
\units_counter|CONT~6\ : cycloneii_lcell_comb
-- Equation(s):
-- \units_counter|CONT~6_combout\ = (\units_counter|CONT~5_combout\ & (\units_counter|CONT~4_combout\ & ((!\clr_int~0_combout\) # (!\clr_int~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \units_counter|CONT~5_combout\,
	datab => \units_counter|CONT~4_combout\,
	datac => \clr_int~1_combout\,
	datad => \clr_int~0_combout\,
	combout => \units_counter|CONT~6_combout\);

-- Location: PIN_P1,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\RST~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_RST,
	combout => \RST~combout\);

-- Location: CLKCTRL_G1
\RST~clkctrl\ : cycloneii_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \RST~clkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \RST~clkctrl_outclk\);

-- Location: LCCOMB_X42_Y35_N14
\units_counter|CONT[0]~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \units_counter|CONT[0]~2_combout\ = (\CLR~combout\) # (\tens_counter|CONT\(3))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111110101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CLR~combout\,
	datad => \tens_counter|CONT\(3),
	combout => \units_counter|CONT[0]~2_combout\);

-- Location: LCCOMB_X42_Y35_N24
\units_counter|CONT[0]~3\ : cycloneii_lcell_comb
-- Equation(s):
-- \units_counter|CONT[0]~3_combout\ = (\EN~combout\) # ((\units_counter|CONT[0]~2_combout\) # ((\clr_int~1_combout\ & \clr_int~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111011101110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \EN~combout\,
	datab => \units_counter|CONT[0]~2_combout\,
	datac => \clr_int~1_combout\,
	datad => \clr_int~0_combout\,
	combout => \units_counter|CONT[0]~3_combout\);

-- Location: LCFF_X42_Y35_N23
\units_counter|CONT[1]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLK~clkctrl_outclk\,
	datain => \units_counter|CONT~6_combout\,
	aclr => \RST~clkctrl_outclk\,
	ena => \units_counter|CONT[0]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \units_counter|CONT\(1));

-- Location: LCCOMB_X42_Y35_N10
\units_counter|CONT[2]~7\ : cycloneii_lcell_comb
-- Equation(s):
-- \units_counter|CONT[2]~7_combout\ = (!\LD~combout\ & (\units_counter|CONT\(2) $ (((\units_counter|CONT\(1) & \units_counter|CONT\(0))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001010101000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \LD~combout\,
	datab => \units_counter|CONT\(1),
	datac => \units_counter|CONT\(0),
	datad => \units_counter|CONT\(2),
	combout => \units_counter|CONT[2]~7_combout\);

-- Location: LCCOMB_X42_Y35_N28
\units_counter|CONT[2]~8\ : cycloneii_lcell_comb
-- Equation(s):
-- \units_counter|CONT[2]~8_combout\ = (\units_counter|CONT[2]~7_combout\) # ((\LOAD~combout\(2) & \LD~combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \LOAD~combout\(2),
	datac => \LD~combout\,
	datad => \units_counter|CONT[2]~7_combout\,
	combout => \units_counter|CONT[2]~8_combout\);

-- Location: LCCOMB_X42_Y35_N8
\units_counter|CONT[2]~9\ : cycloneii_lcell_comb
-- Equation(s):
-- \units_counter|CONT[2]~9_combout\ = (!\clr_int~2_combout\ & ((\EN~combout\ & (\units_counter|CONT[2]~8_combout\)) # (!\EN~combout\ & ((\units_counter|CONT\(2))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \EN~combout\,
	datab => \units_counter|CONT[2]~8_combout\,
	datac => \units_counter|CONT\(2),
	datad => \clr_int~2_combout\,
	combout => \units_counter|CONT[2]~9_combout\);

-- Location: LCFF_X42_Y35_N9
\units_counter|CONT[2]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLK~clkctrl_outclk\,
	datain => \units_counter|CONT[2]~9_combout\,
	aclr => \RST~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \units_counter|CONT\(2));

-- Location: PIN_D17,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\LOAD[3]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_LOAD(3),
	combout => \LOAD~combout\(3));

-- Location: LCCOMB_X42_Y35_N12
\units_counter|Add0~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \units_counter|Add0~0_combout\ = \units_counter|CONT\(3) $ (((\units_counter|CONT\(0) & (\units_counter|CONT\(1) & \units_counter|CONT\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111111110000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \units_counter|CONT\(0),
	datab => \units_counter|CONT\(1),
	datac => \units_counter|CONT\(2),
	datad => \units_counter|CONT\(3),
	combout => \units_counter|Add0~0_combout\);

-- Location: LCCOMB_X42_Y35_N2
\units_counter|CONT[3]~10\ : cycloneii_lcell_comb
-- Equation(s):
-- \units_counter|CONT[3]~10_combout\ = (\LD~combout\ & (\LOAD~combout\(3))) # (!\LD~combout\ & ((\units_counter|Add0~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \LOAD~combout\(3),
	datac => \LD~combout\,
	datad => \units_counter|Add0~0_combout\,
	combout => \units_counter|CONT[3]~10_combout\);

-- Location: LCCOMB_X42_Y35_N26
\units_counter|CONT[3]~11\ : cycloneii_lcell_comb
-- Equation(s):
-- \units_counter|CONT[3]~11_combout\ = (!\clr_int~2_combout\ & ((\EN~combout\ & (\units_counter|CONT[3]~10_combout\)) # (!\EN~combout\ & ((\units_counter|CONT\(3))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \EN~combout\,
	datab => \units_counter|CONT[3]~10_combout\,
	datac => \units_counter|CONT\(3),
	datad => \clr_int~2_combout\,
	combout => \units_counter|CONT[3]~11_combout\);

-- Location: LCFF_X42_Y35_N27
\units_counter|CONT[3]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLK~clkctrl_outclk\,
	datain => \units_counter|CONT[3]~11_combout\,
	aclr => \RST~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \units_counter|CONT\(3));

-- Location: LCCOMB_X42_Y35_N4
\clr_int~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \clr_int~1_combout\ = (\units_counter|CONT\(2)) # ((\tens_counter|CONT\(0)) # (\units_counter|CONT\(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \units_counter|CONT\(2),
	datac => \tens_counter|CONT\(0),
	datad => \units_counter|CONT\(3),
	combout => \clr_int~1_combout\);

-- Location: LCCOMB_X42_Y35_N18
\clr_int~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \clr_int~2_combout\ = (\CLR~combout\) # ((\tens_counter|CONT\(3)) # ((\clr_int~1_combout\ & \clr_int~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111011101110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CLR~combout\,
	datab => \tens_counter|CONT\(3),
	datac => \clr_int~1_combout\,
	datad => \clr_int~0_combout\,
	combout => \clr_int~2_combout\);

-- Location: LCCOMB_X42_Y35_N20
\tens_counter|CONT[0]~3\ : cycloneii_lcell_comb
-- Equation(s):
-- \tens_counter|CONT[0]~3_combout\ = (!\clr_int~2_combout\ & ((\tens_counter|CONT[3]~2_combout\ & (\tens_counter|CONT[0]~0_combout\)) # (!\tens_counter|CONT[3]~2_combout\ & ((\tens_counter|CONT\(0))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tens_counter|CONT[3]~2_combout\,
	datab => \tens_counter|CONT[0]~0_combout\,
	datac => \tens_counter|CONT\(0),
	datad => \clr_int~2_combout\,
	combout => \tens_counter|CONT[0]~3_combout\);

-- Location: LCFF_X42_Y35_N21
\tens_counter|CONT[0]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLK~clkctrl_outclk\,
	datain => \tens_counter|CONT[0]~3_combout\,
	aclr => \RST~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \tens_counter|CONT\(0));

-- Location: LCCOMB_X41_Y35_N30
\tens_counter|CONT[1]~4\ : cycloneii_lcell_comb
-- Equation(s):
-- \tens_counter|CONT[1]~4_combout\ = (\LD~combout\ & (\LOAD~combout\(5))) # (!\LD~combout\ & ((\tens_counter|CONT\(1) $ (\tens_counter|CONT\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000101110111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \LOAD~combout\(5),
	datab => \LD~combout\,
	datac => \tens_counter|CONT\(1),
	datad => \tens_counter|CONT\(0),
	combout => \tens_counter|CONT[1]~4_combout\);

-- Location: LCCOMB_X41_Y35_N28
\tens_counter|CONT[1]~5\ : cycloneii_lcell_comb
-- Equation(s):
-- \tens_counter|CONT[1]~5_combout\ = (!\clr_int~2_combout\ & ((\tens_counter|CONT[3]~2_combout\ & (\tens_counter|CONT[1]~4_combout\)) # (!\tens_counter|CONT[3]~2_combout\ & ((\tens_counter|CONT\(1))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tens_counter|CONT[3]~2_combout\,
	datab => \tens_counter|CONT[1]~4_combout\,
	datac => \tens_counter|CONT\(1),
	datad => \clr_int~2_combout\,
	combout => \tens_counter|CONT[1]~5_combout\);

-- Location: LCFF_X41_Y35_N29
\tens_counter|CONT[1]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLK~clkctrl_outclk\,
	datain => \tens_counter|CONT[1]~5_combout\,
	aclr => \RST~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \tens_counter|CONT\(1));

-- Location: LCCOMB_X41_Y35_N12
\tens_counter|CONT[2]~6\ : cycloneii_lcell_comb
-- Equation(s):
-- \tens_counter|CONT[2]~6_combout\ = (!\LD~combout\ & (\tens_counter|CONT\(2) $ (((\tens_counter|CONT\(1) & \tens_counter|CONT\(0))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001010001000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \LD~combout\,
	datab => \tens_counter|CONT\(2),
	datac => \tens_counter|CONT\(1),
	datad => \tens_counter|CONT\(0),
	combout => \tens_counter|CONT[2]~6_combout\);

-- Location: LCCOMB_X41_Y35_N18
\tens_counter|CONT[2]~7\ : cycloneii_lcell_comb
-- Equation(s):
-- \tens_counter|CONT[2]~7_combout\ = (\tens_counter|CONT[2]~6_combout\) # ((\LOAD~combout\(6) & \LD~combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \LOAD~combout\(6),
	datac => \LD~combout\,
	datad => \tens_counter|CONT[2]~6_combout\,
	combout => \tens_counter|CONT[2]~7_combout\);

-- Location: LCCOMB_X41_Y35_N2
\tens_counter|CONT[2]~8\ : cycloneii_lcell_comb
-- Equation(s):
-- \tens_counter|CONT[2]~8_combout\ = (!\clr_int~2_combout\ & ((\tens_counter|CONT[3]~2_combout\ & (\tens_counter|CONT[2]~7_combout\)) # (!\tens_counter|CONT[3]~2_combout\ & ((\tens_counter|CONT\(2))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \tens_counter|CONT[3]~2_combout\,
	datab => \tens_counter|CONT[2]~7_combout\,
	datac => \tens_counter|CONT\(2),
	datad => \clr_int~2_combout\,
	combout => \tens_counter|CONT[2]~8_combout\);

-- Location: LCFF_X41_Y35_N3
\tens_counter|CONT[2]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLK~clkctrl_outclk\,
	datain => \tens_counter|CONT[2]~8_combout\,
	aclr => \RST~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \tens_counter|CONT\(2));

-- Location: LCCOMB_X41_Y35_N20
\tens_counter|CONT[3]~9\ : cycloneii_lcell_comb
-- Equation(s):
-- \tens_counter|CONT[3]~9_combout\ = (!\CLR~combout\ & (!\tens_counter|CONT\(3) & ((!\tens_counter|CONT\(1)) # (!\tens_counter|CONT\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000010101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CLR~combout\,
	datab => \tens_counter|CONT\(2),
	datac => \tens_counter|CONT\(1),
	datad => \tens_counter|CONT\(3),
	combout => \tens_counter|CONT[3]~9_combout\);

-- Location: LCCOMB_X42_Y35_N0
\tens_counter|CONT[3]~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \tens_counter|CONT[3]~1_combout\ = (\EN~combout\ & (!\units_counter|CONT\(1) & (!\units_counter|CONT\(2) & \units_counter|CONT\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \EN~combout\,
	datab => \units_counter|CONT\(1),
	datac => \units_counter|CONT\(2),
	datad => \units_counter|CONT\(3),
	combout => \tens_counter|CONT[3]~1_combout\);

-- Location: LCCOMB_X42_Y35_N6
\tens_counter|CONT[3]~2\ : cycloneii_lcell_comb
-- Equation(s):
-- \tens_counter|CONT[3]~2_combout\ = (\units_counter|CONT\(0) & \tens_counter|CONT[3]~1_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \units_counter|CONT\(0),
	datad => \tens_counter|CONT[3]~1_combout\,
	combout => \tens_counter|CONT[3]~2_combout\);

-- Location: LCCOMB_X42_Y35_N30
\tens_counter|CONT[3]~10\ : cycloneii_lcell_comb
-- Equation(s):
-- \tens_counter|CONT[3]~10_combout\ = (\LOAD~combout\(7) & (\LD~combout\ & (\tens_counter|CONT[3]~9_combout\ & \tens_counter|CONT[3]~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \LOAD~combout\(7),
	datab => \LD~combout\,
	datac => \tens_counter|CONT[3]~9_combout\,
	datad => \tens_counter|CONT[3]~2_combout\,
	combout => \tens_counter|CONT[3]~10_combout\);

-- Location: LCFF_X42_Y35_N31
\tens_counter|CONT[3]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLK~clkctrl_outclk\,
	datain => \tens_counter|CONT[3]~10_combout\,
	aclr => \RST~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \tens_counter|CONT\(3));

-- Location: PIN_F16,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\CLR~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "input",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => GND,
	padio => ww_CLR,
	combout => \CLR~combout\);

-- Location: LCCOMB_X41_Y35_N26
\units_counter|CONT~0\ : cycloneii_lcell_comb
-- Equation(s):
-- \units_counter|CONT~0_combout\ = (!\CLR~combout\ & ((\LD~combout\ & (\LOAD~combout\(0))) # (!\LD~combout\ & ((!\units_counter|CONT\(0))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010001011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \LOAD~combout\(0),
	datab => \LD~combout\,
	datac => \units_counter|CONT\(0),
	datad => \CLR~combout\,
	combout => \units_counter|CONT~0_combout\);

-- Location: LCCOMB_X42_Y35_N16
\units_counter|CONT~1\ : cycloneii_lcell_comb
-- Equation(s):
-- \units_counter|CONT~1_combout\ = (!\tens_counter|CONT\(3) & (\units_counter|CONT~0_combout\ & ((!\clr_int~0_combout\) # (!\clr_int~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \clr_int~1_combout\,
	datab => \tens_counter|CONT\(3),
	datac => \units_counter|CONT~0_combout\,
	datad => \clr_int~0_combout\,
	combout => \units_counter|CONT~1_combout\);

-- Location: LCFF_X42_Y35_N17
\units_counter|CONT[0]\ : cycloneii_lcell_ff
PORT MAP (
	clk => \CLK~clkctrl_outclk\,
	datain => \units_counter|CONT~1_combout\,
	aclr => \RST~clkctrl_outclk\,
	ena => \units_counter|CONT[0]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \units_counter|CONT\(0));

-- Location: PIN_G15,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\Q[0]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \units_counter|CONT\(0),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_Q(0));

-- Location: PIN_D16,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\Q[1]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \units_counter|CONT\(1),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_Q(1));

-- Location: PIN_H15,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\Q[2]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \units_counter|CONT\(2),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_Q(2));

-- Location: PIN_H16,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\Q[3]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \units_counter|CONT\(3),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_Q(3));

-- Location: PIN_F15,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\Q[4]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \tens_counter|CONT\(0),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_Q(4));

-- Location: PIN_B16,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\Q[5]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \tens_counter|CONT\(1),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_Q(5));

-- Location: PIN_C16,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\Q[6]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \tens_counter|CONT\(2),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_Q(6));

-- Location: PIN_E15,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 24mA
\Q[7]~I\ : cycloneii_io
-- pragma translate_off
GENERIC MAP (
	input_async_reset => "none",
	input_power_up => "low",
	input_register_mode => "none",
	input_sync_reset => "none",
	oe_async_reset => "none",
	oe_power_up => "low",
	oe_register_mode => "none",
	oe_sync_reset => "none",
	operation_mode => "output",
	output_async_reset => "none",
	output_power_up => "low",
	output_register_mode => "none",
	output_sync_reset => "none")
-- pragma translate_on
PORT MAP (
	datain => \tens_counter|CONT\(3),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	devoe => ww_devoe,
	oe => VCC,
	padio => ww_Q(7));
END structure;


