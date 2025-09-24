library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Totalizadores_tb is
end entity;

architecture A_Totalizadores_tb of Totalizadores_tb is

	component Totalizadores is
		port(
			inputWord : in unsigned(3 downto 0);
			clk       : in std_logic;
			variablesForOut      : out unsigned(2 downto 0);
			variablesWhileOut    : out unsigned(2 downto 0);
			variablesIfThen      : out unsigned(2 downto 0);
			signalsCaseWhenOut   : out unsigned(2 downto 0);
			signalsDirectSumOut  : out unsigned(2 downto 0)
		);
	end component;

	signal inputWord_tb : unsigned(3 downto 0) := (others => '0');
	signal clk_tb       : std_logic := '0';
	signal for_tb, while_tb, if_tb, case_tb, sum_tb : unsigned(2 downto 0);
	constant period_time : time := 10 ns;
	signal finished : std_logic := '0';

	-- função local para popcount esperado
	function popcount4(u : unsigned(3 downto 0)) return unsigned is
		variable c : unsigned(2 downto 0) := (others => '0');
	begin
		for i in 0 to 3 loop
			if u(i) = '1' then
				c := c + 1;
			end if;
		end loop;
		return c;
	end function;

begin

	DUT : Totalizadores
		port map(
			inputWord => inputWord_tb,
			clk => clk_tb,
			variablesForOut => for_tb,
			variablesWhileOut => while_tb,
			variablesIfThen => if_tb,
			signalsCaseWhenOut => case_tb,
			signalsDirectSumOut => sum_tb
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

	stim_proc : process
		procedure drive_and_check(v : unsigned(3 downto 0)) is
			variable expected : unsigned(2 downto 0);
		begin
			-- aplica estímulo logo após a borda de descida, garantindo setup
			wait until falling_edge(clk_tb);
			inputWord_tb <= v;
			wait for period_time/10; -- pequena margem
			wait until rising_edge(clk_tb);
			expected := popcount4(v);
			assert for_tb = expected report "FOR mismatch" severity error;
			assert while_tb = expected report "WHILE mismatch" severity error;
			assert if_tb = expected report "IF mismatch" severity error;
			assert case_tb = expected report "CASE mismatch" severity error;
			assert sum_tb = expected report "SUM mismatch" severity error;
			assert (for_tb = while_tb) and (for_tb = if_tb) and (for_tb = case_tb) and (for_tb = sum_tb)
				report "Outputs diverged between methods" severity error;
		end procedure;
	begin
		-- varredura de alguns padrões
		drive_and_check("0000");
		drive_and_check("0001");
		drive_and_check("0010");
		drive_and_check("0011");
		drive_and_check("0101");
		drive_and_check("0111");
		drive_and_check("1010");
		drive_and_check("1111");

		-- testar todas as combinações (0..15)
		for k in 0 to 15 loop
			drive_and_check(to_unsigned(k, 4));
		end loop;

		finished <= '1';
		wait;
	end process;

end architecture;
