library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity SlowTotalizer_tb is
end entity;

architecture A_SlowTotalizer_tb of SlowTotalizer_tb is

	component SlowTotalizer is 
		port(
			input : in unsigned(3 downto 0);
			clk   : in std_logic;
			count : out unsigned(2 downto 0)
		);
	end component;
	
	signal input_tb : unsigned(3 downto 0) := "0000";
	signal count_tb : unsigned(2 downto 0) := "000";
	signal clk_tb : std_logic := '0';
	constant period_time : time := 1 ms;
	signal finished : std_logic := '0';
	
	begin
	
	DUT : SlowTotalizer 
		port map(
			input => input_tb,
			clk => clk_tb,
			count => count_tb
		);
	
	
	clk_proc : process begin
	
		while finished = '0' loop
			clk_tb <= '0';
			wait for period_time/2;
			clk_tb <= '1';
			wait for period_time/2;
		end loop;
		
		wait;
	end process;
	
	sim_process : process begin
		
		input_tb <= "0000";
		wait for period_time * 5;
		
		input_tb <= "1010";
		wait for period_time * 5;
		
		input_tb <= "1000";
		wait for period_time * 5;
		
		input_tb <= "1111";
		wait for period_time *5;
		
		finished <= '1';
		wait;
		
	end process;

end architecture;