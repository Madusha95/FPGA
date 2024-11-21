library ieee;
use ieee.std_logic_1164.all;

entity B is
  generic (
    N: integer := 8
    );
  port (
    Bin             :in  std_logic_vector(N-1 downto 0); 
    en              :in  std_logic;
    Bout_alu        :out std_logic_vector(N-1 downto 0);
    Bout_dbus       :out std_logic_vector(N-1 downto 0)  
  );
end entity B;

architecture behave of B is

begin
  process(Bin,en) begin
    
    if(en='1') then
      
      Bout_alu <= Bin;    --output which is connected to the ALU    
      Bout_dbus <= Bin;   --output which is connected to the dbus
      
    end if;
  end process;
end architecture behave;





