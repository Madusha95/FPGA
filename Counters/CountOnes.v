
module CountOnes (
  input [3:0] input_vector,
  output reg [2:0] output_vector
);

  always @(*)
  begin
    case (input_vector)
      4'b0000: output_vector = 3'b000;
      4'b0001: output_vector = 3'b001;
      4'b0010: output_vector = 3'b001;
      4'b0011: output_vector = 3'b010;
      4'b0100: output_vector = 3'b001;
      4'b0101: output_vector = 3'b010;
      4'b0110: output_vector = 3'b010;
      4'b0111: output_vector = 3'b011;
      4'b1000: output_vector = 3'b001;
      4'b1001: output_vector = 3'b010;
      4'b1010: output_vector = 3'b010;
      4'b1011: output_vector = 3'b011;
      4'b1100: output_vector = 3'b010;
      4'b1101: output_vector = 3'b011;
      4'b1110: output_vector = 3'b011;
      4'b1111: output_vector = 3'b100;
      default: output_vector = 3'b000;
    endcase
  end

endmodule
