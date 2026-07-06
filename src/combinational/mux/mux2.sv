//==================================================
// 2-to-1 Multiplexer
//
// sel = 0 -> y = a
// sel = 1 -> y = b
//==================================================

module mux2(
	input  logic a,
	input  logic b,
	input  logic sel,
	output logic y
	);
	
	assign y = (sel) ? b : a;
	
endmodule
