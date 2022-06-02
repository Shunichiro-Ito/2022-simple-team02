module MEMWBRegister (
	// input ALUSrcAR_MEM,
	// input [3:0] ALUOp_MEM,
	// input DRSrc_MEM,
	// input outputEnable_MEM,
	// input SZCVSrc_MEM,
	// input memRead_MEM,
	// input inputEnable_MEM,
	// input memWrite_MEM,
	// input branch_MEM,
	input regWrite_MEM, 
	input memToReg_MEM,
	input changeEnable,
	input reset,
	input clock,
	// output reg ALUSrcAR_WB,
	// output reg [3:0] ALUOp_WB,
	// output reg DRSrc_WB,
	// output reg outputEnable_WB,
	// output reg SZCVSrc_WB,
	// output reg memRead_WB,
	// output reg inputEnable_WB,
	// output reg memWrite_WB,
	// output reg branch_WB,
	output reg regWrite_WB, 
	output reg memToReg_WB );

    always @(posedge clock) begin
        if (reset) begin 
            // ALUSrcAR_WB <= 1'b 0;
            // ALUOp_WB <= 4'b 0000;
            // DRSrc_WB <= 1'b 0;
            // outputEnable_WB <= 1'b 0;//critical
            // SZCVSrc_WB <= 1'b 0;
            // memRead_WB <= 1'b 0;//critical
            // inputEnable_WB <= 1'b 0;//critical?
            // memWrite_WB <= 1'b 0;//critical
            // branch_WB <= 1'b 0;//critical
            regWrite_WB <= 1'b 0;//critical
            memToReg_WB <= 1'b 0;
        end else begin
           if(changeEnable) begin
                // ALUSrcAR_WB <= ALUSrcAR_MEM;
                // ALUOp_WB <= ALUOp_MEM;
                // DRSrc_WB <= DRSrc_MEM;
                // outputEnable_WB <= outputEnable_MEM;
                // SZCVSrc_WB <= SZCVSrc_MEM;
                // memRead_WB <= memRead_MEM;
                // inputEnable_WB <= inputEnable_MEM;
                // memWrite_WB <= memWrite_MEM;
                // branch_WB <= branch_MEM;
                regWrite_WB <= regWrite_MEM;
                memToReg_WB <= memToReg_MEM;
           end 
        end
    end

endmodule