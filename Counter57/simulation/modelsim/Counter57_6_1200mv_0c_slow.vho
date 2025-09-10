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

-- DATE "09/08/2025 23:27:31"

-- 
-- Device: Altera EP4CE22F17C6 Package FBGA256
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

ENTITY 	Counter57 IS
    PORT (
	rst_i : IN std_logic;
	clk_i : IN std_logic;
	q_o : OUT std_logic_vector(7 DOWNTO 0);
	en_i : IN std_logic;
	clr_i : IN std_logic;
	ld_i : IN std_logic;
	load_i : IN std_logic_vector(7 DOWNTO 0)
	);
END Counter57;

-- Design Ports Information
-- q_o[0]	=>  Location: PIN_J13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- q_o[1]	=>  Location: PIN_K16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- q_o[2]	=>  Location: PIN_L16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- q_o[3]	=>  Location: PIN_J15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- q_o[4]	=>  Location: PIN_L15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- q_o[5]	=>  Location: PIN_F13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- q_o[6]	=>  Location: PIN_J14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- q_o[7]	=>  Location: PIN_P9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ld_i	=>  Location: PIN_E16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- load_i[0]	=>  Location: PIN_E15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clr_i	=>  Location: PIN_J16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- rst_i	=>  Location: PIN_M2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clk_i	=>  Location: PIN_E1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- en_i	=>  Location: PIN_N15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- load_i[6]	=>  Location: PIN_K15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- load_i[3]	=>  Location: PIN_R16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- load_i[2]	=>  Location: PIN_G16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- load_i[5]	=>  Location: PIN_G15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- load_i[4]	=>  Location: PIN_N16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- load_i[7]	=>  Location: PIN_L13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- load_i[1]	=>  Location: PIN_L14,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF Counter57 IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_rst_i : std_logic;
SIGNAL ww_clk_i : std_logic;
SIGNAL ww_q_o : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_en_i : std_logic;
SIGNAL ww_clr_i : std_logic;
SIGNAL ww_ld_i : std_logic;
SIGNAL ww_load_i : std_logic_vector(7 DOWNTO 0);
SIGNAL \rst_i~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \clk_i~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \C1|CONT~2_combout\ : std_logic;
SIGNAL \ld_s~2_combout\ : std_logic;
SIGNAL \C1|Add0~0_combout\ : std_logic;
SIGNAL \C1|Add0~1_combout\ : std_logic;
SIGNAL \C2|Add0~0_combout\ : std_logic;
SIGNAL \C2|CONT[1]~5_combout\ : std_logic;
SIGNAL \C2|CONT[0]~7_combout\ : std_logic;
SIGNAL \load_i[0]~input_o\ : std_logic;
SIGNAL \clk_i~input_o\ : std_logic;
SIGNAL \en_i~input_o\ : std_logic;
SIGNAL \load_i[5]~input_o\ : std_logic;
SIGNAL \load_i[4]~input_o\ : std_logic;
SIGNAL \clk_i~inputclkctrl_outclk\ : std_logic;
SIGNAL \q_o[0]~output_o\ : std_logic;
SIGNAL \q_o[1]~output_o\ : std_logic;
SIGNAL \q_o[2]~output_o\ : std_logic;
SIGNAL \q_o[3]~output_o\ : std_logic;
SIGNAL \q_o[4]~output_o\ : std_logic;
SIGNAL \q_o[5]~output_o\ : std_logic;
SIGNAL \q_o[6]~output_o\ : std_logic;
SIGNAL \q_o[7]~output_o\ : std_logic;
SIGNAL \ld_i~input_o\ : std_logic;
SIGNAL \load_i[6]~input_o\ : std_logic;
SIGNAL \clr_i~input_o\ : std_logic;
SIGNAL \load_i[1]~input_o\ : std_logic;
SIGNAL \en_c2_s~combout\ : std_logic;
SIGNAL \C2|CONT[1]~6_combout\ : std_logic;
SIGNAL \rst_i~input_o\ : std_logic;
SIGNAL \rst_i~inputclkctrl_outclk\ : std_logic;
SIGNAL \C2|CONT[0]~8_combout\ : std_logic;
SIGNAL \ld_s~0_combout\ : std_logic;
SIGNAL \ld_s~1_combout\ : std_logic;
SIGNAL \load_i[3]~input_o\ : std_logic;
SIGNAL \C1|CONT~5_combout\ : std_logic;
SIGNAL \C1|CONT~6_combout\ : std_logic;
SIGNAL \C1|CONT[0]~4_combout\ : std_logic;
SIGNAL \load_i[2]~input_o\ : std_logic;
SIGNAL \C1|CONT~7_combout\ : std_logic;
SIGNAL \C1|CONT~8_combout\ : std_logic;
SIGNAL \ld_s~3_combout\ : std_logic;
SIGNAL \ld_s~4_combout\ : std_logic;
SIGNAL \C2|CONT[1]~0_combout\ : std_logic;
SIGNAL \C1|CONT~3_combout\ : std_logic;
SIGNAL \C1|CONT~10_combout\ : std_logic;
SIGNAL \C1|CONT~9_combout\ : std_logic;
SIGNAL \en_c2_s~0_combout\ : std_logic;
SIGNAL \C2|CONT[2]~1_combout\ : std_logic;
SIGNAL \C2|CONT[2]~2_combout\ : std_logic;
SIGNAL \C2|CONT[2]~3_combout\ : std_logic;
SIGNAL \C2|CONT[2]~4_combout\ : std_logic;
SIGNAL \q_o~2_combout\ : std_logic;
SIGNAL \q_o~3_combout\ : std_logic;
SIGNAL \load_i[7]~input_o\ : std_logic;
SIGNAL \C2|CONT[3]~9_combout\ : std_logic;
SIGNAL \q_o~4_combout\ : std_logic;
SIGNAL \q_o~5_combout\ : std_logic;
SIGNAL \q_o~6_combout\ : std_logic;
SIGNAL \q_o~7_combout\ : std_logic;
SIGNAL \q_o~8_combout\ : std_logic;
SIGNAL \q_o~9_combout\ : std_logic;
SIGNAL \q_o~10_combout\ : std_logic;
SIGNAL \q_o~11_combout\ : std_logic;
SIGNAL \C2|CONT\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \C1|CONT\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \ALT_INV_rst_i~inputclkctrl_outclk\ : std_logic;

