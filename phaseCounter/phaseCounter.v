module phaseCounter (
	input clock,
	input reset,
	output p1,p2,p3,p4,p5//各フェーズの立ち上がりの信号（マスター・スレーブ方式により、半周期ずれている）
);

	//dffをマスター・スレーブ方式にする
	reg p1_master, p2_master, p3_master, p4_master, p5_master;
	reg p1_slave, p2_slave, p3_slave, p4_slave, p5_slave;

	wire not_reset;
	assign not_reset = ~reset;
	
	always @ (posedge clock) begin 
		p1_master <= p5_slave | reset;
		p2_master <= p1_slave & not_reset;
		p3_master <= p2_slave & not_reset;
		p4_master <= p3_slave & not_reset;
		p5_master <= p4_slave & not_reset;
		
	end

	always @ (negedge clock) begin
		p1_slave <= p1_master;
		p2_slave <= p2_master;
		p3_slave <= p3_master;
		p4_slave <= p4_master;
		p5_slave <= p5_master;
	end
	
	assign p1 = p1_master;
	assign p2 = p2_master;
	assign p3 = p3_master;
	assign p4 = p4_master;
	assign p5 = p5_master;
	
endmodule
