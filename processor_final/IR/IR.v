module IR (
    input [15:0] d,
    input clock,
    input changeEnable,
    input reset,
    output reg [15:0] q
);

    always @(posedge clock) begin
        if(reset) begin
            q <= 16'b 11_000_000_1110_0000;//reset後のIRの初期値 nopのオペコードの一つ
        end else begin
            if(changeEnable) begin
                q <= d;
            end
        end
    end    

endmodule