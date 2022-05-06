module SZCVControl (
    input [15:0] instruction,
    output [1:0] SZCVSrc
);

    assign SZCVSrc[0] = (({instruction[15:14],instruction[7:5]} == 5'b11_110) //IN,OUT
                        |(instruction[15:14] == 2'b01)//ST
                        |(instruction[15:14] == 2'b10)//LD
                        );

    assign SZCVSrc[1] = (({instruction[15:14],instruction[7:4]} == 6'b11_1101)//OUT
                        |(instruction[15:14] == 2'b01)//ST
                        );

endmodule