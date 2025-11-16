library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity User_HW is
  port(
    clk        : in  std_logic;
    reset_n    : in  std_logic;

    -- Avalon slave interface
    avs_address    : in  std_logic_vector(2 downto 0);  -- 0: data_in, 1: data_out, 2: control, 3: length
    avs_write      : in  std_logic;
    avs_read       : in  std_logic;
    avs_writedata  : in  std_logic_vector(31 downto 0);
    avs_readdata   : out std_logic_vector(31 downto 0);
    avs_chipselect : in  std_logic
  );
end entity;

architecture rtl of User_HW is

  -- Internal buffer for string processing (100 characters max)
  type string_buffer_t is array (0 to 99) of std_logic_vector(7 downto 0);
  signal input_buffer  : string_buffer_t := (others => (others => '0'));
  signal output_buffer : string_buffer_t := (others => (others => '0'));
  
  -- Control registers
  signal reg_length    : unsigned(7 downto 0) := (others => '0');
  signal reg_control   : std_logic_vector(31 downto 0) := (others => '0');
  signal processing    : std_logic := '0';
  signal done         : std_logic := '0';
  
  -- Index registers for read/write
  signal write_index   : unsigned(7 downto 0) := (others => '0');
  signal read_index    : unsigned(7 downto 0) := (others => '0');
  
  -- Processing state machine
  type state_t is (IDLE, PROCESSING, DONE_STATE);
  signal state : state_t := IDLE;
  signal process_index : unsigned(7 downto 0) := (others => '0');

begin

  -- Main processing process
  process(clk, reset_n)
    variable char_value : unsigned(7 downto 0);
  begin
    if reset_n = '0' then
      state <= IDLE;
      processing <= '0';
      done <= '0';
      process_index <= (others => '0');
      output_buffer <= (others => (others => '0'));
    elsif rising_edge(clk) then
      
      -- Avalon write access
      if avs_chipselect = '1' and avs_write = '1' then
        case avs_address is
          when "000" =>  -- Write data (character by character)
            if write_index < 100 then
              input_buffer(to_integer(write_index)) <= avs_writedata(7 downto 0);
              if write_index < 99 then
                write_index <= write_index + 1;
              end if;
            end if;
          when "001" =>  -- Write index for reading output
            read_index <= unsigned(avs_writedata(7 downto 0));
          when "010" =>  -- Control register
            reg_control <= avs_writedata;
            if avs_writedata(0) = '1' then  -- Start processing
              state <= PROCESSING;
              processing <= '1';
              done <= '0';
              process_index <= (others => '0');
              write_index <= (others => '0');  -- Reset write index
              read_index <= (others => '0');   -- Reset read index
            end if;
          when "011" =>  -- Length register
            reg_length <= unsigned(avs_writedata(7 downto 0));
            write_index <= (others => '0');  -- Reset write index when length is set
          when others =>
            null;
        end case;
      end if;
      
      -- Processing state machine
      case state is
        when IDLE =>
          processing <= '0';
          done <= '0';
          
        when PROCESSING =>
          if unsigned(process_index) < reg_length and unsigned(process_index) < 100 then
            -- Get character from input buffer
            char_value := unsigned(input_buffer(to_integer(process_index)));
            
            -- Process character: if 0xF7, set to 0, otherwise add 1
            if char_value = x"F7" then
              output_buffer(to_integer(process_index)) <= x"00";
            else
              output_buffer(to_integer(process_index)) <= std_logic_vector(char_value + 1);
            end if;
            
            process_index <= process_index + 1;
          else
            -- Processing complete
            state <= DONE_STATE;
            processing <= '0';
            done <= '1';
            process_index <= (others => '0');
          end if;
          
        when DONE_STATE =>
          -- Wait for control register to be cleared
          if reg_control(0) = '0' then
            state <= IDLE;
            done <= '0';
          end if;
      end case;
    end if;
  end process;

  -- Avalon read access
  process(clk, reset_n)
  begin
    if reset_n = '0' then
      avs_readdata <= (others => '0');
    elsif rising_edge(clk) then
      if avs_chipselect = '1' and avs_read = '1' then
        case avs_address is
          when "000" =>  -- Read input data (for verification)
            if to_integer(read_index) < 100 then
              avs_readdata <= (31 downto 8 => '0') & input_buffer(to_integer(read_index));
            else
              avs_readdata <= (others => '0');
            end if;
          when "001" =>  -- Read output data
            if to_integer(read_index) < 100 then
              avs_readdata <= (31 downto 8 => '0') & output_buffer(to_integer(read_index));
              if read_index < 99 then
                read_index <= read_index + 1;
              end if;
            else
              avs_readdata <= (others => '0');
            end if;
          when "010" =>  -- Read control/status
            avs_readdata <= (31 downto 2 => '0') & done & processing;
          when "011" =>  -- Read length
            avs_readdata <= (31 downto 8 => '0') & std_logic_vector(reg_length);
          when others =>
            avs_readdata <= (others => '0');
        end case;
      else
        avs_readdata <= (others => 'Z');
      end if;
    end if;
  end process;

end architecture;

