library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity CronometerController is
    port (
        btn_clear   : in  std_logic;
        btn_pause   : in  std_logic;
        btn_reset   : in  std_logic;
        current_state : out std_logic_vector(1 downto 0)
    );
end entity CronometerController;

architecture behavioral of CronometerController is

    signal internal_state : std_logic_vector(1 downto 0) := "00";
    -- 00 - Reset
    -- 01 - Active
    -- 10 - Paused

begin

    process(btn_reset, btn_clear, btn_pause)
    begin
        if btn_reset = '1' then
            internal_state <= "00";
        elsif btn_clear = '0' and internal_state = "10" then
            internal_state <= "00";
        elsif btn_pause = '0' and internal_state = "01" then
            internal_state <= "10";
        elsif btn_pause = '0' and (internal_state = "10" or internal_state = "00") then
            internal_state <= "01";
        end if;
    end process;

    current_state <= internal_state;

end behavioral;
