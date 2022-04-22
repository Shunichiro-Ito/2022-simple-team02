module control ( 
	input clock,
	input [15:0] instruction,//ほんとは命令の必要な個所のみでよい
	input reset,
	input exec,
	input p1,
	input p2,
	input p3,
	input p4,
	input p5,
	input [3:0] SZCV,
	output updatePC,
	output addressSrc,
	output updateInstruction, //単一サイクル方式のみ使用
	output regDst,
	output updateSZCV, //単一サイクル方式のみ使用
	output ALUSrcAR,
	output ALUSrcBR,
	output [3:0] ALUOp,
	output DRSrc,
	output outputEnable,
	output inputEnable,
	output memWrite,
	output branch,
	output regWrite, // 1 when p5
	output memToReg );
	
	wire S, Z, C, V;
	assign {S,Z,C,V} = SZCV[3:0];

	wire [2:0] cond;
	assign cond = instruction[10:8];
	
	wire [3:0] op;
	assign op = instruction[7:4];

	assign updateInstruction = p1; //単一サイクル方式のみ使用

	assign updateSZCV = p3; //単一サイクル方式のみ使用

	assign updatePC = p5; //単一サイクル方式のみ使用
	

	assign addressSrc = p4;//p1で0,p4で1が必要//主記憶を二つにすれば不要

	assign regDst = p2 & (instruction[15:14] == 2'b00);//LD

	assign ALUSrcAR = p3 & (instruction[15:14]==2'b11);//演算,シフト,IN,OUT,HALTで1

	assign ALUSrcBR = p3 & (instruction[15:14] != 2'b10);//演算、シフト、IO,HALT,LD,STで1

	assign DRSrc = p3 & ({instruction[15:14], instruction[7]}== 3'b11_1);//シフト,IN,OOT,HALTのとき1に設定

	assign outputEnable = p3 & ({instruction[15:14], instruction[7:4]} == 6'b11_1101);//OUT

	assign inputEnable = p4 & ({instruction[15:14], instruction[7:4]} == 6'b11_1100);//IN

	assign memWrite = p4 & (instruction[15:14] == 2'b01); // ST

	assign branch = p4 & (({instruction[15:14],instruction[13:11]} == 5'b10_100) //B
						|(({instruction[15:14],instruction[13:11],instruction[10:8]} == 8'b10_111_000)& Z) //BE
						|(({instruction[15:14],instruction[13:11],instruction[10:8]} == 8'b10_111_001)& (S^V)) //BLT
						|(({instruction[15:14],instruction[13:11],instruction[10:8]} == 8'b10_111_010)& (Z|S^V)) //BLE
						|(({instruction[15:14],instruction[13:11],instruction[10:8]} == 8'b10_111_011)& ~Z) //BNE
						//| ({instruction[15:14], instruction[7,4]} == 6'b11_1111) //HALT
	);

	assign regWrite = p5 & 
					(
						({instruction[15:14],instruction[7]} == 3'b11_0)//演算
						| ({instruction[15:14],instruction[7:6]} == 4'b11_10)//シフト
						| ({instruction[15:14],instruction[7:4]} == 4'b11_1100)//IN
						| (instruction[15:14] == 2'b00) //LD
						| ({instruction[15:14],instruction[13:11]} == 5'b10_000)  //LI 
					);

	assign memToReg = p5 & ( (instruction[15:14] == 2'b00) //LD 
							| ({instruction[15:14], instruction[7:4]} == 6'b11_1100)); //IN

	function [3:0] ALU_OP;
		input [15:0] INSTRUCTION;
		/*if({INSTRUCTION[15:14], INSTRUCTION[7,4]} == 6'b111111)begin ALU_OP[3:0] = 4'b0000 end else */ 
		if(INSTRUCTION[15:14] == 2'b11) begin
			ALU_OP[3:0] = INSTRUCTION[7:4];//命令中のオペコードをそのまま
		end else if({INSTRUCTION[15:14], INSTRUCTION[13:10]} == 5'b10_000) begin
			ALU_OP = 4'b0110; //LIのためのMOV命令
		end else begin 
			ALU_OP = 4'b0000; //アドレス計算のための足し算
		end
	endfunction

	assign ALUOp = ALU_OP(instruction[15:0]);


endmodule



