module LoadableCounter_tb;
  
  reg clk;
  reg rst;
  reg ld;
  reg en;
  reg [7:0] input_value;
  wire [7:0] counter;

  LoadableCounter #(8) dut (
    .clk(clk),
    .rst(rst),
    .ld(ld),
    .en(en),
    .input_value(input_value),
    .counter(counter)
  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    rst = 1;
    ld = 0;
    en = 0;
    input_value = 8'b00000001; //assigning input to be 1
    #10 rst = 0;
    #10 ld = 1;
    #15 ld = 0;

    #10 en = 1 ; 
    
    
  end

endmodule

