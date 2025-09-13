library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Counter59 is
    port(
        RST   : in  std_logic;
        CLK   : in  std_logic;
        EN    : in  std_logic;
        CLR   : in  std_logic;
        LD    : in  std_logic;
        LOAD  : in  std_logic_vector(7 downto 0);
        Q     : out std_logic_vector(7 downto 0)
    );
end entity;

architecture rtl of Counter59 is

    component Counter4WithLoad is
        port(
            RST  : in  std_logic;
            CLK  : in  std_logic;
            EN   : in  std_logic;
            CLR  : in  std_logic;
            LD   : in  std_logic;
            LOAD : in  std_logic_vector(3 downto 0);
            Q    : out std_logic_vector(3 downto 0)
        );
    end component;

    -- sinais internos
    signal units_cnt   : std_logic_vector(3 downto 0);
    signal tens_cnt    : std_logic_vector(3 downto 0);
    signal full_count  : std_logic_vector(7 downto 0);
    signal load_buf    : std_logic_vector(7 downto 0);
    signal clr_int     : std_logic;
    signal en_tens     : std_logic;

begin

    -- Contador das unidades (0–9)
    units_counter : Counter4WithLoad
        port map(
            RST  => RST,
            CLK  => CLK,
            EN   => EN,
            CLR  => clr_int,
            LD   => LD,
            LOAD => load_buf(3 downto 0),
            Q    => units_cnt
        );

    -- Contador das dezenas (0–5)
    tens_counter : Counter4WithLoad
        port map(
            RST  => RST,
            CLK  => CLK,
            EN   => en_tens,
            CLR  => clr_int,
            LD   => LD,
            LOAD => load_buf(7 downto 4),
            Q    => tens_cnt
        );

    -- concatenação para gerar saída final
    full_count <= tens_cnt & units_cnt;
    Q <= full_count;

    -- enable do contador das dezenas (vai-um)
    en_tens <= '1' when (units_cnt = "1111" and EN = '1') else '0';

    -- clear interno (zera quando >= 59 ou CLR externo ativo)
    clr_int <= '1' when (unsigned(full_count) > 59) or (CLR = '1') else '0';

    -- buffer de LOAD
    load_buf <= LOAD;

end architecture;
