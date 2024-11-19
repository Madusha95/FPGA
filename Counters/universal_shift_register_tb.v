module universal_shift_register_tb();
  reg clk;
  reg reset;
  reg [7:0] data;
  reg [1:0] ctrl;
  wire [7:0] out;

  universal_shift_register #(8) uut (
    .clk(clk),
    .reset(reset),
    .data(data),
    .ctrl(ctrl),
    .out(out)
  );

  initial begin
    clk = 0;
    reset = 0;
    data = 8'b00000000;
    ctrl = 2'b00;

    #10 reset = 1;  // Assert reset
    #10 reset = 0;  // De-assert reset

    // Case 1: Load parallel data
    data = 8'b10101010;
    ctrl = 2'b11;
    #10;
       // Case 2: Shift right
    ctrl = 2'b01;
    repeat(7) @(negedge clk);

   // Case 3: Shift left
    #10 reset = 1;  // Assert reset
    #10 reset = 0;  // De-assert reset

    data = 8'b11111111;
    ctrl = 2'b11;
    #10;
    ctrl = 2'b10;
    repeat(8) @(negedge clk);

    data = 8'b11110111;
    ctrl = 2'b11;
    #30;

   // Case 4: No change
    ctrl = 2'b00;
    #10;
   
  end

  always begin
    #5 clk = ~clk; // Toggle clock every 5 time units
  end

endmodule

