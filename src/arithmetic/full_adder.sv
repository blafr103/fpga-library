//==================================================
// Full Adder | adds two 1-bit inputs + carry in
//
// {cout, sum} = a + b + cin
//
// a b  cin  | cout  sum
// 0 0 	0	 |   0    0
// 0 1 	0	 |   0    1
// 1 0 	0	 |   0    1
// 1 1 	0	 |   1    0
// 0 0 	1	 |   0    1
// 0 1 	1	 |   1    0
// 1 0 	1	 |   1    0
// 1 1 	1	 |   1    1
//
//==================================================

module full_adder(
	input  logic a,
	input  logic b,
	input  logic cin,
	output logic sum,
	output logic cout
	);
	
	// parity: the sum bit is 1 when an odd number of the three inputs are 1
	assign sum  = a ^ b ^ cin;
	// majority: carry out when at least two of the three inputs are 1
	assign cout = (a & b) | (cin & (a ^ b));
	
endmodule
