module encoder_4to2(
  input [3:0] data,
  output [1:0] encoded
);

  reg [1:0] encoded_reg; //Internal signals for outputs  

  always @*
    case (data)
      4'b0001: encoded_reg = 2'b00;
      4'b0010: encoded_reg = 2'b01;
      4'b0100: encoded_reg = 2'b10;
      4'b1000: encoded_reg = 2'b11;
      default: encoded_reg = 2'bxx;
    endcase

  assign encoded = encoded_reg;

endmodule
