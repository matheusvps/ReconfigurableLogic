-- ===================================================================================
-- READ_FSM.vhd
-- Máquina de estados para controle de leitura da FIFO para segunda BRAM
-- ===================================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity READ_FSM is
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
end READ_FSM;

architecture Behavioral of READ_FSM is
    type state_type is (RESET, RD_FIFO, RD_WAIT);
    signal current_state, next_state : state_type;
    
    signal addr_counter : unsigned(10 downto 0) := (others => '0');
    signal data_counter : unsigned(7 downto 0) := (others => '0');
    
    -- Sinais de controle
    signal bram_we_sig : STD_LOGIC := '0';
    signal fifo_rd_en_sig : STD_LOGIC := '0';
    
begin
    -- Processo de sincronização
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                current_state <= RESET;
                addr_counter <= (others => '0');
                data_counter <= (others => '0');
            else
                current_state <= next_state;
                
                case current_state is
                    when RESET =>
                        addr_counter <= (others => '0');
                        data_counter <= (others => '0');
                        
                    when RD_FIFO =>
                        if fifo_rd_en_sig = '1' and fifo_empty = '0' then
                            -- Incrementa contador de endereço da BRAM
                            if addr_counter < 2047 then
                                addr_counter <= addr_counter + 1;
                            else
                                addr_counter <= (others => '0');  -- Reinicia
                            end if;
                            data_counter <= data_counter + 1;
                        end if;
                        
                    when RD_WAIT =>
                        -- Aguarda dados na FIFO
                        null;
                        
                end case;
            end if;
        end if;
    end process;
    
    -- Lógica de próximo estado
    process(current_state, fifo_empty, fifo_count)
    begin
        next_state <= current_state;
        
        case current_state is
            when RESET =>
                next_state <= RD_FIFO;
                
            when RD_FIFO =>
                if fifo_empty = '1' or unsigned(fifo_count) = 0 then
                    next_state <= RD_WAIT;
                end if;
                
            when RD_WAIT =>
                if fifo_empty = '0' and unsigned(fifo_count) /= 0 then
                    next_state <= RD_FIFO;
                end if;
                
        end case;
    end process;
    
    -- Lógica de saída
    process(current_state, fifo_empty, fifo_count)
    begin
        bram_we_sig <= '0';
        fifo_rd_en_sig <= '0';
        
        case current_state is
            when RESET =>
                bram_we_sig <= '0';
                fifo_rd_en_sig <= '0';
                
            when RD_FIFO =>
                if fifo_empty = '0' and unsigned(fifo_count) /= 0 then
                    fifo_rd_en_sig <= '1';
                    bram_we_sig <= '1';
                else
                    fifo_rd_en_sig <= '0';
                    bram_we_sig <= '0';
                end if;
                
            when RD_WAIT =>
                bram_we_sig <= '0';
                fifo_rd_en_sig <= '0';
                
        end case;
    end process;
    
    -- Saídas
    bram_addr <= STD_LOGIC_VECTOR(addr_counter);
    bram_data <= fifo_data;  -- Dados vêm da FIFO
    bram_we <= bram_we_sig;
    fifo_rd_en <= fifo_rd_en_sig;
    
    -- Saída do estado atual para debug
    with current_state select
        state_out <= "00" when RESET,
                     "01" when RD_FIFO,
                     "10" when RD_WAIT;
    
end Behavioral;
