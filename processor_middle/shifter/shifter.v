module shifter(input [15:0] BR,
            input [3:0] d,
        	input [3:0] op,
        	output [15:0] out, 
			output [3:0] SZCV);
        wire [15:0] signExtendedD;
		wire [15:0] d_SLL_S;
		wire [31:0] doubleBR;
		wire [31:0] shiftedBR_SLR;
		wire [31:0] extendedBR;
		wire [31:0] shiftedBR_SRA;
		
        assign signExtendedD = {{12{1'b0}}, d};
		assign d_SLL_S = 16'b0000_0000_0001_0000 - d;
		assign doubleBR = {BR,BR};
		assign shiftedBR_SLR = doubleBR << d;
		assign extendedBR = {{16{BR[15]}}, BR};
		assign shiftedBR_SRA = extendedBR >> d;
		
		assign {SZCV,out} = OUT(BR,signExtendedD,op,d_SLL_S,shiftedBR_SLR,shiftedBR_SRA);

		function [19:0] OUT;//OUT={S,Z,C,V,out}
		   input [15:0] BR_PARAM;
		   input [15:0] D;
		   input [3:0] OP;
		   input [15:0] D_SLL_S;
		   input [31:0] BR_SLR;
		   input [31:0] BR_SRA;

		   begin
			case (OP)
				4'b0000:begin//ADD
						OUT[15:0] = 16'b0000_0000_0000_0000;
						OUT[16] = 1'b0;
						OUT[17] = 1'b0;
						OUT[18] = 1'b0;
						OUT[19] = 1'b0;
						end
				4'b0001:begin//SUB
						OUT[15:0] = 16'b0000_0000_0000_0000;
						OUT[16] = 1'b0;
						OUT[17] = 1'b0;
						OUT[18] = 1'b0;
						OUT[19] = 1'b0;
						end
				4'b0010:begin//AND
						OUT[15:0] = 16'b0000_0000_0000_0000;
						OUT[16] = 1'b0;
						OUT[17] = 1'b0;
						OUT[18] = 1'b0;
						OUT[19] = 1'b0;
						end
				4'b0011:begin//OR
						OUT[15:0] = 16'b0000_0000_0000_0000;
						OUT[16] = 1'b0;
						OUT[17] = 1'b0;
						OUT[18] = 1'b0;
						OUT[19] = 1'b0;
						end
				4'b0100:begin//XOR
						OUT[15:0] = 16'b0000_0000_0000_0000;
						OUT[16] = 1'b0;
						OUT[17] = 1'b0;
						OUT[18] = 1'b0;
						OUT[19] = 1'b0;
						end
				4'b0101:begin//CMP
						OUT[15:0] = 16'b0000_0000_0000_0000;
						OUT[16] = 1'b0;
						OUT[17] = 1'b0;
						OUT[18] = 1'b0;
						OUT[19] = 1'b0;
						end
				4'b0110:begin//MOV
						OUT[15:0] = 16'b0000_0000_0000_0000;
						OUT[16] = 1'b0;
						OUT[17] = 1'b0;
						OUT[18] = 1'b0;
						OUT[19] = 1'b0;
						end
				4'b0111:begin//(reserved)
						OUT[15:0] = 16'b0000_0000_0000_0000;
						OUT[16] = 1'b0;
						OUT[17] = 1'b0;
						OUT[18] = 1'b0;
						OUT[19] = 1'b0;
						end
				4'b1000:begin//SLL
						OUT[15:0] = BR_PARAM << D;//out
						OUT[16] = 1'b0;//V
							if(D==0) begin
                                OUT[17] = 1'b0;
                            end else begin
                                OUT[17] = BR_PARAM[D_SLL_S];//C
                            end
						OUT[18] = (OUT[15:0] == 0);//Z
                        OUT[19] = OUT[15];//S
						end
				4'b1001:begin//SLR
						OUT[15:0] = BR_SLR[31:16];
						OUT[16] = 1'b0;//V
						OUT[17] = 1'b0;//C
						OUT[18] = (OUT[15:0] == 0);//Z
						OUT[19] = OUT[15];//S
						end
				4'b1010:begin//SRL
						OUT[15:0] = BR_PARAM >> D;
						OUT[16] = 1'b0;//V
							if(D==0) begin
                                OUT[17] = 1'b0;
                            end else begin
                                OUT[17] = BR_PARAM[D-1];//C
                            end
						OUT[18] = (OUT[15:0] == 0);//Z
						OUT[19] = OUT[15];//S
						end
				4'b1011:begin//SRA
						OUT[15:0] = BR_SRA[15:0];
						OUT[16] = 1'b0;//V
							if(D==0) begin
                                OUT[17] = 1'b0;
                            end else begin
                                OUT[17] = BR_PARAM[D-1];//C
                            end
						OUT[18] = (OUT[15:0] == 0);//Z
						OUT[19] = OUT[15];//S
						end
				4'b1100:begin//IN
						OUT[15:0] = 16'b0000_0000_0000_0000;
						OUT[16] = 1'b0;
						OUT[17] = 1'b0;
						OUT[18] = 1'b0;
						OUT[19] = 1'b0;
						end
				4'b1101:begin//OUT
						OUT[15:0] = 16'b0000_0000_0000_0000;
						OUT[16] = 1'b0;
						OUT[17] = 1'b0;
						OUT[18] = 1'b0;
						OUT[19] = 1'b0;
						end
				4'b1110:begin//(reserved)
						OUT[15:0] = 16'b0000_0000_0000_0000;
						OUT[16] = 1'b0;
						OUT[17] = 1'b0;
						OUT[18] = 1'b0;
						OUT[19] = 1'b0;
						end
				4'b1111:begin//halt()
						OUT[15:0] = 16'b0000_0000_0000_0000;
						OUT[16] = 1'b0;
						OUT[17] = 1'b0;
						OUT[18] = 1'b0;
						OUT[19] = 1'b0;
						end
				endcase
			end
		endfunction
endmodule