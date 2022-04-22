module alu(input [15:0] inA,inB,
        	input [3:0] op,
        	output [15:0] out, 
			output [3:0] SZCV);
		wire [16:0] signExtendedInA;
    	wire [16:0] signExtendedInB;
		wire [16:0] negativeInB;
	   
	    assign signExtendedInA = {inA [15], inA};
        assign signExtendedInB = {inB [15], inB};
		assign negativeInB = ((~signExtendedInB) + 1);
		
		assign {SZCV,out} = OUT(signExtendedInA,signExtendedInB,op,negativeInB);

		function [19:0] OUT;//OUT={S,Z,C,V,out}
		   input [16:0] IN_A;
		   input [16:0] IN_B;
		   input [3:0] OP;
		   input [16:0] NEGATIVE_IN_B;

		   begin
			case (OP)
				4'b0000:begin//ADD
						{OUT[17],OUT[15:0]} = IN_A + IN_B;
				      OUT[16] = (IN_A[15]&IN_B[15]&~OUT[15])|(~IN_A[15]&~IN_B[15]&OUT[15]);
						OUT[18] = (OUT[15:0] == 0);//Z
						OUT[19] = OUT[15];//S
						end
				4'b0001:begin//SUB
						{OUT[17],OUT[15:0]} = IN_A + NEGATIVE_IN_B;
					   OUT[16] = (IN_A[15]&NEGATIVE_IN_B[15]&~OUT[15])|(~IN_A[15]&~NEGATIVE_IN_B[15]&OUT[15]);
						OUT[18] = (OUT[15:0] == 0);//Z
						OUT[19] = OUT[15];//S
						end
				4'b0010:begin//AND
						OUT[15:0] = IN_A [15:0] & IN_B[15:0];
						OUT[16] = 1'b0;
						OUT[17] = 1'b0;
						OUT[18] = (OUT[15:0] == 0);//Z
						OUT[19] = OUT[15];//S
						end
				4'b0011:begin//OR
						OUT[15:0] = IN_A [15:0] | IN_B[15:0];
						OUT[16] = 1'b0;
						OUT[17] = 1'b0;
						OUT[18] = (OUT[15:0] == 0);//Z
						OUT[19] = OUT[15];//S
						end
				4'b0100:begin//XOR
						OUT[15:0] = IN_A [15:0] ^ IN_B[15:0];
						OUT[16] = 1'b0;
						OUT[17] = 1'b0;
						OUT[18] = (OUT[15:0] == 0);//Z
						OUT[19] = OUT[15];//S
						end
				4'b0101:begin//CMP
						{OUT[17],OUT[15:0]} = IN_A + NEGATIVE_IN_B;
						OUT[16] = (IN_A[15]&NEGATIVE_IN_B[15]&~OUT[15])|(~IN_A[15]&~NEGATIVE_IN_B[15]&OUT[15]);
				 		OUT[18] = (OUT[15:0] == 0);//Z
						OUT[19] = OUT[15];//S       
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
						OUT[15:0] = 16'b0000_0000_0000_0000;
						OUT[16] = 1'b0;
						OUT[17] = 1'b0;
						OUT[18] = 1'b0;
						OUT[19] = 1'b0;
						end
				4'b1001:begin//SLR
						OUT[15:0] = 16'b0000_0000_0000_0000;
						OUT[16] = 1'b0;
						OUT[17] = 1'b0;
						OUT[18] = 1'b0;
						OUT[19] = 1'b0;
						end
				4'b1010:begin//SRL
						OUT[15:0] = 16'b0000_0000_0000_0000;
						OUT[16] = 1'b0;
						OUT[17] = 1'b0;
						OUT[18] = 1'b0;
						OUT[19] = 1'b0;
						end
				4'b1011:begin//SRA
						OUT[15:0] = 16'b0000_0000_0000_0000;
						OUT[16] = 1'b0;
						OUT[17] = 1'b0;
						OUT[18] = 1'b0;
						OUT[19] = 1'b0;
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