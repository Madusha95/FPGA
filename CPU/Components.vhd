library ieee;                                                   
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.Comp_types.all;

package Components is
  
  component INC is
  port(
    INCin            : in signed(4 downto 0);
    PCin1, PCin2     : in std_logic;
    INCout           : out signed(4 downto 0)
  );
  end component INC;
  
  component PC is
  port(
    PCin      : in std_logic_vector(4 downto 0);
    en        : in std_logic;
    rst       : in std_logic;
    PCout     : out std_logic_vector(4 downto 0)
  );
  end component PC;

  component TSB is
  generic (
    N : integer := 8
  );
  port(
    input   : in std_logic_vector (N-1 downto 0);
    en      : in std_logic;
    output  : out  std_logic_vector (N-1 downto 0)
  );
  end component TSB;
  
  component MAR is
  generic (
    N: integer := 5
    );
  port (
    MARin              :in  std_logic_vector(N-1 downto 0); 
    clk,rst,en         :in  std_logic;
    MARout             :out std_logic_vector(N-1 downto 0)  
  );
  end component MAR;
  
  component RAM is
  generic (
    A  : integer := 5;
    N  : integer := 8
  );
  port(
    RAMin          : in std_logic_vector(A-1 downto 0);
    clk,rd,wr      : in std_logic;
    RAMout_in      : in std_logic_vector(N-1 downto 0);
    RAMout_out     : out std_logic_vector(N-1 downto 0)  
  );
  end component RAM;
  
  component IR is
  generic (
    N: integer := 8;
    A: integer := 5
    );
  port (
    IRin       :in  std_logic_vector(N-1 downto 0); 
    en         :in  std_logic;
    IRout      :out std_logic_vector(A-1 downto 0);
    IRinstout  :out std_logic_vector(2 downto 0);
    IRdioout   :out std_logic  
  );
  end component IR;
  
  component A is
  generic (
    N: integer := 8
    );
  port (
    Ain             :in  std_logic_vector(N-1 downto 0); 
    en              :in  std_logic;
    Aout_alu        :out std_logic_vector(N-1 downto 0);
    Aout_dbus       :out std_logic_vector(N-1 downto 0)  
  );
  end component A;
  
  component B is
  generic (
    N: integer := 8
    );
  port (
    Bin             :in  std_logic_vector(N-1 downto 0); 
    en              :in  std_logic;
    Bout_alu        :out std_logic_vector(N-1 downto 0);
    Bout_dbus       :out std_logic_vector(N-1 downto 0)  
  );
  end component B;
  
  component ALU is
  generic (
    N : integer := 8
  );
  port(
    ALUina, ALUinb    : in signed(N-1 downto 0);
    AddSub            : in std_logic;
    ALUout            : out signed(N-1 downto 0)
  );
  end component ALU;
  
  component Control_unit is
  port(
    instructions  : in std_logic_vector(2 downto 0);
    ins_dio       : in std_logic;  
    a,b           : in std_logic_vector(7 downto 0);
    clk,rst       : in std_logic;
    ctrl_signals  : out ctrl_unit_signals
  );
end component Control_unit;
  
end package Components;


