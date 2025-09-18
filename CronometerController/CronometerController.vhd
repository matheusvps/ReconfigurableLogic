library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity CronometerController is
    port (
        btn_pause        : in  std_logic;
        btn_reset        : in  std_logic;
        current_state    : out std_logic;
		  cronometer_reset : out std_logic
    );
end entity CronometerController;

architecture behavioral of CronometerController is

    signal internal_state : std_logic := '0';
	 signal internal_reset : std_logic := '0';
    -- 0 - Paused
    -- 1 - Active

begin

    process(btn_reset, btn_pause)
    begin
        if (btn_reset = '0' and internal_state = '0') then
				internal_reset <= '1';
        elsif btn_pause = '0' and internal_state = '0' then -- Se o cronômetro está pausado
				internal_reset <= '0';
            internal_state <= '1';
        elsif btn_pause = '0' and (internal_state = '1') then -- Se o cronômetro está ativo
            internal_state <= '0';
        end if;
    end process;

    current_state <= internal_state;
	 cronometer_reset  <= internal_reset;

end behavioral;
