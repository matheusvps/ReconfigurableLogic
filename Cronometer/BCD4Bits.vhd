Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity BCD4Bits is
	port(
	NumIn  : in unsigned(3 downto 0);
	
	outA   : out std_logic;
	outB   : out std_logic;
	outC   : out std_logic;
	outD   : out std_logic;
	outE   : out std_logic;
	outF   : out std_logic;
	outG   : out std_logic);
	
end entity;

Architecture A_BCD4Bits of BCD4Bits is
	
	signal N0, N1, N2, N3 : std_logic := '0';
	
	
	begin 
	N0 <= numIn(0);
	N1 <= numIn(1);
	N2 <= numIn(2);
	N3 <= numIn(3);
	
	
	outA <= ((not N0 and not N2) or (N3 and not N0) or (N1 and not N3) or (N1 and N2) or (not N3 and N2 and not N1 and N0) or (N3 and not N2 and not N1 and N0));
	outB <= not((not N3 and N2 and not N1 and N0) or (N3 and not N2 and N1 and N0));
	outC <= not(not N3 and not N2 and N1 and not N0);
	outD <= not((not N3 and N2 and not N1 and not N0) or (not N3 and not N2 and not N1 and N0) or (N2 and N1 and N0) or (N3 and not N2 and N1 and not N0));
	outE <= ((not N0 and not N2) or (not N3 and N1 and not N0) or (N3 and not N2 and N1) or (N3 and N2 and not N1 and N0));
	outF <= not((N3 and N2) or (not N3 and N1) or (not N3 and not N2 and N0));
	outG <= not((not N3 and not N2 and not N1) or (not N3 and N2 and N1 and N0) or (N3 and N2 and not N1 and not N0));

end Architecture;
	