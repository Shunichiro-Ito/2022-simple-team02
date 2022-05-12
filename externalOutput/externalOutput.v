module externalOutput(input outputEnable,clock,reset,changeEnable,
                    input [15:0] AR,
                    output reg [7:0] SEG_A,SEG_B,SEG_C,SEG_D,SEG_E,SEG_F,SEG_G,SEG_H,select);

    reg [15:0] regA,regB,regC,regD,regE,regF,regG,regH,regI,regJ,regK,regL,regM,regN,regO,regP;
    reg [4:0] pattern;

    initial begin 
        regP <= 16'b0000_0000_0000_0000;
        regO <= 16'b0000_0000_0000_0000;
        regN <= 16'b0000_0000_0000_0000;
        regM <= 16'b0000_0000_0000_0000;
        regL <= 16'b0000_0000_0000_0000;
        regK <= 16'b0000_0000_0000_0000;
        regJ <= 16'b0000_0000_0000_0000;
        regI <= 16'b0000_0000_0000_0000;
        regH <= 16'b0000_0000_0000_0000;
        regG <= 16'b0000_0000_0000_0000;
        regF <= 16'b0000_0000_0000_0000;
        regE <= 16'b0000_0000_0000_0000;
        regD <= 16'b0000_0000_0000_0000;
        regC <= 16'b0000_0000_0000_0000;
        regB <= 16'b0000_0000_0000_0000;
        regA <= 16'b0000_0000_0000_0000;
        pattern = 3'b000;
    end
    
    function [7:0] outFunc;
	input [3:0] a;
		begin
			case (a)
			4'b0000:outFunc = 8'b1111_1100;
			4'b0001:outFunc = 8'b0110_0000;
			4'b0010:outFunc = 8'b1101_1010;
			4'b0011:outFunc = 8'b1111_0010;
			4'b0100:outFunc = 8'b0110_0110;
			4'b0101:outFunc = 8'b1011_0110;
			4'b0110:outFunc = 8'b1011_1110;
			4'b0111:outFunc = 8'b1110_0000;
			4'b1000:outFunc = 8'b1111_1110;
			4'b1001:outFunc = 8'b1111_0110;
			4'b1010:outFunc = 8'b1110_1110;
			4'b1011:outFunc = 8'b0011_1110;
			4'b1100:outFunc = 8'b0001_1010;
			4'b1101:outFunc = 8'b0111_1010;
			4'b1110:outFunc = 8'b1001_1110;
			4'b1111:outFunc = 8'b1000_1110;
			default:outFunc = 8'b0000_0000;
			endcase
		end
	endfunction	

    function [7:0] outFinalFunc;
	input [3:0] b;
		begin
			case (b)
			4'b0000:outFinalFunc = 8'b1111_1101;
			4'b0001:outFinalFunc = 8'b0110_0001;
			4'b0010:outFinalFunc = 8'b1101_1011;
			4'b0011:outFinalFunc = 8'b1111_0011;
			4'b0100:outFinalFunc = 8'b0110_0111;
			4'b0101:outFinalFunc = 8'b1011_0111;
			4'b0110:outFinalFunc = 8'b1011_1111;
			4'b0111:outFinalFunc = 8'b1110_0001;
			4'b1000:outFinalFunc = 8'b1111_1111;
			4'b1001:outFinalFunc = 8'b1111_0111;
			4'b1010:outFinalFunc = 8'b1110_1111;
			4'b1011:outFinalFunc = 8'b0011_1111;
			4'b1100:outFinalFunc = 8'b0001_1011;
			4'b1101:outFinalFunc = 8'b0111_1011;
			4'b1110:outFinalFunc = 8'b1001_1111;
			4'b1111:outFinalFunc = 8'b1000_1111;
			default:outFinalFunc = 8'b0000_0001;
			endcase
		end
	endfunction	

    always@(posedge clock) begin
        if(pattern == 5'b00000) begin
            SEG_A <= outFunc(regA[15:12]);
            SEG_B <= outFunc(regA[11:8]);
            SEG_C <= outFunc(regA[7:4]);
            SEG_D <= outFinalFunc(regA[3:0]);
            SEG_E <= outFunc(regE[15:12]);
            SEG_F <= outFunc(regE[11:8]);
            SEG_G <= outFunc(regE[7:4]);
            SEG_H <= outFinalFunc(regE[3:0]);
        end else if(pattern == 5'b00001) begin 
            select <= 8'b1000_0000;
        end else if(pattern == 5'b00011) begin 
            select <= 8'b0000_0000;
        end else if(pattern == 5'b00100) begin
            SEG_A <= outFunc(regB[15:12]);
            SEG_B <= outFunc(regB[11:8]);
            SEG_C <= outFunc(regB[7:4]);
            SEG_D <= outFinalFunc(regB[3:0]);
            SEG_E <= outFunc(regF[15:12]);
            SEG_F <= outFunc(regF[11:8]);
            SEG_G <= outFunc(regF[7:4]);
            SEG_H <= outFinalFunc(regF[3:0]);
        end else if(pattern == 5'b00101) begin 
            select <= 8'b0100_0000;
        end else if(pattern == 5'b00111) begin 
            select <= 8'b0000_0000;
        end else if(pattern == 5'b01000) begin
            SEG_A <= outFunc(regC[15:12]);
            SEG_B <= outFunc(regC[11:8]);
            SEG_C <= outFunc(regC[7:4]);
            SEG_D <= outFinalFunc(regC[3:0]);
            SEG_E <= outFunc(regG[15:12]);
            SEG_F <= outFunc(regG[11:8]);
            SEG_G <= outFunc(regG[7:4]);
            SEG_H <= outFinalFunc(regG[3:0]);
        end else if(pattern == 5'b01001) begin 
            select <= 8'b0010_0000;
        end else if(pattern == 5'b01011) begin 
            select <= 8'b0000_0000;
        end else if(pattern == 5'b01100) begin
            SEG_A <= outFunc(regD[15:12]);
            SEG_B <= outFunc(regD[11:8]);
            SEG_C <= outFunc(regD[7:4]);
            SEG_D <= outFinalFunc(regD[3:0]);
            SEG_E <= outFunc(regH[15:12]);
            SEG_F <= outFunc(regH[11:8]);
            SEG_G <= outFunc(regH[7:4]);
            SEG_H <= outFinalFunc(regH[3:0]);
        end else if(pattern == 5'b01101) begin 
            select <= 8'b0001_0000;
        end else if(pattern == 5'b01111) begin 
            select <= 8'b0000_0000;
        end else if(pattern == 5'b10000) begin
            SEG_A <= outFunc(regI[15:12]);
            SEG_B <= outFunc(regI[11:8]);
            SEG_C <= outFunc(regI[7:4]);
            SEG_D <= outFinalFunc(regI[3:0]);
            SEG_E <= outFunc(regM[15:12]);
            SEG_F <= outFunc(regM[11:8]);
            SEG_G <= outFunc(regM[7:4]);
            SEG_H <= outFinalFunc(regM[3:0]);
        end else if(pattern == 5'b10001) begin 
            select <= 8'b0000_1000;
        end else if(pattern == 5'b10011) begin 
            select <= 8'b0000_0000;
        end else if(pattern == 5'b10100) begin
            SEG_A <= outFunc(regJ[15:12]);
            SEG_B <= outFunc(regJ[11:8]);
            SEG_C <= outFunc(regJ[7:4]);
            SEG_D <= outFinalFunc(regJ[3:0]);
            SEG_E <= outFunc(regN[15:12]);
            SEG_F <= outFunc(regN[11:8]);
            SEG_G <= outFunc(regN[7:4]);
            SEG_H <= outFinalFunc(regN[3:0]);
        end else if(pattern == 5'b10101) begin 
            select <= 8'b0000_0100;
        end else if(pattern == 5'b10111) begin 
            select <= 8'b0000_0000;
        end else if(pattern == 5'b11000) begin
            SEG_A <= outFunc(regK[15:12]);
            SEG_B <= outFunc(regK[11:8]);
            SEG_C <= outFunc(regK[7:4]);
            SEG_D <= outFinalFunc(regK[3:0]);
            SEG_E <= outFunc(regO[15:12]);
            SEG_F <= outFunc(regO[11:8]);
            SEG_G <= outFunc(regO[7:4]);
            SEG_H <= outFinalFunc(regO[3:0]);
        end else if(pattern == 5'b11001) begin 
            select <= 8'b0000_0010;
        end else if(pattern == 5'b11011) begin 
            select <= 8'b0000_0000;
        end else if(pattern == 5'b11100) begin
            SEG_A <= outFunc(regL[15:12]);
            SEG_B <= outFunc(regL[11:8]);
            SEG_C <= outFunc(regL[7:4]);
            SEG_D <= outFinalFunc(regL[3:0]);
            SEG_E <= outFunc(regP[15:12]);
            SEG_F <= outFunc(regP[11:8]);
            SEG_G <= outFunc(regP[7:4]);
            SEG_H <= outFinalFunc(regP[3:0]);
        end else if(pattern == 5'b11101) begin 
            select <= 8'b0000_0001;
        end else if(pattern == 5'b11111) begin 
            select <= 8'b0000_0000;
        end 
        
        pattern <= pattern + 1;
                    
        if(reset) begin
            regP <= 16'b0000_0000_0000_0000;
            regO <= 16'b0000_0000_0000_0000;
            regN <= 16'b0000_0000_0000_0000;
            regM <= 16'b0000_0000_0000_0000;
            regL <= 16'b0000_0000_0000_0000;
            regK <= 16'b0000_0000_0000_0000;
            regJ <= 16'b0000_0000_0000_0000;
            regI <= 16'b0000_0000_0000_0000;
            regH <= 16'b0000_0000_0000_0000;
            regG <= 16'b0000_0000_0000_0000;
            regF <= 16'b0000_0000_0000_0000;
            regE <= 16'b0000_0000_0000_0000;
            regD <= 16'b0000_0000_0000_0000;
            regC <= 16'b0000_0000_0000_0000;
            regB <= 16'b0000_0000_0000_0000;
            regA <= 16'b0000_0000_0000_0000;
        end else begin
            if(changeEnable) begin
                if(outputEnable) begin
                    regP <= regO;
                    regO <= regN;
                    regN <= regM;
                    regM <= regL;
                    regL <= regK;
                    regK <= regJ;
                    regJ <= regI;
                    regI <= regH;
                    regH <= regG;
                    regG <= regF;
                    regF <= regE;
                    regE <= regD;
                    regD <= regC;
                    regC <= regB;
                    regB <= regA;
                    regA <= AR;
                end
            end
        end
    end
endmodule