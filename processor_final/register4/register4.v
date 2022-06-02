module register4 (
	input [3:0] d,
	input changeEnable,     //Change Enable
	input reset,  //同期リセット
	input clock,    //クロック
	output reg [3:0] q
);

	always @ (posedge clock) begin 
		if (reset) begin
			q <= 4'h0;
		end else if ( changeEnable ) begin
				q <= d;
		end
	end
	
endmodule
