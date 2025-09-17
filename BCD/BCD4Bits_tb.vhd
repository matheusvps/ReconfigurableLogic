library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity BCD4Bits_tb is
end entity;

Architecture test of BCD4Bits_tb is

	component BCD4Bits is 
	
	port(
		NumIn  : in unsigned(3 downto 0);
	
		outA   : out std_logic;
		outB   : out std_logic;
		outC   : out std_logic;
		outD   : out std_logic;
		outE   : out std_logic;
		outF   : out std_logic;
		outG   : out std_logic);
	end component;
	
	-- Signal Definitions
	
	signal NumIn_s : unsigned(3 downto 0) := "0000";
	signal outA_s, outB_s, outC_s, outD_s, outE_s, outF_s, outG_s : std_logic := '0';
	
	-- Constant Definitions
	
	constant period_time : time := 30 ns;
	
	begin
	
	circuit : BCD4Bits
		port map(
			NumIn => NumIn_s,
	
			outA => outA_s,
			outB => outB_s,
			outC => outC_s,
			outD => outD_s,
			outE => outE_s,
			outF => outF_s,
			outG => outG_s
		);
		
	simulationProcess : process begin
		-- Process goes from 0 to 9 and resets, comparisons below:
		-- 0 : outA 1, outB 1, outC 1, outD 1, outE 1, outF 1, outG 0. 
		-- 1 : outA 0, outB 1, outC 1, outD 0, outE 0, outF 0, outG 0. 
		-- 2 : outA 1, outB 1, outC 0, outD 1, outE 1, outF 0, outG 1. 
		-- 3 : outA 1, outB 1, outC 1, outD 1, outE 0, outF 0, outG 1. 
		-- 4 : outA 0, outB 1, outC 1, outD 0, outE 0, outF 1, outG 1. 
		-- 5 : outA 1, outB 0, outC 1, outD 1, outE 0, outF 1, outG 1. 
		-- 6 : outA 1, outB 1, outC 1, outD 1, outE 1, outF 0, outG 1. 
		-- 7 : outA 1, outB 1, outC 1, outD 0, outE 0, outF 0, outG 0. 
		-- 8 : outA 1, outB 1, outC 1, outD 1, outE 1, outF 1, outG 1. 
		-- 9 : outA 1, outB 1, outC 1, outD 1, outE 0, outF 1, outG 1. 
		
	
		NumIn_s <= "0000";
		
		while numIn_s < 16 loop
			
			wait for period_time;
			
			numIn_s <= numIn_s + 1;
			
		end loop;
			
		wait;
	end process;
	
end architecture;
		