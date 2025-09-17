library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Cronometro is
    port(
        CLK           : in  std_logic;
        RST           : in  std_logic;
        START_STOP_BTN: in  std_logic;
        CLR_BTN       : in  std_logic;
        
        -- Saídas para os 4 displays
        HEX0_A, HEX0_B, HEX0_C, HEX0_D, HEX0_E, HEX0_F, HEX0_G : out std_logic;
        HEX1_A, HEX1_B, HEX1_C, HEX1_D, HEX1_E, HEX1_F, HEX1_G : out std_logic;
        HEX2_A, HEX2_B, HEX2_C, HEX2_D, HEX2_E, HEX2_F, HEX2_G : out std_logic;
        HEX3_A, HEX3_B, HEX3_C, HEX3_D, HEX3_E, HEX3_F, HEX3_G : out std_logic
    );
end entity;

architecture rtl of Cronometro is

    -- Sinais internos
    signal clk_en_cent, clk_en_sec : std_logic;
    signal state_s   : std_logic_vector(1 downto 0) := "00";
    signal q_cent_s  : std_logic_vector(7 downto 0) := (others => '0');
    signal q_sec_s   : std_logic_vector(7 downto 0) := (others => '0');
    signal clr_s     : std_logic;

    -- Componentes
    component DIVISOR is
        port( CLK: in std_logic;
              RST: in std_logic;
              DIV50: out std_logic );
    end component;

    component Counter99 is
        port( RST, CLK, EN, CLR, LD: in std_logic;
              LOAD: in std_logic_vector(7 downto 0);
              Q: out std_logic_vector(7 downto 0) );
    end component;

    component Counter59 is
        port( RST, CLK, EN, CLR, LD: in std_logic;
              LOAD: in std_logic_vector(7 downto 0);
              Q: out std_logic_vector(7 downto 0) );
    end component;

    component CronometerController is
        port( btn_clear, btn_pause, btn_reset: in std_logic;
              current_state: out std_logic_vector(1 downto 0) );
    end component;

    component BCD4Bits is
        port( NumIn: in unsigned(3 downto 0);
              outA, outB, outC, outD, outE, outF, outG: out std_logic );
    end component;

begin
    -- Divisor de clock
    Udiv : DIVISOR
        port map(
            CLK => CLK,
            RST => RST,
            DIV50 => clk_en_cent
        );

    -- Contador de centésimos (00–99)
    Ucent : Counter99
        port map(
            RST  => RST,
            CLK  => CLK,
            EN   => clk_en_cent when state_s = "01" else '0',
            CLR  => clr_s,
            LD   => '0',
            LOAD => (others => '0'),
            Q    => q_cent_s
        );

    -- Contador de segundos (00–59)
    Usec : Counter59
        port map(
            RST  => RST,
            CLK  => CLK,
            EN   => clk_en_sec,
            CLR  => clr_s,
            LD   => '0',
            LOAD => (others => '0'),
            Q    => q_sec_s
        );

    -- Controlador de estados
    Uctrl : CronometerController
        port map(
            btn_clear => CLR_BTN,
            btn_pause => START_STOP_BTN,
            btn_reset => RST,
            current_state => state_s
        );

    -- Clear global
    clr_s <= '1' when state_s = "00" else '0';

    -- Enable de segundos: quando centésimos == 99 e clock ativo
    clk_en_sec <= '1' when q_cent_s = "01100011" and clk_en_cent = '1' and state_s = "01" else '0';

    -- Decodificação para displays 7 segmentos
    -- Segundos unidade
    HEX0: BCD4Bits
        port map(
            NumIn => unsigned(q_sec_s(3 downto 0)),
            outA => HEX0_A, outB => HEX0_B, outC => HEX0_C,
            outD => HEX0_D, outE => HEX0_E, outF => HEX0_F, outG => HEX0_G
        );

    -- Segundos dezena
    HEX1: BCD4Bits
        port map(
            NumIn => unsigned(q_sec_s(7 downto 4)),
            outA => HEX1_A, outB => HEX1_B, outC => HEX1_C,
            outD => HEX1_D, outE => HEX1_E, outF => HEX1_F, outG => HEX1_G
        );

    -- Centésimos unidade
    HEX2: BCD4Bits
        port map(
            NumIn => unsigned(q_cent_s(3 downto 0)),
            outA => HEX2_A, outB => HEX2_B, outC => HEX2_C,
            outD => HEX2_D, outE => HEX2_E, outF => HEX2_F, outG => HEX2_G
        );

    -- Centésimos dezena
    HEX3: BCD4Bits
        port map(
            NumIn => unsigned(q_cent_s(7 downto 4)),
            outA => HEX3_A, outB => HEX3_B, outC => HEX3_C,
            outD => HEX3_D, outE => HEX3_E, outF => HEX3_F, outG => HEX3_G
        );

end architecture;
