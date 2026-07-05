//==================================================
// 4-to-1 Multiplexer | Structural 
//
// sel = 00 -> y = a
// sel = 01 -> y = b
// sel = 10 -> y = c
// sel = 11 -> y = d
//
//==================================================

module mux4_structural (
	input  logic a,
	input  logic b,
	input  logic c,
	input  logic d,
	input  logic [1:0] sel,
	output logic y
	);
	
	// wires for 2 mux2 outputs
	logic w0;
	logic w1;
	
	// 1st mux2 instance, 1st pair of inputs (a,b)
	mux2 muxa(
		.a(a),
		.b(b),
		.sel(sel[0]),
		.y(w0)
	);
	
	// 2nd mux2 instance, 2nd pair of inputs (c,d)
	mux2 muxb(
		.a(c),
		.b(d),
		.sel(sel[0]),
		.y(w1)
	);
	
	// 3rd mux2 instance, select muxa or muxb
	mux2 muxc(
		.a(w0),
		.b(w1),
		.sel(sel[1]),
		.y(y)
	);
		
endmodule
