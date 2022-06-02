module PC (
    input [15:0] d,
    input clock,
    input changeEnable,
    input reset,
    output reg [15:0] q
);

    always @(posedge clock) begin
        if(reset) begin
            q <= 16'h 0000;//reset後のPCの初期値
        end else begin
            if(changeEnable) begin
                q <= d;
            end
        end
    end    

endmodule