BEGIN

ww_rst_i <= rst_i;
ww_clk_i <= clk_i;
q_o <= ww_q_o;
ww_en_i <= en_i;
ww_clr_i <= clr_i;
ww_ld_i <= ld_i;
ww_load_i <= load_i;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\rst_i~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \rst_i~input_o\);

\clk_i~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \clk_i~input_o\);
\ALT_INV_rst_i~inputclkctrl_outclk\ <= NOT \rst_i~inputclkctrl_outclk\;

-- Location: LCCOMB_X50_Y14_N8
\C1|CONT~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \C1|CONT~2_combout\ = (\load_i[0]~input_o\ & (!\clr_i~input_o\ & \ld_i~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \load_i[0]~input_o\,
	datac => \clr_i~input_o\,
	datad => \ld_i~input_o\,
	combout => \C1|CONT~2_combout\);

-- Location: LCCOMB_X51_Y14_N4
\ld_s~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \ld_s~2_combout\ = (\clr_i~input_o\) # ((\rst_i~input_o\) # (\C2|CONT\(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \clr_i~input_o\,
	datac => \rst_i~input_o\,
	datad => \C2|CONT\(3),
	combout => \ld_s~2_combout\);

-- Location: LCCOMB_X50_Y14_N30
\C1|Add0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \C1|Add0~0_combout\ = \C1|CONT\(3) $ (((\C1|CONT\(0) & (\C1|CONT\(1) & \C1|CONT\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110101010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \C1|CONT\(3),
	datab => \C1|CONT\(0),
	datac => \C1|CONT\(1),
	datad => \C1|CONT\(2),
	combout => \C1|Add0~0_combout\);

-- Location: LCCOMB_X50_Y14_N22
\C1|Add0~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \C1|Add0~1_combout\ = \C1|CONT\(2) $ (((\C1|CONT\(1) & \C1|CONT\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110011011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \C1|CONT\(1),
	datab => \C1|CONT\(2),
	datad => \C1|CONT\(0),
	combout => \C1|Add0~1_combout\);

-- Location: LCCOMB_X51_Y14_N24
\C2|Add0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \C2|Add0~0_combout\ = \C2|CONT\(1) $ (\C2|CONT\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \C2|CONT\(1),
	datad => \C2|CONT\(0),
	combout => \C2|Add0~0_combout\);

-- Location: LCCOMB_X51_Y14_N22
\C2|CONT[1]~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \C2|CONT[1]~5_combout\ = (\ld_i~input_o\ & (\load_i[5]~input_o\)) # (!\ld_i~input_o\ & (((\C2|Add0~0_combout\ & !\ld_s~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000010101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \load_i[5]~input_o\,
	datab => \C2|Add0~0_combout\,
	datac => \ld_i~input_o\,
	datad => \ld_s~4_combout\,
	combout => \C2|CONT[1]~5_combout\);

-- Location: LCCOMB_X51_Y14_N30
\C2|CONT[0]~7\ : cycloneive_lcell_comb
-- Equation(s):
-- \C2|CONT[0]~7_combout\ = (\ld_i~input_o\ & (\load_i[4]~input_o\)) # (!\ld_i~input_o\ & (((!\C2|CONT\(0) & !\ld_s~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000010100011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \load_i[4]~input_o\,
	datab => \C2|CONT\(0),
	datac => \ld_i~input_o\,
	datad => \ld_s~4_combout\,
	combout => \C2|CONT[0]~7_combout\);

-- Location: IOIBUF_X53_Y17_N1
\load_i[0]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_load_i(0),
	o => \load_i[0]~input_o\);

-- Location: IOIBUF_X0_Y16_N8
\clk_i~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clk_i,
	o => \clk_i~input_o\);

-- Location: IOIBUF_X53_Y9_N15
\en_i~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_en_i,
	o => \en_i~input_o\);

