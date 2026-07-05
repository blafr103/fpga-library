//==================================================
// Ripple-Carry Adder | parameterized width, structural
//
// {cout, sum} = a + b + cin
// overflow = signed (two's complement) overflow flag
//==================================================
module ripple_adder #(parameter int WIDTH = 8)(
	input  logic [WIDTH-1:0] a,
	input  logic [WIDTH-1:0] b,
	input  logic             cin,
	output logic [WIDTH-1:0] sum,
	output logic             cout,
	output logic             overflow
	);

	// carry chain: one more wire than there are stages
	// carry[0] is cin, carry[WIDTH] is the final cout
	logic [WIDTH:0] carry;

	assign carry[0] = cin;

	genvar i;
	generate
		for (i = 0; i < WIDTH; i++) begin : adder_stage
			full_adder fa(
				.a    (a[i]),
				.b    (b[i]),
				.cin  (carry[i]),
				.sum  (sum[i]),
				.cout (carry[i+1])
			);
		end
	endgenerate

	assign cout     = carry[WIDTH];
	assign overflow = carry[WIDTH] ^ carry[WIDTH-1];

endmodule
