library ieee;
use ieee.std_logic_1164.all;

entity IR is
  generic (
    N: integer := 8;
    A: integer := 5
    );
  port (
    IRin       :in  std_logic_vector(N-1 downto 0);   --input from the databus 
    en         :in  std_logic;
    IRout      :out std_logic_vector(A-1 downto 0);   --last 5 bits of the input which is fed as address to the adbus
    IRinstout  :out std_logic_vector(2 downto 0);     --first 3 bits of the input which is fed as instruction to the control unit
    IRdioout   :out std_logic  
  );
end entity IR;

architecture behave of IR is

begin
  process(IRin,en) begin
    
    if(en='1') then
        IRout <= IRin(A-1 downto 0);      --last 5 bits of the input which is fed as address to the adbus
        IRinstout <= IRin(N-1 downto A);  --first 3 bits of the input which is fed as instruction to the control unit
        IRdioout <= IRin(A-1);            --4th bit of the input which is used in DIO state 
    
    end if;
  end process;
end architecture behave;



