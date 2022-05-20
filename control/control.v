module control ( 
	input clock,
	input [15:0] instruction,//ほんとは命令の必要な個所のみでよい
	input reset,
	input exec,
	input [3:0] SZCV,
	output regDst,
	output ALUSrcAR,
	output [3:0] ALUOp,
	output DRSrc,
	output outputEnable,
	output SZCVSrc,
	output memRead,//IN,LDのときpipelineストールを起こすために1
	output inputEnable,
	output memWrite,
	output branch,
	output regWrite, // 1 when p5
	output memToReg ,
	output notReadRsRd,
	output reg systemRunning, 
	output IFFlush,
	output PCWrite);


	reg [15:0] counter;
	reg exec_pre;
	always @(posedge clock) begin
		if(reset) begin
			counter <= 16'h 0000;
			systemRunning <= 1'b 0;
			exec_pre <= exec;
		end else begin
			if ((inputEnable_IDEX & systemRunning/*p3*/)|(halt_MEMWB & systemRunning/*p5*/)) begin 
				systemRunning <= 1'b 0;
			end else begin
				exec_pre <= exec;
				if(exec_pre != exec) begin
					if(counter == 16'h0000) begin
						counter <= 16'h0001;
					end else begin
						counter <= 16'h0000;
					end
				end else begin
					if(counter == 16'h0000) begin
						counter <= 16'h0000;
					end else if(counter == 16'h 000f) begin
						counter <= 16'h0000;
						if(exec == 1'b1) begin
							systemRunning <= ~systemRunning;
						end
					end else begin
						counter <= counter + 16'h0001 ;
					end
				end
			end
		end	


		if(reset) begin
			halt_IDEX <= 1'b 0;
			halt_EXMEM <= 1'b 0;
			halt_MEMWB <= 1'b 0;
			inputEnable_IDEX <= 1'b 0;
		end	else begin
			if(systemRunning) begin
				halt_IDEX <= halt;
				halt_EXMEM <= halt_IDEX;
				halt_MEMWB <= halt_EXMEM;
				inputEnable_IDEX <= inputEnable;
			end
		end
	end

	reg halt_IDEX;
	reg halt_EXMEM;
	reg halt_MEMWB;
	assign IFFlush = halt | halt_IDEX | halt_EXMEM | halt_MEMWB ;
	assign PCWrite = ~( halt | halt_IDEX | halt_EXMEM | halt_MEMWB );
	reg inputEnable_IDEX;


	wire halt;
	assign halt = ({instruction[15:14], instruction[7:4]} == 6'b11_1111);//HALT

	wire S, Z, C, V;
	assign {S,Z,C,V} = SZCV[3:0];

	wire [2:0] cond;
	assign cond = instruction[10:8];
	
	wire [3:0] op;
	assign op = instruction[7:4];

	//p2
	assign notReadRsRd = (({instruction[15:14], instruction[7:5]} == 5'b 11_111)//NOP,HLT
						|({instruction[15:14],instruction[13:11]} == 5'b10_100) //B
						|({instruction[15:14],instruction[13:11],instruction[10]} == 6'b10_111_0) //BE,BLT,BLE,BNE
	);

	//p2
	assign regDst =  (instruction[15:14] == 2'b00);//LD

	//p3
	assign ALUSrcAR =  (instruction[15:14]==2'b11);//演算,シフト,IN,OUT,NOP,HALTで1

	//p3
	assign ALUOp = ALU_OP(instruction[15:0]);
	
	//p3
	assign DRSrc =  ({instruction[15:14], instruction[7]}== 3'b11_1);//シフト,IN,OUT,NOP,HALTのとき1に設定

	//p3
	assign outputEnable =  ({instruction[15:14], instruction[7:4]} == 6'b11_1101);//OUT

	//p3
	assign SZCVSrc = ({instruction[15:14], instruction[7:4]} == 6'b11_1101) //OUT
					|(instruction[15:14] == 2'b01); //ST

	//p4
	assign memRead = (instruction[15:14] == 2'b 00) //LD
					|({instruction[15:14], instruction[7:4]} == 6'b11_1100); //IN

	//p4
	assign inputEnable =  ({instruction[15:14], instruction[7:4]} == 6'b11_1100);//IN

	//p4
	assign memWrite =  (instruction[15:14] == 2'b01); // ST

	//p4
	assign branch =  (({instruction[15:14],instruction[13:11]} == 5'b10_100) //B
						|(({instruction[15:14],instruction[13:11],instruction[10:8]} == 8'b10_111_000)& Z) //BE
						|(({instruction[15:14],instruction[13:11],instruction[10:8]} == 8'b10_111_001)& (S^V)) //BLT
						|(({instruction[15:14],instruction[13:11],instruction[10:8]} == 8'b10_111_010)& (Z|(S^V))) //BLE
						|(({instruction[15:14],instruction[13:11],instruction[10:8]} == 8'b10_111_011)& (~Z)) //BNE
						//| ({instruction[15:14], instruction[7:4]} == 6'b11_1111) //HALT
	);

	//p5
	assign regWrite =  
					(
						({instruction[15:14],instruction[7:6]} == 4'b11_00)//ADD,SUB,AND,OR
						| ({instruction[15:14],instruction[7:6],instruction[4]} == 5'b11_01_0)//XOR,MOV
						| ({instruction[15:14],instruction[7:6]} == 4'b11_10)//シフト
						| ({instruction[15:14],instruction[7:4]} == 6'b11_1100)//IN
						| (instruction[15:14] == 2'b00) //LD
						| ({instruction[15:14],instruction[13:12]} == 4'b10_00)  //LI,ADDI 
					);

	//p5
	assign memToReg =  ( (instruction[15:14] == 2'b00) //LD 
							| ({instruction[15:14], instruction[7:4]} == 6'b11_1100)); //IN

	function [3:0] ALU_OP;
		input [15:0] INSTRUCTION;
		/*if({INSTRUCTION[15:14], INSTRUCTION[7,4]} == 6'b111111)begin ALU_OP[3:0] = 4'b0000 end else */ 
		if(INSTRUCTION[15:14] == 2'b11) begin
			ALU_OP[3:0] = INSTRUCTION[7:4];//命令中のオペコードをそのまま
		end else if({INSTRUCTION[15:14], INSTRUCTION[13:11]} == 5'b10_000) begin
			ALU_OP = 4'b0110; //LIのためのMOV命令
		end else begin 
			ALU_OP = 4'b0000; //アドレス計算,ADDIのための足し算
		end
	endfunction



endmodule



