module non_linear_counter(
  input wire clk,
  input wire reset,
  output reg [2:0] count
);

  always @(posedge clk or posedge reset) begin
    if (reset)
      count <= 3'b000; // Reset the counter to 0
    else begin
      case(count)
        3'b000: count <= 3'b001; // 0 -> 1
        3'b001: count <= 3'b011; // 1 -> 3
        3'b011: count <= 3'b110; // 3 -> 6
        3'b110: count <= 3'b010; // 6 -> 2
        3'b010: count <= 3'b101; // 2 -> 5
        3'b101: count <= 3'b100; // 5 -> 4
        3'b100: count <= 3'b000; // 4 -> 0
        default: count <= 3'b000; // Reset to 0 if none of the above cases match
      endcase
    end
  end

endmodule
