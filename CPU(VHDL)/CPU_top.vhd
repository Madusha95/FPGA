library ieee;                                                   
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.Comp_types.all;
use work.Components.all;

entity CPU_top is
  port(
  inport        : in std_logic_vector(7 downto 0);
  clk           : in std_logic;
  rst           : in std_logic;
  outport       : out std_logic_vector(7 downto 0)
);        
end entity CPU_top;

architecture port_map of CPU_top is
  
signal pc_out       : std_logic_vector(4 downto 0);
signal inc_out      : signed(4 downto 0);

signal pc_in        : std_logic_vector(4 downto 0);

signal adbus        : std_logic_vector(4 downto 0);
signal mar_out      : std_logic_vector(4 downto 0);

signal dbus         : std_logic_vector(7 downto 0);

signal ir_out       : std_logic_vector(4 downto 0);
signal ir_inst_out  : std_logic_vector(2 downto 0);
signal ir_dio_out   : std_logic;

signal a_out_alu    : std_logic_vector(7 downto 0);
signal a_out        : std_logic_vector(7 downto 0);

signal b_out_alu    : std_logic_vector(7 downto 0);
signal b_out        : std_logic_vector(7 downto 0);

signal alu_out      : signed(7 downto 0);

signal ctrl_signals : ctrl_unit_signals;

begin
          
  inc_inst : INC port map(
    INCin  => signed(pc_out),
    PCin1  => ctrl_signals.pc_in1,
    PCin2  => ctrl_signals.pc_in2,
    INCout => inc_out);          
  
  pc_inst : PC port map(
    PCin  => pc_in,
    en   => ctrl_signals.pc_en,
    rst   => ctrl_signals.pc_rt,
    PCout => pc_out);
    
  mar_inst : MAR generic map(
    N => 5
  )
                    port map(
    MARin  => adbus,         
    clk    => clk,
    rst    => rst,
    en     => ctrl_signals.mar_en,
    MARout => mar_out);
    
  ram_inst : RAM generic map(
    A => 5,
    N => 8
  )
                    port map(
    RAMin => mar_out,           
    clk    => clk,
    rd     => ctrl_signals.ram_rd,
    wr     => ctrl_signals.ram_wr,
    RAMout_in => dbus,
    RAMout_out => dbus);
    
  ir_inst : IR generic map(
    A => 5,
    N => 8
  )
                    port map(
    IRin      => dbus, 
    en        => ctrl_signals.ir_en, 
    IRout     => ir_out,
    IRinstout => ir_inst_out,
    IRdioout  => ir_dio_out); 
    
  a_inst : A generic map(
    N => 8
  )
                    port map(
    Ain       => dbus, 
    en        => ctrl_signals.a_en,
    Aout_alu  => a_out_alu,
    Aout_dbus => a_out);   
   
  b_inst : B generic map(
    N => 8
  )
                    port map(
    Bin       => dbus, 
    en        => ctrl_signals.b_en,
    Bout_alu  => b_out_alu,
    Bout_dbus => b_out);
    
  alu_inst : ALU generic map(
    N => 8
  )
                    port map(
    ALUina => signed(a_out_alu),
    ALUinb => signed(b_out_alu), 
    AddSub => ctrl_signals.add_sub,
    ALUout => alu_out);
    
  control_unit_inst : Control_unit port map(
    instructions => ir_inst_out,
    ins_dio      => ir_dio_out,  
    a            => a_out,
    b            => b_out,
    clk          => clk,
    rst          => rst,
    ctrl_signals => ctrl_signals); 
  
  inc_tsb_pc_inst : TSB generic map(
    N => 5
  )
                           port map(
    input  => std_logic_vector(inc_out),
    en     => ctrl_signals.inc_tsb_pc,
    output => pc_in);
    
  adbus_tsb_pc_inst : TSB generic map(
    N => 5
  )
                           port map(
    input  => adbus,
    en     => ctrl_signals.adbus_tsb_pc,
    output => pc_in);
  
  pc_tsb_adbus_inst : TSB generic map(
    N => 5
  )
                           port map(
    input  => pc_out,
    en     => ctrl_signals.pc_tsb_adbus,
    output => adbus);  
      
  in_tsb_dbus_inst : TSB generic map(
    N => 8
  )
                           port map(
    input  => inport,
    en     => ctrl_signals.input_tsb_dbus,
    output => dbus);
  
  ir_tsb_adbus_inst : TSB generic map(
    N => 5
  )
                           port map(
    input  => ir_out,
    en     => ctrl_signals.ir_tsb_adbus,
    output => adbus);
  
  a_tsb_dbus_inst : TSB generic map(
    N => 8
  )
                           port map(
    input  => a_out,
    en     => ctrl_signals.a_tsb_dbus,
    output => dbus);
  
  b_tsb_dbus_inst : TSB generic map(
    N => 8
  )
                           port map(
    input  => b_out,
    en     => ctrl_signals.b_tsb_dbus,
    output => dbus);
              
  alu_tsb_dbus_inst : TSB generic map(
    N => 8
  )
                           port map(
    input  => std_logic_vector(alu_out),
    en     => ctrl_signals.alu_tsb_dbus,
    output => dbus);    
  
  dbus_tsb_out_inst : TSB generic map(
    N => 8
  )
                           port map(
    input  => dbus,
    en     => ctrl_signals.dbus_tsb_output,
    output => outport);
            
end architecture port_map;