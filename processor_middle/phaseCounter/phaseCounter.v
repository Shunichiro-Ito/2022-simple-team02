module phaseCounter (
	input clock,
	input reset,
	input changeEnable,
	output p1,p2,p3,p3to4,p4,p5//各フェーズの立ち上がりの信号（マスター・スレーブ方式により、半周期ずれている）
);

	//dffをマスター・スレーブ方式にする
	reg p1_master, p2_master, p3_master, p4_master, p5_master;
	reg p1_slave, p2_slave, p3_slave, p4_slave, p5_slave;

	wire not_reset;
	assign not_reset = ~reset;
	
	always @ (posedge clock) begin 
		if (reset) begin
			p1_master <= 1'b1;
			p2_master <= 1'b0;
			p3_master <= 1'b0;
			p4_master <= 1'b0;
			p5_master <= 1'b0;
		end else begin
			if(changeEnable) begin 
				p1_master <= p5_slave;
				p2_master <= p1_slave;
				p3_master <= p2_slave;
				p4_master <= p3_slave;
				p5_master <= p4_slave;
			end
		end
	end

	always @ (negedge clock) begin
		p1_slave <= p1_master;
		p2_slave <= p2_master;
		p3_slave <= p3_master;
		p4_slave <= p4_master;
		p5_slave <= p5_master;
	end
	
	assign p1 = p1_slave;
	assign p2 = p2_slave;
	assign p3 = p3_slave;
	assign p3to4 = p4_master;
	assign p4 = p4_slave;
	assign p5 = p5_slave;
	
endmodule
