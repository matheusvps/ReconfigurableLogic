library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Counter99_tb is
end entity;

architecture sim of Counter99_tb is

    -- componente sob teste
    component Counter99 is
        port(
            RST   : in  std_logic;
            CLK   : in  std_logic;
            EN    : in  std_logic;
            CLR   : in  std_logic;
            LD    : in  std_logic;
            LOAD  : in  std_logic_vector(7 downto 0);
            Q     : out std_logic_vector(7 downto 0)
        );
    end component;

    -- sinais de simulação
    signal clk   : std_logic := '0';
    signal rst   : std_logic := '0';
    signal en    : std_logic := '0';
    signal clr   : std_logic := '0';
    signal ld    : std_logic := '0';
    signal load  : std_logic_vector(7 downto 0) := (others => '0');
    signal q     : std_logic_vector(7 downto 0);

    -- constante do clock
    constant period_time : time := 20 ns;
    signal finished : std_logic := '0';

begin

    -- instância do DUT (Device Under Test)
    UUT: Counter99
        port map(
            RST  => rst,
            CLK  => clk,
            EN   => en,
            CLR  => clr,
            LD   => ld,
            LOAD => load,
            Q    => q
        );

    -- Clock process
    clk_proc: process
    begin
        while finished /= '1' loop
            clk <= '0';
            wait for period_time/2;
            clk <= '1';
            wait for period_time/2;
        end loop;
        wait;
    end process clk_proc;

    -- Reset global
    reset_proc: process
    begin
        rst <= '1';
        wait for 15 ns;
        rst <= '0';
        wait;
    end process reset_proc;

    -- Estímulos de teste
    stim_proc: process
    begin
        -- libera o contador
        en   <= '1';
        clr  <= '0';
        ld   <= '0';
        load <= (others => '0');

        -- deixa rodar até uns 450 ns
        wait for 450 ns;

        -- força um clear
        clr <= '1';
        wait for period_time;
        clr <= '0';

        -- deixa rodar mais um pouco
        wait for 450 ns;

        -- pausa a contagem (EN = 0)
        en <= '0';
        wait for 400 ns;

        -- ativa de novo
        en <= '1';
        wait for 400 ns;

        -- agora testa o carregamento de valor (LD + LOAD)
        ld   <= '1';
        load <= "00101001"; -- carrega decimal 29

        -- espera até a próxima borda de subida do clock para garantir que o load seja capturado
        wait until rising_edge(clk);

        -- desativa LD após a borda de clock
        ld <= '0';

        -- pequena espera para observar Q estável
        wait for period_time;

        -- deixa rodar bastante para observar wrap em 99
        wait for 1000 ns;

        finished <= '1';
        wait;
    end process stim_proc;

end architecture;

