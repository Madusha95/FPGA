library ieee;
use ieee.std_logic_1164.all;

entity MAR is
  generic (
    N: integer := 5
    );
  port (
    MARin              :in  std_logic_vector(N-1 downto 0);   --address of the instruction to execute 
    clk,rst,en         :in  std_logic;  
    MARout             :out std_logic_vector(N-1 downto 0)    --address to be fed to the ram  
  );
end entity MAR;

architecture behave of MAR is

begin
  process(clk,rst) begin
    
    if(rst='1') then
      Marout <= (others => '0'); 
    
    elsif(rising_edge(clk)) then      
      
      if(en='1') then
        MARout <= MARin;
      
      end if;
    end if;
  end process;
end architecture behave;

