module registerFile (
	input clock,//p1を接続
	input [2:0] Rs, Rd,
	input regWrite,
	input [15:0] writeData,
	input [2:0] writeRegister,
	output [15:0] AR, BR
);


	
	reg [15:0] r [7:0];

	function [15:0] READ_REG;
	input [2:0] REG_NUM;
		begin
			case (REG_NUM)
				3'b000: READ_REG = r[0]; 
				3'b001: READ_REG = r[1];
				3'b010: READ_REG = r[2];
				3'b011: READ_REG = r[3];
				3'b100: READ_REG = r[4];
				3'b101: READ_REG = r[5];
				3'b110: READ_REG = r[6];
				3'b111: READ_REG = r[7];
			endcase
		end
	endfunction
	
	assign AR = READ_REG(Rs);
	assign BR = READ_REG(Rd);
		
	always @ (posedge clock) begin
		if(regWrite == 1'b1) begin
			case (writeRegister)
				3'b000: r[0] <= writeData; 
				3'b001: r[1] <= writeData;
				3'b010: r[2] <= writeData;
				3'b011: r[3] <= writeData;
				3'b100: r[4] <= writeData;
				3'b101: r[5] <= writeData;
				3'b110: r[6] <= writeData;
				3'b111: r[7] <= writeData;
			endcase
		end
	end
	
	
	


endmodule
