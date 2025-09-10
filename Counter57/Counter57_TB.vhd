library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Counter57_TB is
end entity;

architecture arch of Counter57_TB is
    component Counter57 is
        port(
            rst_i   : in  std_logic;
            clk_i   : in  std_logic;
            q_o     : out std_logic_vector(7 downto 0);
            en_i    : in  std_logic;
            clr_i   : in  std_logic;
            ld_i    : in  std_logic;
            load_i  : in  std_logic_vector(7 downto 0)
        );
    end component;  

    -- Sinais de simulação
    signal clk_tb   : std_logic;
    signal rst_tb   : std_logic;
    signal q_tb     : std_logic_vector(7 downto 0);
    signal en_tb    : std_logic;
    signal clr_tb   : std_logic;
    signal ld_tb    : std_logic;
    signal dload_tb  : std_logic_vector(7 downto 0);

    -- Constantes
    constant period_time : time := 20 ns;
    signal finished : std_logic := '0';
    
begin
    UUT: Counter57
        port map(
            rst_i  => rst_tb,
            clk_i  => clk_tb,
            q_o    => q_tb,
            en_i   => en_tb,
            clr_i  => clr_tb,
            ld_i   => ld_tb,
            load_i => dload_tb
        );

    -- Clock
    clk_proc: process
    begin
        while finished /= '1' loop
            clk_tb <= '0';
            wait for period_time/2;
            clk_tb <= '1';
            wait for period_time/2;
        end loop;
        wait;
    end process clk_proc;

    -- Reset global
    reset_global: process
    begin
        rst_tb <= '1';
        wait for 15 ns;
        rst_tb <= '0';
        wait;
    end process reset_global;    

    -- Testbench
    stim_proc: process
    begin 
        en_tb   <= '1';
        clr_tb  <= '0';
        ld_tb   <= '0';
        dload_tb <= (others => '0');
        
        wait for 450 ns;
        
        clr_tb <= '1';
        wait for period_time;
        clr_tb <= '0';

        wait for 450 ns;

        ld_tb   <= '1';
        dload_tb <= "00101000";

        wait for period_time;
        ld_tb <= '0';

        wait for 400 ns;
        en_tb <= '0';

        wait for 400 ns;
        en_tb <= '1';

        wait for 1000 ns;

        ld_tb   <= '1';
        dload_tb <= "00000001";

        wait for period_time;

        ld_tb   <= '0';
        dload_tb <= "10000000";

        wait for 100 ns;

        ld_tb <= '1';

        wait for period_time;

        ld_tb <= '0';

        wait;
    end process;
end architecture;
