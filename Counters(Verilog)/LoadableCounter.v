
module LoadableCounter #(parameter WIDTH = 8)( //Parameterzed variable is WIDTH 
  input wire clk,
  input wire rst,
  input wire ld,
  input wire en,
  input wire [WIDTH-1:0] input_value,
  output wire [WIDTH-1:0] counter
);

  reg [WIDTH-1:0] counter_reg;  //Internal Signal 

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      counter_reg <= 0;
    end else begin
      if (ld) begin
        counter_reg <= input_value;
      end else if (en) begin
        counter_reg <= counter_reg + 1;
      end
    end
  end

  assign counter = counter_reg;

endmodule