-- Location: IOIBUF_X53_Y20_N15
\load_i[5]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_load_i(5),
	o => \load_i[5]~input_o\);

-- Location: IOIBUF_X53_Y9_N22
\load_i[4]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_load_i(4),
	o => \load_i[4]~input_o\);

-- Location: CLKCTRL_G2
\clk_i~inputclkctrl\ : cycloneive_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \clk_i~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \clk_i~inputclkctrl_outclk\);

-- Location: IOOBUF_X53_Y16_N9
\q_o[0]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \q_o~5_combout\,
	devoe => ww_devoe,
	o => \q_o[0]~output_o\);

-- Location: IOOBUF_X53_Y12_N2
\q_o[1]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \q_o~6_combout\,
	devoe => ww_devoe,
	o => \q_o[1]~output_o\);

-- Location: IOOBUF_X53_Y11_N9
\q_o[2]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \q_o~7_combout\,
	devoe => ww_devoe,
	o => \q_o[2]~output_o\);

-- Location: IOOBUF_X53_Y14_N2
\q_o[3]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \q_o~8_combout\,
	devoe => ww_devoe,
	o => \q_o[3]~output_o\);

-- Location: IOOBUF_X53_Y11_N2
\q_o[4]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \q_o~9_combout\,
	devoe => ww_devoe,
	o => \q_o[4]~output_o\);

-- Location: IOOBUF_X53_Y21_N23
\q_o[5]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \q_o~10_combout\,
	devoe => ww_devoe,
	o => \q_o[5]~output_o\);

-- Location: IOOBUF_X53_Y15_N9
\q_o[6]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \q_o~11_combout\,
	devoe => ww_devoe,
	o => \q_o[6]~output_o\);

-- Location: IOOBUF_X38_Y0_N9
\q_o[7]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \q_o[7]~output_o\);

-- Location: IOIBUF_X53_Y17_N8
\ld_i~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_ld_i,
	o => \ld_i~input_o\);

-- Location: IOIBUF_X53_Y13_N8
\load_i[6]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_load_i(6),
	o => \load_i[6]~input_o\);

-- Location: IOIBUF_X53_Y14_N8
\clr_i~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clr_i,
	o => \clr_i~input_o\);

-- Location: IOIBUF_X53_Y9_N8
\load_i[1]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_load_i(1),
	o => \load_i[1]~input_o\);

