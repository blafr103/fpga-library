//==================================================
// 4-to-1 Multiplexer | Behavioral 
//
// sel = 00 -> e = a
// sel = 01 -> e = b
// sel = 10 -> e = c
// sel = 11 -> e = d
//
//==================================================

module mux4_behavioral(
	input  logic a,
	input  logic b,
	input  logic c,
	input  logic d,
	input  logic [1:0] sel,
	output logic y
	);
	
	always_comb begin
		case(sel)
			2'b00 : y = a;
			2'b01 : y = b;
			2'b10 : y = c;
			2'b11 : y = d;
			default : y = 0;
		endcase
	end
	
endmodule