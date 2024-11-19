module encoder_4to2_tb;

  reg [3:0] data;
  wire [1:0] encoded;

  encoder_4to2 uut(
    .data(data),
    .encoded(encoded)
  );
  initial begin
   // Test case 1
    data = 4'b0000;
    #10;

    // Test case 2
    data = 4'b0001;
    #10;

    // Test case 3
    data = 4'b0010;
    #10;

    // Test case 4
    data = 4'b0100;
    #10;

    // Test case 5
    data = 4'b1000;
    #10;

    // Test case 6 
    data = 4'b1111;
    #10;

  end
endmodule
