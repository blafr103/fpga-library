//==================================================
// 2-to-4 Decoder | Behavioral, active-high, with enable
//
// takes a binary number on the input and asserts the single output whose index equals that number
//
// en = 0        : y = 0000  (all off)
// en = 1, a = 00: y = 0001
// en = 1, a = 01: y = 0010
// en = 1, a = 10: y = 0100
// en = 1, a = 11: y = 1000
//==================================================

module decoder2to4(
	input  logic [1:0] a,
	input  logic en,
	output logic [3:0] y
	);
	
	always_comb begin
		y = 4'b0000;              // default: all outputs off
		if (en) begin
			case(a)
				2'b00 : y = 4'b0001;
				2'b01 : y = 4'b0010;
				2'b10 : y = 4'b0100;
				2'b11 : y = 4'b1000;
			endcase
		end
	end
	
endmodule