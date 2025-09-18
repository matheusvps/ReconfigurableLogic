library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;



entity Cronometer is
	port(
		clock      : in std_logic;
		Start_Stop : in std_logic;
		Reset      : in std_logic;
		
		HEX0_A, HEX0_B, HEX0_C, HEX0_D, HEX0_E, HEX0_F, HEX0_G : out std_logic;
      HEX1_A, HEX1_B, HEX1_C, HEX1_D, HEX1_E, HEX1_F, HEX1_G : out std_logic;
      HEX2_A, HEX2_B, HEX2_C, HEX2_D, HEX2_E, HEX2_F, HEX2_G : out std_logic;
      HEX3_A, HEX3_B, HEX3_C, HEX3_D, HEX3_E, HEX3_F, HEX3_G : out std_logic
    );
end entity;


architecture A_Cronometer of Cronometer is

	-- Signal Definitions
	signal StartStop_s, Reset_s : std_logic := '1';
	signal GND, ControllerState_s, globalReset_s, secondsEnable_s, clkDiv  : std_logic := '0';
	signal GND8Bits, counter99Out_s, counter59Out_s : std_logic_vector(7 downto 0) := "00000000";
	
	
	component Divisor is 
	port(
		CLK: in std_logic;
		RST: in std_logic;
		DIV50: out std_logic
		);
	end component;
		 
	component Counter99 is
	port(
		RST  			 : in  std_logic;
      CLK  			 : in  std_logic;
      EN   			 : in  std_logic;
      CLR  			 : in  std_logic;
      LD   			 : in  std_logic;
      LOAD  			 : in  std_logic_vector(7 downto 0);
      Q     			 : out std_logic_vector(7 downto 0);
		SecondsEnable : out std_logic
    );
	 end component;
	 
	 component Counter59 is
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
	 
	 component BCD4Bits is
	 port(
		NumIn  : in unsigned(3 downto 0);
	
		outA   : out std_logic;
		outB   : out std_logic;
		outC   : out std_logic;
		outD   : out std_logic;
		outE   : out std_logic;
		outF   : out std_logic;
		outG   : out std_logic
	 );
	 end component;
	 
	 component CronometerController is
	 port (
		btn_pause        : in  std_logic;
		btn_reset        : in  std_logic;
      current_state    : out std_logic;
		cronometer_reset : out std_logic
    );
	 end component;
	 
	 component ButtonFilter is
	 port(
		clk        : in std_logic;
		button_in  : in std_logic;
		button_out : out std_logic
	 );
	 end component;

	begin 
		
		StartStopFilter : ButtonFilter
		port map(
			clk => clkDiv,
			button_in => start_Stop,
			button_out => startStop_s
		);
		
		ResetFilter : ButtonFilter
		port map(
			clk => clkDiv,
			button_in => Reset,
			button_out => Reset_s
		);
		
		
		Uctrl : CronometerController
		port map(
			btn_pause => startStop_s,
			btn_reset => reset_s,
			current_state => controllerState_s,
			cronometer_reset => globalReset_s
		);
		
	
		Ucent : Counter99
		port map(
			RST => globalReset_s,
			CLK => clkDiv,
			EN  => controllerState_s,
			CLR => GND,
			LD  => GND,
			LOAD => GND8Bits,
			Q    => counter99Out_s,
			SecondsEnable => secondsEnable_s
		);
		
		Usec : Counter59
      port map(
			RST  => globalReset_s,
         CLK  => clkDiv,
         EN   => secondsEnable_s,
         CLR  => GND,
         LD   => GND,
         LOAD => GND8Bits,
         Q    => Counter59Out_s
        );
		

		Udiv : Divisor
		port map(
			CLK => clock,
			RST => globalReset_s,
			DIV50 => clkDiv
		);
		
		HEX0 : BCD4Bits
		port map(
			NumIn => unsigned(counter99Out_s(3 downto 0)),
         outA => HEX0_A, 
			outB => HEX0_B, 
			outC => HEX0_C,
         outD => HEX0_D, 
			outE => HEX0_E, 
			outF => HEX0_F, 
			outG => HEX0_G
		);
		
		HEX1 : BCD4Bits
		port map(
			NumIn => unsigned(counter99Out_s(7 downto 4)),
         outA => HEX1_A, 
			outB => HEX1_B, 
			outC => HEX1_C,
         outD => HEX1_D, 
			outE => HEX1_E, 
			outF => HEX1_F, 
			outG => HEX1_G
		);
		
		HEX2 : BCD4Bits
		port map(
			NumIn => unsigned(counter59Out_s(3 downto 0)),
         outA => HEX2_A, 
			outB => HEX2_B, 
			outC => HEX2_C,
         outD => HEX2_D, 
			outE => HEX2_E, 
			outF => HEX2_F, 
			outG => HEX2_G
		);
		
		HEX3 : BCD4Bits
		port map(
			NumIn => unsigned(counter59Out_s(7 downto 4)),
         outA => HEX3_A, 
			outB => HEX3_B, 
			outC => HEX3_C,
         outD => HEX3_D, 
			outE => HEX3_E, 
			outF => HEX3_F, 
			outG => HEX3_G
		);
		
	
End architecture;
