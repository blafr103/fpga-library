//==================================================
// 4-to-2 Priority Encoder | highest index wins (3 > 2 > 1 > 0)
//
// a = 1xxx : y = 11, val = 1
// a = 01xx : y = 10, val = 1
// a = 001x : y = 01, val = 1
// a = 0001 : y = 00, val = 1
// a = 0000 : y = 00, val = 0
//==================================================
module priority_encoder4(
	input  logic [3:0] a,
	output logic [1:0] y,
	output logic       val
	);

	always_comb begin
		y   = 2'b00;             // default covers the a=0000 path (no latch)
		val = |a;					 // valid = 1 if any input is set, bitwise OR 
		if      (a[3]) y = 2'b11;
		else if (a[2]) y = 2'b10;
		else if (a[1]) y = 2'b01;
		else if (a[0]) y = 2'b00;
	end

endmodule
