library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RAM is
  generic (
    A  : integer := 5;
    N  : integer := 8
  );
  port(
    RAMin          : in std_logic_vector(A-1 downto 0);   --address of the instruction
    clk,rd,wr      : in std_logic;  
    RAMout_in      : in std_logic_vector(N-1 downto 0);   --input from the data bus  
    RAMout_out      : out std_logic_vector(N-1 downto 0)  --output to the data bus
  );
end entity RAM;

architecture behave of RAM is
  type temp_memory is array (0 to (2**A)-1) of std_logic_vector(N-1 downto 0);
  signal mem  : temp_memory  :=(
    0	=> "11000110",
    1	=> "01011111",
    2	=> "11001111",
    3	=> "00011111",
    4	=> "01001100",
    5	=> "11100000",
    6	=> "00000000",
    7	=> "00000000",
    8	=> "00000000",
    9	=> "00000000",
    10	=> "00000000",
    11	=> "00000000",
    12	=> "00000000",
    13	=> "00000000",
    14	=> "00000000",
    15 => "00000000",
    16	=> "00000000",
    17	=> "00000000",
    18 => "00000000",
    19	=> "00000000",
    20	=> "00000000",
    21	=> "00000000",
    22	=> "00000000",
    23	=> "00000000",
    24	=> "00000000",
    25	=> "00000000",
    26	=> "00000000",
    27	=> "00000000",
    28	=> "00000000",
    29	=> "00000000",
    30	=> "00000000",
    31 => "00000000"  --instructions to be executed are stored in the memory
);
begin 

process(clk)
begin
  if(rising_edge(clk)) then
    
    if(rd='1') then
      RAMout_out <= mem(to_integer(unsigned(RAMin)));   --read the data from the input address and output to data bus
    
    elsif(wr='1') then
      mem(to_integer(unsigned(RAMin))) <= RAMout_in;    --read the data from the output and write to the ram memory at desired
                                                        --address           
    
    else
      RAMout_out <= (others => 'Z');                    --when data is not read and written then keep the output floadting
                                                        --this is to avoid latching
   
    end if;
  end if; 
end process;

end architecture behave;


