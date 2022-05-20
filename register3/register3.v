module register3 (
	input [2:0] d,
	input changeEnable,     //Change Enable
	input reset,  //同期リセット
	input clock,    //クロック
	output reg [2:0] q
);

	always @ (posedge clock) begin 
		if (reset) begin
			q <= 3'b000;
		end else if ( changeEnable ) begin
				q <= d;
		end
	end
	
endmodule
