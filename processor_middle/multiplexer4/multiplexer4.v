module multiplexer4 (
    input [3:0] in0,
    input [3:0] in1,
    input selector,
    output [3:0] out);

    wire [3:0] s;

    assign s = {selector,selector,selector,selector};

    assign out = (in1&s) | (in0&~s);

endmodule