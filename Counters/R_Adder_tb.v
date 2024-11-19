
module R_Adder_tb;
  reg [3:0] A, B;
  wire [3:0] S;
  wire Cout;

  R_Adder UUT(.A(A), .B(B), .S(S), .Cout(Cout));

  initial begin
    // Test case 1
    A = 4'b0000;
    B = 4'b0000;
    #10;
    // Test case 2
    A = 4'b1010;
    B = 4'b0110;
    #10;
    // Test case 3
    A = 4'b1101;
    B = 4'b0101;
    #10; 
    // Test case 4
    A = 4'b0001;
    B = 4'b0001;
    #10;
    // Test case 5
    A = 4'b1111;
    B = 4'b1111;

  end
endmodule