-- Location: LCCOMB_X51_Y14_N16
en_c2_s : cycloneive_lcell_comb
-- Equation(s):
-- \en_c2_s~combout\ = (\ld_i~input_o\) # ((\ld_s~4_combout\) # ((\en_i~input_o\ & \en_c2_s~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \en_i~input_o\,
	datab => \en_c2_s~0_combout\,
	datac => \ld_i~input_o\,
	datad => \ld_s~4_combout\,
	combout => \en_c2_s~combout\);

-- Location: LCCOMB_X51_Y14_N14
\C2|CONT[1]~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \C2|CONT[1]~6_combout\ = (\en_c2_s~combout\ & (\C2|CONT[1]~5_combout\ & (!\clr_i~input_o\))) # (!\en_c2_s~combout\ & (((\C2|CONT\(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010001011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \C2|CONT[1]~5_combout\,
	datab => \clr_i~input_o\,
	datac => \C2|CONT\(1),
	datad => \en_c2_s~combout\,
	combout => \C2|CONT[1]~6_combout\);

-- Location: IOIBUF_X0_Y16_N15
\rst_i~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_rst_i,
	o => \rst_i~input_o\);

-- Location: CLKCTRL_G4
\rst_i~inputclkctrl\ : cycloneive_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \rst_i~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \rst_i~inputclkctrl_outclk\);

-- Location: FF_X51_Y14_N15
\C2|CONT[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \C2|CONT[1]~6_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \C2|CONT\(1));

-- Location: LCCOMB_X51_Y14_N12
\C2|CONT[0]~8\ : cycloneive_lcell_comb
-- Equation(s):
-- \C2|CONT[0]~8_combout\ = (\en_c2_s~combout\ & (\C2|CONT[0]~7_combout\ & (!\clr_i~input_o\))) # (!\en_c2_s~combout\ & (((\C2|CONT\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010001011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \C2|CONT[0]~7_combout\,
	datab => \clr_i~input_o\,
	datac => \C2|CONT\(0),
	datad => \en_c2_s~combout\,
	combout => \C2|CONT[0]~8_combout\);

-- Location: FF_X51_Y14_N13
\C2|CONT[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \C2|CONT[0]~8_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \C2|CONT\(0));

-- Location: LCCOMB_X51_Y14_N20
\ld_s~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \ld_s~0_combout\ = (!\C2|CONT\(1) & !\C2|CONT\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \C2|CONT\(1),
	datad => \C2|CONT\(0),
	combout => \ld_s~0_combout\);

-- Location: LCCOMB_X51_Y14_N26
\ld_s~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \ld_s~1_combout\ = (\C2|CONT\(2) & ((\C1|CONT\(2)) # ((\C2|CONT\(1)) # (\C2|CONT\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \C1|CONT\(2),
	datab => \C2|CONT\(1),
	datac => \C2|CONT\(2),
	datad => \C2|CONT\(0),
	combout => \ld_s~1_combout\);

-- Location: IOIBUF_X53_Y8_N22
\load_i[3]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_load_i(3),
	o => \load_i[3]~input_o\);

-- Location: LCCOMB_X50_Y14_N16
\C1|CONT~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \C1|CONT~5_combout\ = (\load_i[3]~input_o\) # (!\ld_i~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \load_i[3]~input_o\,
	datad => \ld_i~input_o\,
	combout => \C1|CONT~5_combout\);

-- Location: LCCOMB_X50_Y14_N26
\C1|CONT~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \C1|CONT~6_combout\ = (!\clr_i~input_o\ & ((\C2|CONT[1]~0_combout\ & (\C1|Add0~0_combout\)) # (!\C2|CONT[1]~0_combout\ & ((\C1|CONT~5_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010001000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \C1|Add0~0_combout\,
	datab => \clr_i~input_o\,
	datac => \C1|CONT~5_combout\,
	datad => \C2|CONT[1]~0_combout\,
	combout => \C1|CONT~6_combout\);

-- Location: LCCOMB_X51_Y14_N2
\C1|CONT[0]~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \C1|CONT[0]~4_combout\ = (\en_i~input_o\) # (\clr_i~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111011101110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \en_i~input_o\,
	datab => \clr_i~input_o\,
	combout => \C1|CONT[0]~4_combout\);

-- Location: FF_X50_Y14_N27
\C1|CONT[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \C1|CONT~6_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	ena => \C1|CONT[0]~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \C1|CONT\(3));

