Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


Entity Counter4 is
	PORT(rst: in std_logic;
	     clk: in std_logic;
		  Q: out unsigned(3 downto 0);
		  en: in std_logic;
		  clr: in std_logic;
		  ld_en:  in std_logic;
		  load: in unsigned (3 downto 0));
end entity;  
Architecture X of Counter4 is
Signal CONT: unsigned (3 downto 0);
Begin
	Process (clk, rst)
		Begin
		If rst = '1' then
		   CONT <= "0000";
		Elsif clk' event and clk = '1' then
		   If clr = '1'then
				CONT <= "0000";
			Else
				If en = '1' then
					If ld_en = '1' then
						CONT <= load;
					Else
						CONT <= CONT+1;
					End IF;
				End If;
			End If;
		End If;
	End process;
	Q <= CONT;
End architecture;
