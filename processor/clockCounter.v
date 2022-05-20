module clockCounter(
    input [15:0] instruction,
    input systemRunning,clock,reset,
    output reg [7:0] SEG_X,SEG_Y,
    output reg [3:0] selectX,selectY);


    reg [31:0] counter;
    reg start;
    reg stop;
    reg [2:0] pattern1,pattern2;

    always @(posedge clock) begin
        if(reset) begin
            counter <= 0;
            start <= 1'b0;
            stop <= 1'b0;
        end else begin
           if(systemRunning==1'b1&~start) begin
               start <= 1'b1;
               counter <= counter + 1;
           end else if(({instruction[15:14],instruction[7:4]}==6'b11_1111)&~stop) begin
               stop <= 1'b1;
               counter <= counter + 4;
           end else if(start&~stop) begin
               counter <= counter + 1;
           end
        end

        if (reset) begin
		    selectX <= 4'b0000;
		    pattern1 <= 3'b000;
		    SEG_X <= outFunc(counter[19:16]);
        end else if( pattern1 == 3'b000) begin
            selectX <= 4'b1110;
		    pattern1 <= pattern1 + 1;
        end else if( pattern1 == 3'b001) begin
            selectX <= 4'b1111;
	    	SEG_X <= outFunc(counter[31:28]);
		    pattern1 <= pattern1 + 1;
        end else if( pattern1 == 3'b010) begin
            selectX <= 4'b1101;
		    pattern1 <= pattern1 + 1;
	    end else if( pattern1 == 3'b011) begin
            selectX <= 4'b1111;
		    SEG_X <= outFunc(counter[27:24]);
		    pattern1 <= pattern1 + 1;
	    end else if( pattern1 == 3'b100) begin
            selectX <= 4'b1011;
		    pattern1 <= pattern1 + 1;
	    end else if( pattern1 == 3'b101) begin
            selectX <= 4'b1111;
		    SEG_X <= outFunc(counter[23:20]);
		    pattern1 <= pattern1 + 1;
	    end else if( pattern1 == 3'b110) begin
            selectX <= 4'b0111;
		    pattern1 <= pattern1 + 1;
	    end else if( pattern1 == 3'b111) begin
            selectX <= 4'b1111;
		    SEG_X <= outFunc(counter[19:16]);
		    pattern1 <= pattern1 + 1;
        end

        if (reset) begin
		    selectY <= 4'b0000;
		    pattern2 <= 3'b000;
		    SEG_Y <= outFunc(counter[3:0]);
        end else if( pattern2 == 3'b000) begin
            selectY <= 4'b1110;
		    pattern2 <= pattern2 + 1;
        end else if( pattern2 == 3'b001) begin
            selectY <= 4'b1111;
	    	SEG_Y <= outFunc(counter[15:12]);
		    pattern2 <= pattern2 + 1;
        end else if( pattern2 == 3'b010) begin
            selectY <= 4'b1101;
		    pattern2 <= pattern2 + 1;
	    end else if( pattern2 == 3'b011) begin
            selectY <= 4'b1111;
		    SEG_Y <= outFunc(counter[11:8]);
		    pattern2 <= pattern2 + 1;
	    end else if( pattern2 == 3'b100) begin
            selectY <= 4'b1011;
		    pattern2 <= pattern2 + 1;
	    end else if( pattern2 == 3'b101) begin
            selectY <= 4'b1111;
		    SEG_Y <= outFunc(counter[7:4]);
		    pattern2 <= pattern2 + 1;
	    end else if( pattern2 == 3'b110) begin
            selectY <= 4'b0111;
		    pattern2 <= pattern2 + 1;
	    end else if( pattern2 == 3'b111) begin
            selectY <= 4'b1111;
		    SEG_Y <= outFunc(counter[3:0]);
		    pattern2 <= pattern2 + 1;
        end

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
endmodule