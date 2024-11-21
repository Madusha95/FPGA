module universal_shift_register
  #(parameter N=8)
  (
    input wire clk,             // Clock input
    input wire reset,           // Reset input
    input wire [N-1:0] data,    // Parallel input data (N-bit)
    input wire [1:0] ctrl,      // Control signal
    output reg [N-1:0] out      // Parallel output data (N-bit)
  );

  reg [N-1:0] r_reg, r_next;    // Internal signals of Shift register


// Register 
  always @(posedge clk, posedge reset) begin
    if (reset)
      r_reg <= 0;               // Reset the shift register
    else
      r_reg <= r_next;
  end

//Next State
  always @(*)
  begin
    case(ctrl)
      2'b00: r_next = r_reg;                                 // No change
      2'b01: r_next = {r_reg[N-2:0], 1'b0};                // Shift right
      2'b10: r_next = {1'b0, r_reg[N-1:1]};              // Shift left
      2'b11: r_next = data;                              // Load parallel data
      default : r_next = r_reg;                          //If default,no change 
    endcase
  end

//Output
  assign out = r_reg;

endmodule


