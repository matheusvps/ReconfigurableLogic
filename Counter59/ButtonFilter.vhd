library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ButtonFilter is
    port(
        clk       : in std_logic;  -- Clock de 100Hz (0.01s) do divisor
        button_in : in std_logic;
        button_out : out std_logic
    );
end entity;

Architecture A_ButtonFilter of ButtonFilter is
    constant DEBOUNCE_CYCLES : integer := 3; -- 3 ciclos de 10ms = 30ms
    signal counter : integer range 0 to DEBOUNCE_CYCLES := 0;
    signal button_state : std_logic := '1';
    
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if button_in = '0' then  -- Botão pressionado
                if counter < DEBOUNCE_CYCLES then
                    counter <= counter + 1;
                else
                    button_state <= '1'; -- Botão confirmado pressionado
                end if;
            else  -- Botão solto
                counter <= 0;
                button_state <= '0';
            end if;
        end if;
    end process;
    
    button_out <= button_state;
    
end architecture;