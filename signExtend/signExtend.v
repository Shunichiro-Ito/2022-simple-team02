module signExtend (
    input [7:0] in,
    output [15:0] out
) ;

assign out = {in[7],in[7],in[7],in[7],in[7],in[7],in[7],in[7],in[7:0]};

endmodule