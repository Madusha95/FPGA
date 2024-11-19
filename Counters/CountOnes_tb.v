module CountOnes_tb();

  reg [3:0] input_vector;
  wire [2:0] output_vector;

  CountOnes uut (
    .input_vector(input_vector),
    .output_vector(output_vector)
  );
  initial begin
    // Test case 1
    input_vector = 4'b0000;
    #10;
    // Expected output: 3'b000

    // Test case 2
    input_vector = 4'b1011;
    #10;
    // Expected output: 3'b011

    // Test case 3
    input_vector = 4'b1001;
    #10;
    // Expected output: 3'b010

    // Test case 4
    input_vector = 4'b1111;
    #10;
    // Expected output: 3'b100

    // Test case 5
    input_vector = 4'b1100;
    #10;
    // Expected output: 3'b010
  end

endmodule

