-- ===================================================================================
-- BRAM_FIFO_CONTROLLER.vhd
-- Entidade principal que integra BRAM, FIFO e máquinas de estado
-- ===================================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity BRAM_FIFO_CONTROLLER is
    Port (
        clk         : in  STD_LOGIC;
        rst         : in  STD_LOGIC;
        -- Sinais de debug/monitoramento
        write_state : out STD_LOGIC_VECTOR(2 downto 0);
        read_state  : out STD_LOGIC_VECTOR(1 downto 0);
        fifo_count  : out STD_LOGIC_VECTOR(9 downto 0);
        fifo_full   : out STD_LOGIC;
        fifo_empty  : out STD_LOGIC;
        bram1_addr  : out STD_LOGIC_VECTOR(10 downto 0);
        bram2_addr  : out STD_LOGIC_VECTOR(10 downto 0);
        -- Sinais de controle
        start       : in  STD_LOGIC;
        done        : out STD_LOGIC
    );
end BRAM_FIFO_CONTROLLER;

architecture Behavioral of BRAM_FIFO_CONTROLLER is
    -- Componentes
    component BRAM_2048x8
        Port (
            clk     : in  STD_LOGIC;
            rst     : in  STD_LOGIC;
            we      : in  STD_LOGIC;
            addr    : in  STD_LOGIC_VECTOR(10 downto 0);
            din     : in  STD_LOGIC_VECTOR(7 downto 0);
            dout    : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;
    
    component FIFO_1024x8
        Port (
            clk         : in  STD_LOGIC;
            rst         : in  STD_LOGIC;
            wr_en       : in  STD_LOGIC;
            rd_en       : in  STD_LOGIC;
            din         : in  STD_LOGIC_VECTOR(7 downto 0);
            dout        : out STD_LOGIC_VECTOR(7 downto 0);
            full        : out STD_LOGIC;
            empty       : out STD_LOGIC;
            data_count  : out STD_LOGIC_VECTOR(9 downto 0)
        );
    end component;
    
    component BRAM_2048x8_READ
        Port (
            clk     : in  STD_LOGIC;
            rst     : in  STD_LOGIC;
            we      : in  STD_LOGIC;
            addr    : in  STD_LOGIC_VECTOR(10 downto 0);
            din     : in  STD_LOGIC_VECTOR(7 downto 0);
            dout    : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;
    
    component WRITE_FSM
        Port (
            clk         : in  STD_LOGIC;
            rst         : in  STD_LOGIC;
            fifo_full   : in  STD_LOGIC;
            fifo_count  : in  STD_LOGIC_VECTOR(9 downto 0);
            bram_addr   : out STD_LOGIC_VECTOR(10 downto 0);
            bram_data   : out STD_LOGIC_VECTOR(7 downto 0);
            bram_we     : out STD_LOGIC;
            fifo_wr_en  : out STD_LOGIC;
            load_complete: out STD_LOGIC;
            state_out   : out STD_LOGIC_VECTOR(2 downto 0)
        );
    end component;
    
    component READ_FSM
        Port (
            clk         : in  STD_LOGIC;
            rst         : in  STD_LOGIC;
            fifo_empty  : in  STD_LOGIC;
            fifo_count  : in  STD_LOGIC_VECTOR(9 downto 0);
            bram_addr   : out STD_LOGIC_VECTOR(10 downto 0);
            bram_data   : out STD_LOGIC_VECTOR(7 downto 0);
            bram_we     : out STD_LOGIC;
            fifo_rd_en  : out STD_LOGIC;
            fifo_data   : in  STD_LOGIC_VECTOR(7 downto 0);
            state_out   : out STD_LOGIC_VECTOR(1 downto 0)
        );
    end component;
    
    -- Sinais internos
    signal bram1_we, bram1_we_sig : STD_LOGIC;
    signal bram1_addr, bram1_addr_sig : STD_LOGIC_VECTOR(10 downto 0);
    signal bram1_data, bram1_data_sig : STD_LOGIC_VECTOR(7 downto 0);
    signal bram1_dout : STD_LOGIC_VECTOR(7 downto 0);
    
    signal bram2_we, bram2_we_sig : STD_LOGIC;
    signal bram2_addr, bram2_addr_sig : STD_LOGIC_VECTOR(10 downto 0);
    signal bram2_data, bram2_data_sig : STD_LOGIC_VECTOR(7 downto 0);
    signal bram2_dout : STD_LOGIC_VECTOR(7 downto 0);
    
    signal fifo_wr_en, fifo_rd_en : STD_LOGIC;
    signal fifo_din, fifo_dout : STD_LOGIC_VECTOR(7 downto 0);
    signal fifo_full_sig, fifo_empty_sig : STD_LOGIC;
    signal fifo_count_sig : STD_LOGIC_VECTOR(9 downto 0);
    
    signal write_state_sig : STD_LOGIC_VECTOR(2 downto 0);
    signal read_state_sig : STD_LOGIC_VECTOR(1 downto 0);
    signal load_complete : STD_LOGIC;
    
    -- Controle de velocidade (WR_speed / RD_speed = 7)
    signal clk_div_counter : unsigned(2 downto 0) := (others => '0');
    signal clk_7x : STD_LOGIC := '0';
    
begin
    -- Divisor de clock para simular velocidade 7x maior na escrita
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                clk_div_counter <= (others => '0');
                clk_7x <= '0';
            else
                clk_div_counter <= clk_div_counter + 1;
                if clk_div_counter = 6 then  -- 7x mais rápido
                    clk_7x <= not clk_7x;
                    clk_div_counter <= (others => '0');
                end if;
            end if;
        end if;
    end process;
    
    -- Instanciação dos componentes
    BRAM1: BRAM_2048x8
        port map (
            clk => clk,
            rst => rst,
            we => bram1_we,
            addr => bram1_addr,
            din => bram1_data,
            dout => bram1_dout
        );
    
    FIFO: FIFO_1024x8
        port map (
            clk => clk,
            rst => rst,
            wr_en => fifo_wr_en,
            rd_en => fifo_rd_en,
            din => fifo_din,
            dout => fifo_dout,
            full => fifo_full_sig,
            empty => fifo_empty_sig,
            data_count => fifo_count_sig
        );
    
    BRAM2: BRAM_2048x8_READ
        port map (
            clk => clk,
            rst => rst,
            we => bram2_we,
            addr => bram2_addr,
            din => bram2_data,
            dout => bram2_dout
        );
    
    WRITE_CTRL: WRITE_FSM
        port map (
            clk => clk_7x,  -- Clock 7x mais rápido
            rst => rst,
            fifo_full => fifo_full_sig,
            fifo_count => fifo_count_sig,
            bram_addr => bram1_addr_sig,
            bram_data => bram1_data_sig,
            bram_we => bram1_we_sig,
            fifo_wr_en => fifo_wr_en,
            load_complete => load_complete,
            state_out => write_state_sig
        );
    
    READ_CTRL: READ_FSM
        port map (
            clk => clk,  -- Clock normal
            rst => rst,
            fifo_empty => fifo_empty_sig,
            fifo_count => fifo_count_sig,
            bram_addr => bram2_addr_sig,
            bram_data => bram2_data_sig,
            bram_we => bram2_we_sig,
            fifo_rd_en => fifo_rd_en,
            fifo_data => fifo_dout,
            state_out => read_state_sig
        );
    
    -- Conexões dos sinais
    bram1_we <= bram1_we_sig;
    bram1_addr <= bram1_addr_sig;
    bram1_data <= bram1_data_sig;
    
    bram2_we <= bram2_we_sig;
    bram2_addr <= bram2_addr_sig;
    bram2_data <= bram2_data_sig;
    
    -- Dados da FIFO vêm da primeira BRAM
    fifo_din <= bram1_dout;
    
    -- Saídas de debug
    write_state <= write_state_sig;
    read_state <= read_state_sig;
    fifo_count <= fifo_count_sig;
    fifo_full <= fifo_full_sig;
    fifo_empty <= fifo_empty_sig;
    bram1_addr <= bram1_addr_sig;
    bram2_addr <= bram2_addr_sig;
    
    -- Sinal de done (quando ambas as BRAMs foram processadas)
    done <= '1' when load_complete = '1' and fifo_empty_sig = '1' else '0';
    
end Behavioral;
