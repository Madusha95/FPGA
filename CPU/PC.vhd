library ieee;
use ieee.std_logic_1164.all;

entity PC is
  port(
    PCin      : in std_logic_vector(4 downto 0);  --new address from INC
    en        : in std_logic;
    rst       : in std_logic;
    PCout     : out std_logic_vector(4 downto 0)  --address of the instruction in RAM
  );
end entity PC;

architecture behave of PC is

begin
  process(en,rst)
  begin
    
    if(rst='1') then
      PCout <= (others => '0');   --if CPU is reset the program should start from first
       
    elsif(en='1') then
      PCout <= PCin;              --else the new address is assigned to output
        
    end if;
  end process;
end architecture behave;



