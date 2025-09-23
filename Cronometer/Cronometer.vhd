Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Entity Cronometer is
	port(
		startStop  : in std_logic;
		reset      : in std_logic;
		secondsOut : out unsigned(7 downto 0);
		centSecondsOut : out unsigned (7 downto 0)
	);
end entity;

architecture a_Cronometer of Cronometer is
begin
end architecture;