library ieee;
use ieee.std_logic_1164.all;

entity A is
  generic (
    N: integer := 8
    );
  port (
    Ain             :in  std_logic_vector(N-1 downto 0); 
    en              :in  std_logic;
    Aout_alu        :out std_logic_vector(N-1 downto 0);
    Aout_dbus       :out std_logic_vector(N-1 downto 0)  
  );
end entity A;

architecture behave of A is

begin
  process(Ain,en) begin
    
    if(en='1') then
      
      Aout_alu <= Ain;    --output which is connected to the ALU
      Aout_dbus <= Ain;   --output which is connected to the dbus    
      
    end if;
  end process;
end architecture behave;



