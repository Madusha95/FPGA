library ieee;                                                   
use ieee.std_logic_1164.all;

package Comp_types is
  
  type ctrl_unit_signals is record
    pc_in1          : std_logic;
    pc_in2          : std_logic;
    inc_tsb_pc      : std_logic;
    pc_rt           : std_logic;
    pc_en           : std_logic;
    pc_tsb_adbus    : std_logic;
    adbus_tsb_pc    : std_logic;
    mar_en          : std_logic;
    ram_rd          : std_logic;
    ram_wr          : std_logic;
    input_tsb_dbus  : std_logic;
    dbus_tsb_output : std_logic;
    ir_en           : std_logic;
    ir_tsb_adbus    : std_logic;
    a_en            : std_logic;
    a_tsb_dbus      : std_logic;
    b_en            : std_logic;
    b_tsb_dbus      : std_logic;
    add_sub         : std_logic;
    alu_tsb_dbus    : std_logic;
    
  end record ctrl_unit_signals;

  type state is (pcreset,refresh,clkpulseadd,clkpulsesub,clkpulsecmp,fetch1,fetch2,add1,add2,add3,sub1,sub2,sub3,sta1,sta2,lda1,lda2,jmp,cmp1,cmp2,cmp3,dio,hlt);

end package Comp_types;


