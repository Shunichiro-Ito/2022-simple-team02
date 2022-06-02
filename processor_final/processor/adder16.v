module adder16 (
	input [15:0] a,
	input [15:0] b,
	output [15:0] aPlusB
);

	assign aPlusB = a + b;
	
endmodule
