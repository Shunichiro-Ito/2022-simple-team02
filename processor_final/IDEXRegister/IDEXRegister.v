module IDEXRegister (
	input ALUSrcAR_ID,
	input [3:0] ALUOp_ID,
	input DRSrc_ID,
	input outputEnable_ID,
	input SZCVSrc_ID,
	input memRead_ID,
	input inputEnable_ID,
	input memWrite_ID,
	input branch_ID,
	input regWrite_ID, 
	input memToReg_ID,
	input IDFlush,
	input changeEnable,
	input reset,
	input clock,
	output reg ALUSrcAR_EX,
	output reg [3:0] ALUOp_EX,
	output reg DRSrc_EX,
	output reg outputEnable_EX,
	output reg SZCVSrc_EX,
	output reg memRead_EX,
	output reg inputEnable_EX,
	output reg memWrite_EX,
	output reg branch_EX,
	output reg regWrite_EX, 
	output reg memToReg_EX );

    always @(posedge clock) begin
        if (reset) begin 
            ALUSrcAR_EX <= 1'b 0;
            ALUOp_EX <= 4'b 0000;
            DRSrc_EX <= 1'b 0;
            outputEnable_EX <= 1'b 0;//critical
            SZCVSrc_EX <= 1'b 0;
            memRead_EX <= 1'b 0;//critical
            inputEnable_EX <= 1'b 0;//critical?
            memWrite_EX <= 1'b 0;//critical
            branch_EX <= 1'b 0;//critical
            regWrite_EX <= 1'b 0;//critical
            memToReg_EX <= 1'b 0;
        end else if (IDFlush) begin
            ALUSrcAR_EX <= 1'b 0;
            ALUOp_EX <= 4'b 0000;
            DRSrc_EX <= 1'b 0;
            outputEnable_EX <= 1'b 0;//critical
            SZCVSrc_EX <= 1'b 0;
            memRead_EX <= 1'b 0;//critical
            inputEnable_EX <= 1'b 0;//critical?
            memWrite_EX <= 1'b 0;//critical
            branch_EX <= 1'b 0;//critical
            regWrite_EX <= 1'b 0;//critical
            memToReg_EX <= 1'b 0;
        end else begin
           if(changeEnable) begin
                ALUSrcAR_EX <= ALUSrcAR_ID;
                ALUOp_EX <= ALUOp_ID;
                DRSrc_EX <= DRSrc_ID;
                outputEnable_EX <= outputEnable_ID;
                SZCVSrc_EX <= SZCVSrc_ID;
                memRead_EX <= memRead_ID;
                inputEnable_EX <= inputEnable_ID;
                memWrite_EX <= memWrite_ID;
                branch_EX <= branch_ID;
                regWrite_EX <= regWrite_ID;
                memToReg_EX <= memToReg_ID;
           end 
        end
    end

endmodule