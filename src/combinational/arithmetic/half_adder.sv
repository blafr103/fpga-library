//==================================================
// Half Adder | adds two 1-bit inputs
//
// {carry, sum} = a + b
//
// a b | carry sum
// 0 0 |   0    0
// 0 1 |   0    1
// 1 0 |   0    1
// 1 1 |   1    0
//==================================================

module half_adder(
	input logic a,
	input logic b,
	output logic sum,
	output logic carry
	);
	
	assign sum = a ^ b;		//XOR : 0 when a=b=1 (carry) or a=b=0
	assign carry = a & b;	//AND : 1 when a=b=1
	
endmodule
