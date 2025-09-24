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
	
	begin
	
	
End Architecture;