//==================================================
// Magnitude Comparator | unsigned, parameterized width
//
// gt = 1 when a > b
// eq = 1 when a == b
// lt = 1 when a < b
// exactly one output is high for any a, b
//==================================================

// override parameterized width at instantiation with comparator #(.WIDTH(4)) cmp (...);
module comparator #(parameter int WIDTH = 8)(
	input  logic [WIDTH-1:0] a,
	input  logic [WIDTH-1:0] b,
	output logic             gt,
	output logic             eq,
	output logic             lt
	);

	assign gt = (a > b);
	assign eq = (a == b);
	assign lt = (a < b);

endmodule