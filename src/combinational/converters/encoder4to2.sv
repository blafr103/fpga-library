//==================================================
// 4-to-2 Encoder | Behavioral, one-hot input, active-high
//
// takes a one-hot input and produces the 2-bit index of whichever bit is high
//
// a = 0001 : y = 00, val = 1
// a = 0010 : y = 01, val = 1
// a = 0100 : y = 10, val = 1
// a = 1000 : y = 11, val = 1
// a = 0000 : y = 00, val = 0
//==================================================

module encoder4to2(
	input  logic [3:0] a,
	output logic [1:0] y,
	output logic val
	);
	
	always_comb begin
		y = 2'b00;
		val = |a;		// valid = 1 if any input is set, bitwise OR 
		case(a)
			4'b0001 : y = 2'b00;
			4'b0010 : y = 2'b01;
			4'b0100 : y = 2'b10;
			4'b1000 : y = 2'b11;
		endcase
	end
	
endmodule
