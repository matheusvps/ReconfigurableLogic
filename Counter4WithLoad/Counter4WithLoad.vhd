Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Entity Counter4WithLoad is
	PORT(RST: in std_logic;
	     CLK: in std_logic;
		  Q: out std_logic_vector(3 downto 0);
		  EN: in std_logic;
		  CLR: in std_logic;
		  LD:  in std_logic;
		  LOAD: in std_logic_vector (3 downto 0));
end entity;  
Architecture X of Counter4WithLoad is
Signal CONT: std_logic_vector (3 downto 0);
Begin
	Process (CLK, RST)
		Begin
		If RST = '1' then
		   CONT <= (others => '0');
		Elsif CLK' event and CLK = '1' then
		   If CLR = '1'then
				CONT <= (others => '0');
			Else
				If EN = '1' then
					If LD = '1' then
						CONT <= LOAD;
					Else
						CONT <= std_logic_vector(unsigned(CONT)+1); --,CONT'length
					End IF;
				End If;
			End If;
		End If;
	End process;
	
	Q <= CONT;
	
End architecture;
