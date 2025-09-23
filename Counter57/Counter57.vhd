library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Counter57 is
    port(
        rst_i   : in  std_logic;
        clk_i   : in  std_logic;
        q_o     : out std_logic_vector(7 downto 0);
        en_i    : in  std_logic;
        clr_i   : in  std_logic;
        ld_i    : in  std_logic;
        load_i  : in  std_logic_vector(7 downto 0)
    );
end entity;
  
architecture arch of Counter57 is
    component Counter4WithLoad is
        port(
            RST   : in  std_logic;
            CLK   : in  std_logic;
            EN    : in  std_logic;
            CLR   : in  std_logic;
            LD    : in  std_logic;
            LOAD  : in  std_logic_vector(3 downto 0);
            Q     : out std_logic_vector(3 downto 0)
        );
    end component;  
    
    signal cont_s    : std_logic_vector(7 downto 0);
    signal cont1_s   : std_logic_vector(3 downto 0);
    signal cont2_s   : std_logic_vector(3 downto 0);
    signal load_s    : std_logic_vector(7 downto 0);
    signal ld_s      : std_logic;
    signal en_c2_s   : std_logic;

    constant ld_cte_c : std_logic_vector(7 downto 0) := "00001100";

begin
    C1: Counter4WithLoad
        port map (
            RST   => rst_i,
            CLK   => clk_i,
            Q     => cont1_s,
            EN    => en_i,
            CLR   => clr_i,
            LD    => ld_s,
            LOAD  => load_s(3 downto 0)
        );

    C2: Counter4WithLoad
        port map (
            RST   => rst_i,
            CLK   => clk_i,
            Q     => cont2_s,
            EN    => en_c2_s,
            CLR   => clr_i,
            LD    => ld_s,
            LOAD  => load_s(7 downto 4)
        );

    cont_s <= cont2_s & cont1_s;

    q_o <= cont_s when ((unsigned(cont_s) > 11) and (unsigned(cont_s) < 69))
           else ld_cte_c;

    en_c2_s <= '1' when (cont1_s = "1111" and en_i = '1')
                     or (ld_s = '1')       
               else '0';
    
    ld_s <= '1' when (unsigned(cont_s) < 12)
                 or (unsigned(cont_s) >= 68)
                 or clr_i = '1'
                 or rst_i = '1' 
            else ld_i;  
    
    load_s <= ld_cte_c when ld_i = '0'        
              else load_i;
end architecture;
