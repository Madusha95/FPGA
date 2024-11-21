module R_Adder(
	input [3:0] A,B, 
	output [3:0] S,
	output Cout);

	wire w0,w1,w2; //Internal signals for c0,c1,c2

    //Structural Design 
    HalfAdder FA0(.A(A[0]), .B(B[0]), .S(S[0]), .C(w0));
    FullAdder FA1(.A(A[1]),.B(B[1]),.Cin(w0),.S(S[1]),.Cout(w1));
    FullAdder FA2(.A(A[2]),.B(B[2]),.Cin(w1),.S(S[2]),.Cout(w2));
    FullAdder FA3(.A(A[3]),.B(B[3]),.Cin(w2),.S(S[3]),.Cout(Cout));

endmodule
