module EXMEMRegister (
	// input ALUSrcAR_EX,
	// input [3:0] ALUOp_EX,
	// input DRSrc_EX,
	// input outputEnable_EX,
	// input SZCVSrc_EX,
	input memRead_EX,
	input inputEnable_EX,
	input memWrite_EX,
	input branch_EX,
	input regWrite_EX, 
	input memToReg_EX,
	input changeEnable,
	input reset,
	input clock,
	// output reg ALUSrcAR_MEM,
	// output reg [3:0] ALUOp_MEM,
	// output reg DRSrc_MEM,
	// output reg outputEnable_MEM,
	// output reg SZCVSrc_MEM,
	output reg memRead_MEM,
	output reg inputEnable_MEM,
	output reg memWrite_MEM,
	output reg branch_MEM,
	output reg regWrite_MEM, 
	output reg memToReg_MEM );

    always @(posedge clock) begin
        if (reset) begin 
            // ALUSrcAR_MEM <= 1'b 0;
            // ALUOp_MEM <= 4'b 0000;
            // DRSrc_MEM <= 1'b 0;
            // outputEnable_MEM <= 1'b 0;//critical
            // SZCVSrc_MEM <= 1'b 0;
            memRead_MEM <= 1'b 0;//critical
            inputEnable_MEM <= 1'b 0;//critical?
            memWrite_MEM <= 1'b 0;//critical
            branch_MEM <= 1'b 0;//critical
            regWrite_MEM <= 1'b 0;//critical
            memToReg_MEM <= 1'b 0;
        end else begin
           if(changeEnable) begin
                // ALUSrcAR_MEM <= ALUSrcAR_EX;
                // ALUOp_MEM <= ALUOp_EX;
                // DRSrc_MEM <= DRSrc_EX;
                // outputEnable_MEM <= outputEnable_EX;
                // SZCVSrc_MEM <= SZCVSrc_EX;
                memRead_MEM <= memRead_EX;
                inputEnable_MEM <= inputEnable_EX;
                memWrite_MEM <= memWrite_EX;
                branch_MEM <= branch_EX;
                regWrite_MEM <= regWrite_EX;
                memToReg_MEM <= memToReg_EX;
           end 
        end
    end

endmodule