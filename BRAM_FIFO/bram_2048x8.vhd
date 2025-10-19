-- ===================================================================================
-- BRAM_2048x8.vhd
-- Entidade para Block RAM de 2048 palavras de 8 bits
-- ===================================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity BRAM_2048x8 is
    Port (
        clk     : in  STD_LOGIC;
        rst     : in  STD_LOGIC;
        we      : in  STD_LOGIC;
        addr    : in  STD_LOGIC_VECTOR(10 downto 0);  -- 2^11 = 2048 endereços
        din     : in  STD_LOGIC_VECTOR(7 downto 0);
        dout    : out STD_LOGIC_VECTOR(7 downto 0)
    );
end BRAM_2048x8;

architecture Behavioral of BRAM_2048x8 is
    type ram_type is array (0 to 2047) of STD_LOGIC_VECTOR(7 downto 0);
    signal ram : ram_type := (others => (others => '0'));
    
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                ram <= (others => (others => '0'));
                dout <= (others => '0');
            else
                if we = '1' then
                    ram(to_integer(unsigned(addr))) <= din;
                end if;
                dout <= ram(to_integer(unsigned(addr)));
            end if;
        end if;
    end process;
end Behavioral;
