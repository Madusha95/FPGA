library ieee;
use ieee.std_logic_1164.all;

entity TSB is
  generic (
    N : integer := 8
  );
  port(
    input   : in std_logic_vector (N-1 downto 0);
    en      : in std_logic;
    output  : out  std_logic_vector (N-1 downto 0)
  );
end entity TSB;

architecture behave of TSB is
  
begin
  process(en,input)
  begin  
    if(en = '1') then
      output <= input;
    else
      output <= (others => 'Z');
    end if;
  end process;
end architecture behave;


