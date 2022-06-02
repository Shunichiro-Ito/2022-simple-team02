module multiplexer16 (
	input [15:0] in0,
	input [15:0] in1, 
	input selector, 
	output [15:0] out 
); 

	wire [15:0] s;

	assign s[0]  = selector;
	assign s[1]  = selector;
	assign s[2]  = selector;
	assign s[3]  = selector;
	assign s[4]  = selector;
	assign s[5]  = selector;
	assign s[6]  = selector;
	assign s[7]  = selector;
	assign s[8]  = selector;
	assign s[9]  = selector;
	assign s[10]  = selector;
	assign s[11]  = selector;
	assign s[12]  = selector;
	assign s[13]  = selector;
	assign s[14]  = selector;
	assign s[15]  = selector;
	
	assign out = (in1&s)|(in0&~s);

endmodule
