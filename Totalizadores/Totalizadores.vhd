library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


Entity Totalizadores is
	port(
	
		inputWord : in unsigned(3 downto 0);
		clk       : in std_logic;
		
		variablesForOut : out unsigned(2 downto 0);
		variablesWhileOut : out unsigned(2 downto 0);
		variablesIfThen : out unsigned(2 downto 0);
		signalsCaseWhenOut : out unsigned(2 downto 0);
		signalsDirectSumOut : out unsigned(2 downto 0)
	);
end entity;


Architecture A_Totalizadores of Totalizadores is

	signal b0, b1, b2, b3 : unsigned(2 downto 0);

begin

	-- sinais auxiliares (CASE/WHEN) para cada bit
	with inputWord(0) select b0 <=
		"001" when '1',
		"000" when others;

	with inputWord(1) select b1 <=
		"001" when '1',
		"000" when others;

	with inputWord(2) select b2 <=
		"001" when '1',
		"000" when others;

	with inputWord(3) select b3 <=
		"001" when '1',
		"000" when others;

	process(clk)
		variable cnt_for   : unsigned(2 downto 0);
		variable cnt_while : unsigned(2 downto 0);
		variable cnt_if    : unsigned(2 downto 0);
		variable i         : integer range 0 to 4;
		variable w         : integer range 0 to 4;
	begin
		if rising_edge(clk) then
			-- b.1) VARIABLES FOR
			cnt_for := (others => '0');
			for i in 0 to 3 loop
				if inputWord(i) = '1' then
					cnt_for := cnt_for + 1;
				end if;
			end loop;
			variablesForOut <= cnt_for;

			-- b.2) VARIABLES WHILE
			cnt_while := (others => '0');
			w := 0;
			while w <= 3 loop
				if inputWord(w) = '1' then
					cnt_while := cnt_while + 1;
				end if;
				w := w + 1;
			end loop;
			variablesWhileOut <= cnt_while;

			-- b.3) VARIABLES (IF then)
			cnt_if := (others => '0');
			if inputWord(0) = '1' then
				cnt_if := cnt_if + 1;
			end if;
			if inputWord(1) = '1' then
				cnt_if := cnt_if + 1;
			end if;
			if inputWord(2) = '1' then
				cnt_if := cnt_if + 1;
			end if;
			if inputWord(3) = '1' then
				cnt_if := cnt_if + 1;
			end if;
			variablesIfThen <= cnt_if;

			-- b.4) SIGNALS (case/when): somatório dos 4 sinais auxiliares
			signalsCaseWhenOut <= b0 + b1 + b2 + b3;

			-- b.5) SIGNALS (soma direta com conversão direta dos bits de entrada)
			signalsDirectSumOut <= unsigned("00" & inputWord(0)) +
							     unsigned("00" & inputWord(1)) +
							     unsigned("00" & inputWord(2)) +
							     unsigned("00" & inputWord(3));
		end if;
	end process;

End Architecture;