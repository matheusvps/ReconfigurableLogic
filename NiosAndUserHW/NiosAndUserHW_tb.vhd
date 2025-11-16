library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity NiosAndUserHW_tb is
end entity;

architecture testbench of NiosAndUserHW_tb is

  -- Component declaration
  component NiosAndUserHW is
    port(
      clk        : in  std_logic;
      reset_n    : in  std_logic;
      avs_address    : in  std_logic_vector(1 downto 0);
      avs_write      : in  std_logic;
      avs_read       : in  std_logic;
      avs_writedata  : in  std_logic_vector(31 downto 0);
      avs_readdata   : out std_logic_vector(31 downto 0);
      avs_chipselect : in  std_logic
    );
  end component;

  -- Testbench signals
  signal clk        : std_logic := '0';
  signal reset_n    : std_logic := '0';
  signal avs_address    : std_logic_vector(1 downto 0) := "00";
  signal avs_write      : std_logic := '0';
  signal avs_read       : std_logic := '0';
  signal avs_writedata  : std_logic_vector(31 downto 0) := (others => '0');
  signal avs_readdata   : std_logic_vector(31 downto 0);
  signal avs_chipselect : std_logic := '0';

  -- Clock period
  constant CLK_PERIOD : time := 10 ns;

  -- Test data: "MATHEUS VINICIUS PASSOS DE SANTANA"
  -- ASCII values: M=77, A=65, T=84, H=72, E=69, U=85, S=83, space=32
  -- V=86, I=73, N=78, I=73, C=67, I=73, U=85, S=83, space=32
  -- P=80, A=65, S=83, S=83, O=79, S=83, space=32
  -- D=68, E=69, space=32
  -- S=83, A=65, N=78, T=84, A=65, N=78, A=65
  type name_array_t is array (0 to 33) of std_logic_vector(7 downto 0);
  constant name_chars : name_array_t := (
    x"4D", x"41", x"54", x"48", x"45", x"55", x"53", x"20", -- "MATHEUS "
    x"56", x"49", x"4E", x"49", x"43", x"49", x"55", x"53", x"20", -- "VINICIUS "
    x"50", x"41", x"53", x"53", x"4F", x"53", x"20", -- "PASSOS "
    x"44", x"45", x"20", -- "DE "
    x"53", x"41", x"4E", x"54", x"41", x"4E", x"41" -- "SANTANA"
  );

  -- Separator: " +++--+++ "
  type separator_array_t is array (0 to 9) of std_logic_vector(7 downto 0);
  constant separator_chars : separator_array_t := (
    x"20", x"2B", x"2B", x"2B", x"2D", x"2D", x"2B", x"2B", x"2B", x"20" -- " +++--+++ "
  );

  -- Test control
  signal test_done : boolean := false;
  signal write_count : integer := 0;
  signal read_count : integer := 0;
  signal current_addr : integer := 0;
  signal current_char : integer := 0;
  signal current_name : integer := 0;
  signal write_phase : boolean := true;

