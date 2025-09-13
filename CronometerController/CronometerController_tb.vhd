library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity CronometerController_tb is
end entity;

architecture testbench of CronometerController_tb is

    -- Componente a ser testado
    component CronometerController is
        port (
            btn_clear     : in  std_logic;
            btn_pause     : in  std_logic;
            btn_reset     : in  std_logic;
            current_state : out std_logic_vector(1 downto 0)
        );
    end component;

    -- Sinais de estímulo
    signal btn_clear_s, btn_pause_s, btn_reset_s : std_logic := '1';
    signal state_out : std_logic_vector(1 downto 0) := "00";

    constant period_time : time := 100 ns;

begin

    -- Instanciação da UUT
    UUT: CronometerController
        port map(
            btn_clear     => btn_clear_s,
            btn_pause     => btn_pause_s,
            btn_reset     => btn_reset_s,
            current_state => state_out
        );

    -- Processo de reset global
    reset_proc: process
    begin
        btn_reset_s <= '1';
        wait for period_time*2;
        btn_reset_s <= '0';
        wait;
    end process;

    -- Processo de estímulos
    stimulus_proc: process
    begin
        wait for 400 ns;

        -- Teste do botão clear
        btn_clear_s <= '0';
        wait for 150 ns;
        btn_clear_s <= '1';
        wait for 300 ns;

        -- Teste do botão pause
        btn_pause_s <= '0';
        wait for 150 ns;
        btn_pause_s <= '1';
        wait for 300 ns;

        btn_pause_s <= '0';
        wait for 150 ns;
        btn_pause_s <= '1';
        wait for 300 ns;

        btn_pause_s <= '0';
        wait for 150 ns;
        btn_pause_s <= '1';
        wait for 300 ns;

        -- Novo teste do botão clear
        btn_clear_s <= '0';
        wait for 150 ns;
        btn_clear_s <= '1';
        wait for 500 ns;

        wait;
    end process;

end architecture;
