module SZCVJudge16 (
    input [15:0] data,
    output [3:0] SZCV
);

	assign SZCV[1:0] = 2'b00;

	assign SZCV[3] = data[15];
	assign SZCV[2] = (data[15:0] == 16'h0000);

endmodule
