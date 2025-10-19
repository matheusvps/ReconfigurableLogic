-- ===================================================================================
-- FIFO_1024x8.vhd
-- Entidade para FIFO de 1024 palavras de 8 bits
-- ===================================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity FIFO_1024x8 is
    Port (
        clk     : in  STD_LOGIC;
        rst     : in  STD_LOGIC;
        wr_en   : in  STD_LOGIC;
        rd_en   : in  STD_LOGIC;
        din     : in  STD_LOGIC_VECTOR(7 downto 0);
        dout    : out STD_LOGIC_VECTOR(7 downto 0);
        full    : out STD_LOGIC;
        empty   : out STD_LOGIC;
        data_count : out STD_LOGIC_VECTOR(9 downto 0)  -- 2^10 = 1024 posições
    );
end FIFO_1024x8;

architecture Behavioral of FIFO_1024x8 is
    type fifo_type is array (0 to 1023) of STD_LOGIC_VECTOR(7 downto 0);
    signal fifo_mem : fifo_type := (others => (others => '0'));
    
    signal wr_ptr : unsigned(9 downto 0) := (others => '0');
    signal rd_ptr : unsigned(9 downto 0) := (others => '0');
    signal count  : unsigned(9 downto 0) := (others => '0');
    
    signal full_sig  : STD_LOGIC := '0';
    signal empty_sig : STD_LOGIC := '1';
    
begin
    -- Sinais de controle
    full_sig <= '1' when count = 1024 else '0';
    empty_sig <= '1' when count = 0 else '0';
    
    full <= full_sig;
    empty <= empty_sig;
    data_count <= STD_LOGIC_VECTOR(count);
    
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                wr_ptr <= (others => '0');
                rd_ptr <= (others => '0');
                count <= (others => '0');
                fifo_mem <= (others => (others => '0'));
            else
                -- Escrita
                if wr_en = '1' and full_sig = '0' then
                    fifo_mem(to_integer(wr_ptr)) <= din;
                    wr_ptr <= wr_ptr + 1;
                    count <= count + 1;
                end if;
                
                -- Leitura
                if rd_en = '1' and empty_sig = '0' then
                    rd_ptr <= rd_ptr + 1;
                    count <= count - 1;
                end if;
            end if;
        end if;
    end process;
    
    -- Saída de dados (combinacional)
    dout <= fifo_mem(to_integer(rd_ptr));
    
end Behavioral;
