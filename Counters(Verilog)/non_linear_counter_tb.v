
module non_linear_counter_tb();
  
  reg clk;
  reg reset;
  wire [2:0] count;

  non_linear_counter dut(
    .clk(clk),
    .reset(reset),
    .count(count)
  );
  
  initial begin
    clk = 0;
    reset = 0;
    #50 reset = 1; // Assert reset for 10 time units
    #10 reset = 0; // Deassert reset
    
  end
  
  always #5 clk = ~clk; // Generate a clock signal with a period of 10 time units

endmodule