library ieee;                                                   
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.Comp_types.all;

entity Control_unit is
  port(
    instructions  : in std_logic_vector(2 downto 0);  --3 bit instruction from IR
    ins_dio       : in std_logic;                     --4th bit of IR input
    a,b           : in std_logic_vector(7 downto 0);  --outputs from A and B registers
    clk,rst       : in std_logic;
    ctrl_signals  : out ctrl_unit_signals             --signals to be used to enable TSBs and registers
  );
end entity Control_unit;

architecture behave of Control_unit is

signal pr_state, nx_state : state;
begin

  process(clk,rst) 
  begin
    
    if(rst = '1') then
      pr_state <= pcreset;
  
    elsif(rising_edge(clk)) then 
      pr_state <= nx_state;
    
    end if;
  end process;

  process(pr_state,instructions)
  begin
    
    case pr_state is
      
      when pcreset =>   --when CPU resets then address of the Program counter should be reset
        
        ctrl_signals.pc_rt            <= '1';   --resets the PC so the address is at its initial value
        
        ctrl_signals.pc_in1           <= '0';
        ctrl_signals.pc_in2           <= '0';
        ctrl_signals.inc_tsb_pc       <= '0';
        ctrl_signals.pc_en            <= '0';
        ctrl_signals.pc_tsb_adbus     <= '0';
        ctrl_signals.adbus_tsb_pc     <= '0';
        ctrl_signals.mar_en           <= '0';
        ctrl_signals.ram_rd           <= '0';
        ctrl_signals.ram_wr           <= '0';
        ctrl_signals.input_tsb_dbus   <= '0';
        ctrl_signals.dbus_tsb_output  <= '0'; 
        ctrl_signals.ir_en            <= '0';
        ctrl_signals.ir_tsb_adbus     <= '0';
        ctrl_signals.a_en             <= '0';
        ctrl_signals.a_tsb_dbus       <= '0';
        ctrl_signals.b_en             <= '0';
        ctrl_signals.b_tsb_dbus       <= '0';
        ctrl_signals.alu_tsb_dbus     <= '0';
        
        ctrl_signals.add_sub          <= 'Z';   --set to float as when changed, will trigger the ALU which is unnecessary  
        
        nx_state <= fetch1;
      
      when refresh =>
      
        ctrl_signals.a_tsb_dbus       <= '0';
        ctrl_signals.ram_wr       	   <= '0';
        ctrl_signals.pc_in1           <= '0';
        ctrl_signals.inc_tsb_pc       <= '0';
        ctrl_signals.pc_en            <= '0';
        ctrl_signals.ir_en            <= '1';   --enable the IR so data from the data bus is split into instruction and address
        ctrl_signals.ram_rd           <= '0';
        ctrl_signals.a_en             <= '0';
        
        nx_state <= fetch1;
      
       
      
      when fetch1 =>  --address of the program counter is fed to the RAM
        
        ctrl_signals.pc_tsb_adbus     <= '1';   --enable the TSB so that address is assigned to adbus
        ctrl_signals.mar_en           <= '1';   --enable the MAR so that address is assigned to RAM
        
        ctrl_signals.pc_in1           <= '0';
        ctrl_signals.pc_in2           <= '0';
        ctrl_signals.inc_tsb_pc       <= '0';
        ctrl_signals.pc_rt            <= '0';
        ctrl_signals.pc_en            <= '0';
        ctrl_signals.adbus_tsb_pc     <= '0';
        ctrl_signals.ram_rd           <= '0';
        ctrl_signals.ram_wr           <= '0';
        ctrl_signals.input_tsb_dbus   <= '0';
        ctrl_signals.dbus_tsb_output  <= '0'; 
        ctrl_signals.ir_en            <= '0';
        ctrl_signals.ir_tsb_adbus     <= '0';
        ctrl_signals.a_en             <= '0';
        ctrl_signals.a_tsb_dbus       <= '0';
        ctrl_signals.b_en             <= '0';
        ctrl_signals.b_tsb_dbus       <= '0';
        ctrl_signals.alu_tsb_dbus     <= '0';
        
        ctrl_signals.add_sub          <= 'Z';
        
        nx_state <= fetch2;
        
      when fetch2 =>  --Reads the instruction from RAM  
        
        ctrl_signals.pc_in1           <= '1';   --increment the address by 1 in INC
        ctrl_signals.inc_tsb_pc       <= '1';   --enable TSB so that INC out is assigned to PC in
        ctrl_signals.ram_rd           <= '1';   --read data from RAM
        ctrl_signals.ir_en            <= '1';   
        
        ctrl_signals.pc_in2           <= '0';
        ctrl_signals.pc_rt            <= '0';
        ctrl_signals.pc_en            <= '0';
        ctrl_signals.pc_tsb_adbus     <= '0';
        ctrl_signals.adbus_tsb_pc     <= '0';
        ctrl_signals.mar_en           <= '0';
        ctrl_signals.ram_wr           <= '0';
        ctrl_signals.input_tsb_dbus   <= '0';
        ctrl_signals.dbus_tsb_output  <= '0'; 
        ctrl_signals.ir_tsb_adbus     <= '0';
        ctrl_signals.a_en             <= '0';
        ctrl_signals.a_tsb_dbus       <= '0';
        ctrl_signals.b_en             <= '0';
        ctrl_signals.b_tsb_dbus       <= '0';
        ctrl_signals.alu_tsb_dbus     <= '0';
        
        case instructions is  --checks the 3 bit instruction from IR
	        
	        when "000" =>
	          ctrl_signals.inc_tsb_pc <= '0'; 
	          nx_state <= add1;			
	        
	        when "001" =>
	          ctrl_signals.inc_tsb_pc <= '0';
	          nx_state <= sub1;
	        
	        when "010" =>
	          ctrl_signals.pc_en      <= '1';  --enables PC so PC out has the new address
	          ctrl_signals.pc_in1    	<= '0';
	          ctrl_signals.inc_tsb_pc <= '0';
	          nx_state <= sta1;
	        
	        when "011" =>
	          ctrl_signals.pc_en      <= '1';
	          ctrl_signals.pc_in1    	<= '0';
	          ctrl_signals.inc_tsb_pc <= '0';
	          nx_state <= lda1;
	        
	        when "100" =>
	          
	          ctrl_signals.inc_tsb_pc   <= '0';
	          nx_state <= jmp;
	        
	        when "101" =>
	          ctrl_signals.pc_in1     <= '0';
	          ctrl_signals.inc_tsb_pc <= '0';
	          nx_state <= cmp1;
	        
	        when "110" =>
	          ctrl_signals.ram_rd <= '0';
	          nx_state <= dio;
	        
	        when "111" =>
	          nx_state <= hlt;
	        
	        when others =>
	          nx_state <= pr_state;	
        end case;
      
      when add1 =>  --output the address from the IR and assign to RAM
        
        ctrl_signals.inc_tsb_pc    <= '1';
        ctrl_signals.ir_tsb_adbus  <= '1';
        ctrl_signals.mar_en        <= '1';
        
        nx_state <= add2;
        
      when add2 =>  --read the data in RAM at the particular address and store it in register B 
        
        ctrl_signals.ram_rd       <= '1';
        ctrl_signals.b_en         <= '1';
        
        ctrl_signals.ir_en        <= '0';
        
        
        nx_state <= clkpulseadd;  
      
      when clkpulseadd =>   --extra state to obtain the required changes as some components are triggered by the clock input
      
        nx_state <= add3;    
      
      when add3 =>  --add the value in register A with the value in register B
        
        ctrl_signals.add_sub      <= '1';   --triggers the ALU and add process is initiated
        ctrl_signals.alu_tsb_dbus <= '1' after 20 ps;   --output of the ALU is assigned to data bus, this is done after a particular time to avoid latches
        ctrl_signals.a_en         <= '1';   --stores the calculated value in data bus inside register A
        ctrl_signals.pc_en        <= '1';
        
        ctrl_signals.b_en         <= '0';
        ctrl_signals.ram_rd       <= '0';
        
        
        nx_state <= fetch1;
        
      when sub1 =>  --similar to add1 state
        
        ctrl_signals.inc_tsb_pc    <= '1';
        ctrl_signals.ir_tsb_adbus  <= '1';
        ctrl_signals.mar_en        <= '1';
        
        nx_state <= sub2;
        
      when sub2 =>  --similar to add2 state
        
        ctrl_signals.ram_rd       <= '1';
        ctrl_signals.b_en         <= '1';
        
        ctrl_signals.ir_en        <= '0';
        
        
        nx_state <= clkpulsesub;
      
      when clkpulsesub =>   --similar to clkpulseadd state
        
        nx_state <= sub3;
          
      when sub3 =>  --similar to add3 state but this time process is subtraction
        
        ctrl_signals.add_sub      <= '0';   --triggers the ALU and subtraction process is initiated
        ctrl_signals.alu_tsb_dbus <= '1' after 20 ps;
        ctrl_signals.a_en         <= '1';
        
        ctrl_signals.b_en         <= '0';
        ctrl_signals.ram_rd       <= '0';
        
      
        nx_state <= fetch1;
      
      when sta1 =>  --output the address from the IR and assign to RAM
        
        ctrl_signals.ir_tsb_adbus     <= '1';
        ctrl_signals.mar_en           <= '1';
        
        ctrl_signals.inc_tsb_pc       <= '0';
        ctrl_signals.ram_rd           <= '0';
        ctrl_signals.ir_en            <= '0';
        
        nx_state <= sta2;
        
      when sta2 =>  --writes the data from the data bus to the memory in RAM at given address
        
        ctrl_signals.a_tsb_dbus       <= '1';   --assign the value in register A to the databus
        ctrl_signals.ram_wr       	   <= '1';   --write data from data bus to RAM
        
        ctrl_signals.ir_tsb_adbus     <= '0';
        ctrl_signals.mar_en           <= '0';
        ctrl_signals.pc_en            <= '0';
        
        nx_state <= refresh;
        
      when lda1 =>  --similar to sta1 state
        
        ctrl_signals.ir_tsb_adbus     <= '1';
        ctrl_signals.mar_en           <= '1';
        
        ctrl_signals.inc_tsb_pc       <= '0';
        ctrl_signals.ram_rd           <= '0';
        ctrl_signals.ir_en            <= '0';
        
        nx_state <= lda2;
        
      when lda2 =>  --reads data from RAM at given memory address and assign that value to register A
        
        ctrl_signals.a_en             <= '1';
        ctrl_signals.ram_rd           <= '1';
        
        ctrl_signals.ir_tsb_adbus     <= '0';
        ctrl_signals.mar_en           <= '0';
        ctrl_signals.pc_en            <= '0';
        
        nx_state <= refresh;
                
      when jmp =>   --jump to the address given, so program is executed beyond this address
        
   
        ctrl_signals.ir_tsb_adbus <= '1';
        ctrl_signals.adbus_tsb_pc <= '1' after 20 ps;
        ctrl_signals.pc_en        <= '1' after 40 ps;
        
        nx_state <= fetch1;
        
      when cmp1 =>  --similar to add1
      
        ctrl_signals.inc_tsb_pc   <= '1';
        ctrl_signals.ir_tsb_adbus <= '1';
        ctrl_signals.mar_en       <= '1';
        
        nx_state <= cmp2;
        
      when cmp2 =>  --similar to add2
        
        
        ctrl_signals.ram_rd       <= '1';
        ctrl_signals.b_en         <= '1';
        
        ctrl_signals.mar_en       <= '0';
        ctrl_signals.ir_en        <= '0';
        
        nx_state <= clkpulsecmp;
        
      when clkpulsecmp =>   --similar to clkpulseadd
      
        nx_state <= cmp3;
          
      when cmp3 =>  --increment the address by one when value is register A is less than in register B,
                    --else by 2
        
        if(a<b) then
          
          ctrl_signals.pc_in1 <= '1';
        
        else
          
          ctrl_signals.pc_in2 <= '1';
        
        end if;
        
        ctrl_signals.pc_en <= '1' after 20 ps;
        
        ctrl_signals.b_en <= '0';
        ctrl_signals.ram_rd <= '0';
        
              
        nx_state <= fetch1;
              
      when dio =>   --reads data from inport or outputs data to outport
        
      if(ins_dio='0') then  --read input value and assign to register A
      
        ctrl_signals.input_tsb_dbus  <= '1';
        ctrl_signals.a_en            <= '1';
        
      elsif(ins_dio='1') then   --read value from register A and output through outport
        
        ctrl_signals.a_tsb_dbus       <= '1';     
        ctrl_signals.dbus_tsb_output  <= '1';     
        
      end if;
      
        ctrl_signals.pc_en            <= '1';
      
        ctrl_signals.pc_in1           <= '0';
        ctrl_signals.pc_in2           <= '0';
        ctrl_signals.inc_tsb_pc       <= '0';
        ctrl_signals.pc_rt            <= '0';
        ctrl_signals.pc_tsb_adbus     <= '0';
        ctrl_signals.adbus_tsb_pc     <= '0';
        ctrl_signals.mar_en           <= '0';
        ctrl_signals.ram_rd           <= '0';
        ctrl_signals.ram_wr           <= '0'; 
        ctrl_signals.ir_en            <= '0';
        ctrl_signals.ir_tsb_adbus     <= '0';
        ctrl_signals.b_en             <= '0';
        ctrl_signals.b_tsb_dbus       <= '0';
        ctrl_signals.alu_tsb_dbus     <= '0';
        
      nx_state <= fetch1;
        
      when hlt =>   --reset the PC when the CPU execution is finished
        nx_state <= pcreset;
    end case; 
  end process;

end architecture behave;



