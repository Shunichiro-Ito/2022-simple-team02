module incrementer  (
	input [15:0] pc_pre,
	output [15:0] pc_post
);

assign pc_post = pc_pre + 16'b00_0000_0001;

endmodule