-- Location: IOIBUF_X53_Y20_N22
\load_i[2]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_load_i(2),
	o => \load_i[2]~input_o\);

-- Location: LCCOMB_X50_Y14_N28
\C1|CONT~7\ : cycloneive_lcell_comb
-- Equation(s):
-- \C1|CONT~7_combout\ = (\load_i[2]~input_o\) # (!\ld_i~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111101010101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ld_i~input_o\,
	datad => \load_i[2]~input_o\,
	combout => \C1|CONT~7_combout\);

-- Location: LCCOMB_X50_Y14_N12
\C1|CONT~8\ : cycloneive_lcell_comb
-- Equation(s):
-- \C1|CONT~8_combout\ = (!\clr_i~input_o\ & ((\C2|CONT[1]~0_combout\ & (\C1|Add0~1_combout\)) # (!\C2|CONT[1]~0_combout\ & ((\C1|CONT~7_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000101000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \C1|Add0~1_combout\,
	datab => \C1|CONT~7_combout\,
	datac => \clr_i~input_o\,
	datad => \C2|CONT[1]~0_combout\,
	combout => \C1|CONT~8_combout\);

-- Location: FF_X50_Y14_N13
\C1|CONT[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \C1|CONT~8_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	ena => \C1|CONT[0]~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \C1|CONT\(2));

-- Location: LCCOMB_X51_Y14_N10
\ld_s~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \ld_s~3_combout\ = (\C1|CONT\(3) & ((!\C1|CONT\(2)))) # (!\C1|CONT\(3) & (!\C2|CONT\(2)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001111110011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \C2|CONT\(2),
	datac => \C1|CONT\(3),
	datad => \C1|CONT\(2),
	combout => \ld_s~3_combout\);

-- Location: LCCOMB_X51_Y14_N28
\ld_s~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \ld_s~4_combout\ = (\ld_s~2_combout\) # ((\ld_s~1_combout\) # ((\ld_s~0_combout\ & \ld_s~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111011111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ld_s~2_combout\,
	datab => \ld_s~0_combout\,
	datac => \ld_s~1_combout\,
	datad => \ld_s~3_combout\,
	combout => \ld_s~4_combout\);

-- Location: LCCOMB_X50_Y14_N18
\C2|CONT[1]~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \C2|CONT[1]~0_combout\ = (!\ld_i~input_o\ & !\ld_s~4_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001010101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ld_i~input_o\,
	datad => \ld_s~4_combout\,
	combout => \C2|CONT[1]~0_combout\);

-- Location: LCCOMB_X50_Y14_N24
\C1|CONT~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \C1|CONT~3_combout\ = (\C1|CONT~2_combout\) # ((!\clr_i~input_o\ & (!\C1|CONT\(0) & \C2|CONT[1]~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101110101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \C1|CONT~2_combout\,
	datab => \clr_i~input_o\,
	datac => \C1|CONT\(0),
	datad => \C2|CONT[1]~0_combout\,
	combout => \C1|CONT~3_combout\);

-- Location: FF_X50_Y14_N25
\C1|CONT[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \C1|CONT~3_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	ena => \C1|CONT[0]~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \C1|CONT\(0));

