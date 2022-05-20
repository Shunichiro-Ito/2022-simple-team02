module multiplexer3 (
    input [2:0] in0,
    input [2:0] in1,
    input selector,
    output [2:0] out);

    wire [2:0] s;

    assign s = {selector,selector,selector};

    assign out = (in1&s) | (in0&~s);

endmodule