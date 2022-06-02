module register16 (
	input [15:0] d,
	input changeEnable,     //Change Enable
	input reset,  //同期リセット
	input clock,    //クロック
	output reg [15:0] q
);

	always @ (posedge clock) begin 
		if (reset) begin
			q <= 16'h0000;
		end else if ( changeEnable ) begin
				q <= d;
		end
	end
	
endmodule