-- Location: LCCOMB_X50_Y14_N0
\C1|CONT~10\ : cycloneive_lcell_comb
-- Equation(s):
-- \C1|CONT~10_combout\ = (!\ld_i~input_o\ & (!\ld_s~4_combout\ & (\C1|CONT\(0) $ (\C1|CONT\(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000010100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ld_i~input_o\,
	datab => \C1|CONT\(0),
	datac => \C1|CONT\(1),
	datad => \ld_s~4_combout\,
	combout => \C1|CONT~10_combout\);

-- Location: LCCOMB_X50_Y14_N14
\C1|CONT~9\ : cycloneive_lcell_comb
-- Equation(s):
-- \C1|CONT~9_combout\ = (!\clr_i~input_o\ & ((\C1|CONT~10_combout\) # ((\ld_i~input_o\ & \load_i[1]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001100100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ld_i~input_o\,
	datab => \clr_i~input_o\,
	datac => \load_i[1]~input_o\,
	datad => \C1|CONT~10_combout\,
	combout => \C1|CONT~9_combout\);

-- Location: FF_X50_Y14_N15
\C1|CONT[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \C1|CONT~9_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	ena => \C1|CONT[0]~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \C1|CONT\(1));

-- Location: LCCOMB_X50_Y14_N20
\en_c2_s~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \en_c2_s~0_combout\ = (\C1|CONT\(2) & (\C1|CONT\(1) & (\C1|CONT\(3) & \C1|CONT\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \C1|CONT\(2),
	datab => \C1|CONT\(1),
	datac => \C1|CONT\(3),
	datad => \C1|CONT\(0),
	combout => \en_c2_s~0_combout\);

-- Location: LCCOMB_X51_Y14_N18
\C2|CONT[2]~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \C2|CONT[2]~1_combout\ = (\ld_i~input_o\ & (((\load_i[6]~input_o\)))) # (!\ld_i~input_o\ & (\en_i~input_o\ & ((\en_c2_s~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100101011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \en_i~input_o\,
	datab => \load_i[6]~input_o\,
	datac => \ld_i~input_o\,
	datad => \en_c2_s~0_combout\,
	combout => \C2|CONT[2]~1_combout\);

-- Location: LCCOMB_X51_Y14_N0
\C2|CONT[2]~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \C2|CONT[2]~2_combout\ = (\C2|CONT\(1) & \C2|CONT\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \C2|CONT\(1),
	datad => \C2|CONT\(0),
	combout => \C2|CONT[2]~2_combout\);

-- Location: LCCOMB_X51_Y14_N6
\C2|CONT[2]~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \C2|CONT[2]~3_combout\ = (!\ld_s~4_combout\ & (\C2|CONT\(2) $ (((\C2|CONT[2]~2_combout\ & \C2|CONT[2]~1_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \C2|CONT\(2),
	datab => \C2|CONT[2]~2_combout\,
	datac => \C2|CONT[2]~1_combout\,
	datad => \ld_s~4_combout\,
	combout => \C2|CONT[2]~3_combout\);

-- Location: LCCOMB_X51_Y14_N8
\C2|CONT[2]~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \C2|CONT[2]~4_combout\ = (\ld_i~input_o\ & (!\clr_i~input_o\ & (\C2|CONT[2]~1_combout\))) # (!\ld_i~input_o\ & (\C2|CONT[2]~3_combout\ & ((!\C2|CONT[2]~1_combout\) # (!\clr_i~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101001101000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \clr_i~input_o\,
	datab => \ld_i~input_o\,
	datac => \C2|CONT[2]~1_combout\,
	datad => \C2|CONT[2]~3_combout\,
	combout => \C2|CONT[2]~4_combout\);

-- Location: FF_X51_Y14_N9
\C2|CONT[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \C2|CONT[2]~4_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \C2|CONT\(2));

-- Location: LCCOMB_X52_Y14_N24
\q_o~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \q_o~2_combout\ = (!\C2|CONT\(0) & (!\C2|CONT\(1) & ((!\C1|CONT\(3)) # (!\C1|CONT\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000010011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \C1|CONT\(2),
	datab => \C2|CONT\(0),
	datac => \C1|CONT\(3),
	datad => \C2|CONT\(1),
	combout => \q_o~2_combout\);

-- Location: LCCOMB_X52_Y14_N2
\q_o~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \q_o~3_combout\ = (\C1|CONT\(3)) # ((\C1|CONT\(2) & ((\C1|CONT\(0)) # (\C1|CONT\(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \C1|CONT\(0),
	datab => \C1|CONT\(2),
	datac => \C1|CONT\(3),
	datad => \C1|CONT\(1),
	combout => \q_o~3_combout\);

-- Location: IOIBUF_X53_Y10_N15
\load_i[7]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_load_i(7),
	o => \load_i[7]~input_o\);

-- Location: LCCOMB_X50_Y14_N10
\C2|CONT[3]~9\ : cycloneive_lcell_comb
-- Equation(s):
-- \C2|CONT[3]~9_combout\ = (!\clr_i~input_o\ & (\load_i[7]~input_o\ & \ld_i~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \clr_i~input_o\,
	datac => \load_i[7]~input_o\,
	datad => \ld_i~input_o\,
	combout => \C2|CONT[3]~9_combout\);

-- Location: FF_X51_Y14_N3
\C2|CONT[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	asdata => \C2|CONT[3]~9_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \C2|CONT\(3));

-- Location: LCCOMB_X52_Y14_N0
\q_o~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \q_o~4_combout\ = (\C2|CONT\(3)) # ((\C2|CONT\(2) & ((\q_o~3_combout\) # (!\ld_s~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ld_s~0_combout\,
	datab => \q_o~3_combout\,
	datac => \C2|CONT\(3),
	datad => \C2|CONT\(2),
	combout => \q_o~4_combout\);

-- Location: LCCOMB_X52_Y14_N26
\q_o~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \q_o~5_combout\ = (\C1|CONT\(0) & (!\q_o~4_combout\ & ((\C2|CONT\(2)) # (!\q_o~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \C2|CONT\(2),
	datab => \q_o~2_combout\,
	datac => \C1|CONT\(0),
	datad => \q_o~4_combout\,
	combout => \q_o~5_combout\);

-- Location: LCCOMB_X52_Y14_N8
\q_o~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \q_o~6_combout\ = (\C1|CONT\(1) & (!\q_o~4_combout\ & ((\C2|CONT\(2)) # (!\q_o~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \C2|CONT\(2),
	datab => \q_o~2_combout\,
	datac => \C1|CONT\(1),
	datad => \q_o~4_combout\,
	combout => \q_o~6_combout\);

-- Location: LCCOMB_X52_Y14_N6
\q_o~7\ : cycloneive_lcell_comb
-- Equation(s):
-- \q_o~7_combout\ = (\C1|CONT\(2)) # ((\q_o~4_combout\) # ((!\C2|CONT\(2) & \q_o~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111110100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \C2|CONT\(2),
	datab => \q_o~2_combout\,
	datac => \C1|CONT\(2),
	datad => \q_o~4_combout\,
	combout => \q_o~7_combout\);

-- Location: LCCOMB_X52_Y14_N20
\q_o~8\ : cycloneive_lcell_comb
-- Equation(s):
-- \q_o~8_combout\ = (\C1|CONT\(3)) # ((\q_o~4_combout\) # ((!\C2|CONT\(2) & \q_o~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111110100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \C2|CONT\(2),
	datab => \q_o~2_combout\,
	datac => \C1|CONT\(3),
	datad => \q_o~4_combout\,
	combout => \q_o~8_combout\);

-- Location: LCCOMB_X52_Y14_N22
\q_o~9\ : cycloneive_lcell_comb
-- Equation(s):
-- \q_o~9_combout\ = (\C2|CONT\(0) & (!\q_o~4_combout\ & ((\C2|CONT\(2)) # (!\q_o~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \C2|CONT\(2),
	datab => \q_o~2_combout\,
	datac => \C2|CONT\(0),
	datad => \q_o~4_combout\,
	combout => \q_o~9_combout\);

-- Location: LCCOMB_X52_Y14_N4
\q_o~10\ : cycloneive_lcell_comb
-- Equation(s):
-- \q_o~10_combout\ = (\C2|CONT\(1) & (!\q_o~4_combout\ & ((\C2|CONT\(2)) # (!\q_o~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \C2|CONT\(2),
	datab => \q_o~2_combout\,
	datac => \C2|CONT\(1),
	datad => \q_o~4_combout\,
	combout => \q_o~10_combout\);

-- Location: LCCOMB_X52_Y14_N10
\q_o~11\ : cycloneive_lcell_comb
-- Equation(s):
-- \q_o~11_combout\ = (\ld_s~0_combout\ & (!\q_o~3_combout\ & (!\C2|CONT\(3) & \C2|CONT\(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ld_s~0_combout\,
	datab => \q_o~3_combout\,
	datac => \C2|CONT\(3),
	datad => \C2|CONT\(2),
	combout => \q_o~11_combout\);

ww_q_o(0) <= \q_o[0]~output_o\;

ww_q_o(1) <= \q_o[1]~output_o\;

ww_q_o(2) <= \q_o[2]~output_o\;

ww_q_o(3) <= \q_o[3]~output_o\;

ww_q_o(4) <= \q_o[4]~output_o\;

ww_q_o(5) <= \q_o[5]~output_o\;

ww_q_o(6) <= \q_o[6]~output_o\;

ww_q_o(7) <= \q_o[7]~output_o\;
END structure;


