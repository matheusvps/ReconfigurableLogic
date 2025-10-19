-- ===================================================================================
-- BRAM_FIFO_TB.vhd
-- Testbench para simulação do sistema BRAM-FIFO
-- ===================================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity BRAM_FIFO_TB is
end BRAM_FIFO_TB;

architecture Behavioral of BRAM_FIFO_TB is
    component BRAM_FIFO_CONTROLLER
        Port (
            clk         : in  STD_LOGIC;
            rst         : in  STD_LOGIC;
            write_state : out STD_LOGIC_VECTOR(2 downto 0);
            read_state  : out STD_LOGIC_VECTOR(1 downto 0);
            fifo_count  : out STD_LOGIC_VECTOR(9 downto 0);
            fifo_full   : out STD_LOGIC;
            fifo_empty  : out STD_LOGIC;
            bram1_addr  : out STD_LOGIC_VECTOR(10 downto 0);
            bram2_addr  : out STD_LOGIC_VECTOR(10 downto 0);
            start       : in  STD_LOGIC;
            done        : out STD_LOGIC
        );
    end component;
    
    -- Sinais de teste
    signal clk : STD_LOGIC := '0';
    signal rst : STD_LOGIC := '0';
    signal start : STD_LOGIC := '0';
    signal done : STD_LOGIC;
    
    signal write_state : STD_LOGIC_VECTOR(2 downto 0);
    signal read_state : STD_LOGIC_VECTOR(1 downto 0);
    signal fifo_count : STD_LOGIC_VECTOR(9 downto 0);
    signal fifo_full : STD_LOGIC;
    signal fifo_empty : STD_LOGIC;
    signal bram1_addr : STD_LOGIC_VECTOR(10 downto 0);
    signal bram2_addr : STD_LOGIC_VECTOR(10 downto 0);
    
    -- Clock period
    constant clk_period : time := 10 ns;
    
begin
    -- Instanciação do DUT
    DUT: BRAM_FIFO_CONTROLLER
        port map (
            clk => clk,
            rst => rst,
            write_state => write_state,
            read_state => read_state,
            fifo_count => fifo_count,
            fifo_full => fifo_full,
            fifo_empty => fifo_empty,
            bram1_addr => bram1_addr,
            bram2_addr => bram2_addr,
            start => start,
            done => done
        );
    
    -- Geração do clock
    clk_process: process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;
    
    -- Processo de estimulação
    stim_process: process
    begin
        -- Reset inicial
        rst <= '1';
        start <= '0';
        wait for 100 ns;
        
        rst <= '0';
        wait for 50 ns;
        
        -- Inicia o processo
        start <= '1';
        wait for 20 ns;
        start <= '0';
        
        -- Aguarda o processamento completo
        wait until done = '1';
        wait for 100 ns;
        
        -- Teste adicional - reinicia o processo
        rst <= '1';
        wait for 50 ns;
        rst <= '0';
        wait for 50 ns;
        
        start <= '1';
        wait for 20 ns;
        start <= '0';
        
        wait until done = '1';
        wait for 200 ns;
        
        -- Finaliza a simulação
        assert false report "Simulação concluída com sucesso!" severity note;
        wait;
    end process;
    
    -- Monitoramento dos sinais
    monitor_process: process
    begin
        wait for 10 ns;
        
        loop
            wait for 100 ns;
            report "Tempo: " & time'image(now) & 
                   " | Write State: " & integer'image(to_integer(unsigned(write_state))) &
                   " | Read State: " & integer'image(to_integer(unsigned(read_state))) &
                   " | FIFO Count: " & integer'image(to_integer(unsigned(fifo_count))) &
                   " | FIFO Full: " & std_logic'image(fifo_full) &
                   " | FIFO Empty: " & std_logic'image(fifo_empty) &
                   " | BRAM1 Addr: " & integer'image(to_integer(unsigned(bram1_addr))) &
                   " | BRAM2 Addr: " & integer'image(to_integer(unsigned(bram2_addr))) &
                   " | Done: " & std_logic'image(done);
        end loop;
    end process;
    
end Behavioral;
