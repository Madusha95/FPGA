library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
  generic (
    N : integer := 8
  );
  port(
    ALUina, ALUinb    : in signed(N-1 downto 0);
    AddSub            : in std_logic;
    ALUout            : out signed(N-1 downto 0)
  );
end entity ALU;

architecture behave of ALU is

begin

  process(AddSub)
  begin
  
    case AddSub is
    
      when '1' =>
        ALUout <= ALUina + ALUinb;  --addition
    
      when '0' =>
        ALUout <= ALUina - ALUinb;  --subtraction
    
      when others =>
        null;
  
    end case;
  end process;
end architecture behave;


