-- ===================================================================================
-- WRITE_FSM.vhd
-- Máquina de estados para controle de escrita da BRAM para FIFO
-- ===================================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity WRITE_FSM is
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
end WRITE_FSM;

architecture Behavioral of WRITE_FSM is
    type state_type is (RESET, LOAD_BRAM, WR_FIFO, WR_WAIT);
    signal current_state, next_state : state_type;
    
    signal addr_counter : unsigned(10 downto 0) := (others => '0');
    signal data_counter : unsigned(7 downto 0) := (others => '0');
    signal load_done : STD_LOGIC := '0';
    
    -- Sinais de controle
    signal bram_we_sig : STD_LOGIC := '0';
    signal fifo_wr_en_sig : STD_LOGIC := '0';
    
    -- Constantes para controle de fluxo
    constant FIFO_75_PERCENT : integer := 768;  -- 75% de 1024
    constant FIFO_50_PERCENT : integer := 512;  -- 50% de 1024
    
begin
    -- Processo de sincronização
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                current_state <= RESET;
                addr_counter <= (others => '0');
                data_counter <= (others => '0');
                load_done <= '0';
            else
                current_state <= next_state;
                
                case current_state is
                    when RESET =>
                        addr_counter <= (others => '0');
                        data_counter <= (others => '0');
                        load_done <= '0';
                        
                    when LOAD_BRAM =>
                        if addr_counter < 2047 then
                            addr_counter <= addr_counter + 1;
                            data_counter <= data_counter + 1;
                        else
                            load_done <= '1';
                        end if;
                        
                    when WR_FIFO =>
                        if fifo_wr_en_sig = '1' and addr_counter < 2047 then
                            addr_counter <= addr_counter + 1;
                            data_counter <= data_counter + 1;
                        end if;
                        
                    when WR_WAIT =>
                        -- Aguarda FIFO ter espaço
                        null;
                        
                end case;
            end if;
        end if;
    end process;
    
    -- Lógica de próximo estado
    process(current_state, load_done, fifo_full, fifo_count, addr_counter)
    begin
        next_state <= current_state;
        
        case current_state is
            when RESET =>
                next_state <= LOAD_BRAM;
                
            when LOAD_BRAM =>
                if load_done = '1' then
                    next_state <= WR_FIFO;
                end if;
                
            when WR_FIFO =>
                if fifo_full = '0' and addr_counter < 2047 then
                    next_state <= WR_FIFO;
                elsif fifo_full = '1' or unsigned(fifo_count) >= FIFO_75_PERCENT then
                    next_state <= WR_WAIT;
                elsif addr_counter >= 2047 then
                    next_state <= RESET;  -- Reinicia o processo
                end if;
                
            when WR_WAIT =>
                if unsigned(fifo_count) <= FIFO_50_PERCENT then
                    next_state <= WR_FIFO;
                end if;
                
        end case;
    end process;
    
    -- Lógica de saída
    process(current_state, fifo_full, fifo_count, addr_counter, data_counter)
    begin
        bram_we_sig <= '0';
        fifo_wr_en_sig <= '0';
        load_complete <= '0';
        
        case current_state is
            when RESET =>
                bram_we_sig <= '0';
                fifo_wr_en_sig <= '0';
                load_complete <= '0';
                
            when LOAD_BRAM =>
                bram_we_sig <= '1';
                fifo_wr_en_sig <= '0';
                load_complete <= '0';
                
            when WR_FIFO =>
                bram_we_sig <= '0';
                if fifo_full = '0' and addr_counter < 2047 then
                    fifo_wr_en_sig <= '1';
                end if;
                load_complete <= '1';
                
            when WR_WAIT =>
                bram_we_sig <= '0';
                fifo_wr_en_sig <= '0';
                load_complete <= '1';
                
        end case;
    end process;
    
    -- Saídas
    bram_addr <= STD_LOGIC_VECTOR(addr_counter);
    bram_data <= STD_LOGIC_VECTOR(data_counter);
    bram_we <= bram_we_sig;
    fifo_wr_en <= fifo_wr_en_sig;
    
    -- Saída do estado atual para debug
    with current_state select
        state_out <= "000" when RESET,
                     "001" when LOAD_BRAM,
                     "010" when WR_FIFO,
                     "011" when WR_WAIT;
    
end Behavioral;
