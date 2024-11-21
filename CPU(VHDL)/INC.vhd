library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity INC is
  port(
    INCin            : in signed(4 downto 0);   --old address from Program counter
    PCin1, PCin2     : in std_logic;
    INCout           : out signed(4 downto 0)   --new address to the Program counter
  );                                            --input and output both are of signed, so that it can be used to increment
end entity INC;

architecture behave of INC is

begin

  process(INCin,PCin1,PCin2)  --triggers when any of these inputs change
  begin
    
    if(PCin1='1') then
      INCout <= INCin + 1;    --increment the address by 1
      
    elsif(PCin2='1') then
      INCout <= INCin + 2;    --increment the address by 2
      
    else 
      INCout <= INCin;        --when there is no increment, just output the input address
       
    end if;
  end process;
end architecture behave;