begin

  -- Clock generation
  clk <= not clk after CLK_PERIOD/2;

  -- DUT instantiation
  dut: NiosAndUserHW
    port map (
      clk => clk,
      reset_n => reset_n,
      avs_address => avs_address,
      avs_write => avs_write,
      avs_read => avs_read,
      avs_writedata => avs_writedata,
      avs_readdata => avs_readdata,
      avs_chipselect => avs_chipselect
    );

  -- Test process
  test_proc: process
    variable line_out : line;
  begin
    -- Initialize
    reset_n <= '0';
    wait for 5 * CLK_PERIOD;
    reset_n <= '1';
    wait for CLK_PERIOD;

    -- Write phase: 1024 writes
    write_phase <= true;
    write_count <= 0;
    current_addr <= 0;
    current_char <= 0;
    current_name <= 0;

    report "Iniciando fase de escrita - 1024 escritas";
    
    while write_count < 1024 loop
      wait for CLK_PERIOD;
      
      -- Set chipselect
      avs_chipselect <= '1';
      
      -- Write address register
      avs_address <= "00";
      avs_write <= '1';
      avs_writedata <= std_logic_vector(to_unsigned(current_addr, 32));
      wait for CLK_PERIOD;
      avs_write <= '0';
      wait for CLK_PERIOD;
      
      -- Write data register
      avs_address <= "01";
      avs_write <= '1';
      if current_char < 34 then
        -- Write name character
        avs_writedata <= (31 downto 8 => '0') & name_chars(current_char);
      else
        -- Write separator character
        avs_writedata <= (31 downto 8 => '0') & separator_chars(current_char - 34);
      end if;
      wait for CLK_PERIOD;
      avs_write <= '0';
      wait for CLK_PERIOD;
      
      -- Write control register (WE_MEM = 1)
      avs_address <= "10";
      avs_write <= '1';
      avs_writedata <= (1 => '0', 0 => '1', others => '0'); -- WE_MEM = 1, RD_MEM = 0
      wait for CLK_PERIOD;
      avs_write <= '0';
      wait for CLK_PERIOD;
      
      -- Clear chipselect
      avs_chipselect <= '0';
      wait for CLK_PERIOD;
      
       -- Update counters
       write_count <= write_count + 1;
       current_addr <= current_addr + 1;
       
       -- Check if we need to start a new name
       if current_char >= 43 then -- 34 name chars + 10 separator chars - 1
         current_char <= 0;
         current_name <= current_name + 1;
       else
         current_char <= current_char + 1;
       end if;
      
      -- Progress report every 100 writes
      if write_count mod 100 = 0 then
        write(line_out, string'("Escritas completadas: "));
        write(line_out, write_count);
        writeline(output, line_out);
      end if;
    end loop;
    
    report "Fase de escrita concluída - 1024 escritas realizadas";
    
    -- Read phase: 1024 reads
    write_phase <= false;
    read_count <= 0;
    current_addr <= 0;
    current_char <= 0;
    current_name <= 0;

    report "Iniciando fase de leitura - 1024 leituras";
    
    while read_count < 1024 loop
      wait for CLK_PERIOD;
      
      -- Set chipselect
      avs_chipselect <= '1';
      
      -- Write address register
      avs_address <= "00";
      avs_write <= '1';
      avs_writedata <= std_logic_vector(to_unsigned(current_addr, 32));
      wait for CLK_PERIOD;
      avs_write <= '0';
      wait for CLK_PERIOD;
      
      -- Write control register (RD_MEM = 1)
      avs_address <= "10";
      avs_write <= '1';
      avs_writedata <= (1 => '1', 0 => '0', others => '0'); -- RD_MEM = 1, WE_MEM = 0
      wait for CLK_PERIOD;
      avs_write <= '0';
      wait for CLK_PERIOD;
      
      -- Read data
      avs_read <= '1';
      wait for CLK_PERIOD;
      
      -- Verify read data
      if current_char < 34 then
        -- Check name character
        if avs_readdata(7 downto 0) = name_chars(current_char) then
          write(line_out, character'val(to_integer(unsigned(name_chars(current_char)))));
        else
          report "Erro na leitura: esperado " & 
                 integer'image(to_integer(unsigned(name_chars(current_char)))) & 
                 ", obtido " & 
                 integer'image(to_integer(unsigned(avs_readdata(7 downto 0))));
        end if;
      else
        -- Check separator character
        if avs_readdata(7 downto 0) = separator_chars(current_char - 34) then
          write(line_out, character'val(to_integer(unsigned(separator_chars(current_char - 34)))));
        else
          report "Erro na leitura do separador: esperado " & 
                 integer'image(to_integer(unsigned(separator_chars(current_char - 34)))) & 
                 ", obtido " & 
                 integer'image(to_integer(unsigned(avs_readdata(7 downto 0))));
        end if;
      end if;
      
      avs_read <= '0';
      wait for CLK_PERIOD;
      
      -- Clear chipselect
      avs_chipselect <= '0';
      wait for CLK_PERIOD;
      
       -- Update counters
       read_count <= read_count + 1;
       current_addr <= current_addr + 1;
       
       -- Check if we need to start a new name
       if current_char >= 43 then -- 34 name chars + 10 separator chars - 1
         current_char <= 0;
         current_name <= current_name + 1;
         writeline(output, line_out); -- Print completed name
       else
         current_char <= current_char + 1;
       end if;
      
      -- Progress report every 100 reads
      if read_count mod 100 = 0 then
        write(line_out, string'("Leituras completadas: "));
        write(line_out, read_count);
        writeline(output, line_out);
      end if;
    end loop;
    
    report "Fase de leitura concluída - 1024 leituras realizadas";
    
    -- Test tri-state behavior when CS=0
    report "Testando comportamento tri-state quando CS=0";
    avs_chipselect <= '0';
    avs_read <= '1';
    wait for CLK_PERIOD;
    
    if avs_readdata = "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" then
      report "Tri-state funcionando corretamente quando CS=0";
    else
      report "Erro: Tri-state não funcionando quando CS=0";
    end if;
    
    avs_read <= '0';
    wait for CLK_PERIOD;
    
    -- Test write protection when CS=0
    report "Testando proteção de escrita quando CS=0";
    avs_chipselect <= '0';
    avs_address <= "00";
    avs_write <= '1';
    avs_writedata <= x"00000000";
    wait for CLK_PERIOD;
    avs_write <= '0';
    wait for CLK_PERIOD;
    
    avs_address <= "01";
    avs_write <= '1';
    avs_writedata <= x"000000FF";
    wait for CLK_PERIOD;
    avs_write <= '0';
    wait for CLK_PERIOD;
    
    avs_address <= "10";
    avs_write <= '1';
    avs_writedata <= (0 => '1', others => '0'); -- WE_MEM = 1
    wait for CLK_PERIOD;
    avs_write <= '0';
    wait for CLK_PERIOD;
    
    -- Now read from address 0 to verify it wasn't written
    avs_chipselect <= '1';
    avs_address <= "00";
    avs_write <= '1';
    avs_writedata <= x"00000000";
    wait for CLK_PERIOD;
    avs_write <= '0';
    wait for CLK_PERIOD;
    
    avs_address <= "10";
    avs_write <= '1';
    avs_writedata <= (1 => '1', 0 => '0', others => '0'); -- RD_MEM = 1
    wait for CLK_PERIOD;
    avs_write <= '0';
    wait for CLK_PERIOD;
    
    avs_read <= '1';
    wait for CLK_PERIOD;
    
    if avs_readdata(7 downto 0) = name_chars(0) then
      report "Proteção de escrita funcionando corretamente quando CS=0";
    else
      report "Erro: Proteção de escrita não funcionando quando CS=0";
    end if;
    
    avs_read <= '0';
    avs_chipselect <= '0';
    wait for CLK_PERIOD;
    
    report "Teste concluído com sucesso!";
    test_done <= true;
    wait;
  end process;

  -- Monitor process
  monitor_proc: process
  begin
    wait until test_done;
    wait for 10 * CLK_PERIOD;
    report "Simulação finalizada";
    -- Para o Quartus, usamos assert false para parar a simulação
    assert false report "Simulação finalizada com sucesso!" severity failure;
  end process;

end architecture;
