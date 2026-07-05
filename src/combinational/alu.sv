// =============================================================================
// Arithmetic Logic Unit (ALU)
//
// Parameterized-width combinational ALU. Operation selected by alu_op.
//
//   ADD  (0000) - a + b
//   SUB  (0001) - a - b
//   AND  (0010) - a & b
//   OR   (0011) - a | b
//   XOR  (0100) - a ^ b
//   SLT  (0101) - set less than, signed   (result = 1 if a < b, else 0)
//   SLTU (0110) - set less than, unsigned
//   SLL  (0111) - shift left logical
//   SRL  (1000) - shift right logical  (zero-fills from MSB)
//   SRA  (1001) - shift right arithmetic (sign-fills from MSB)
//
// Notes:
//   - zero is high when result == 0.
//   - SLT/SLTU differ only in signedness. SLT casts both operands with
//     $signed(); SLTU compares them as raw unsigned values. The 1-bit
//     comparison result zero-extends to fill result.
//   - SRA needs $signed(a) so >>> replicates the sign bit. Without the
//     cast, >>> behaves identically to >> (logical shift).
//   - Shift amount uses only the low SHAMT_W = $clog2(WIDTH) bits of b,
//     the maximum meaningful shift distance for a WIDTH-bit operand.
//   - Purely combinational, no clock.
// =============================================================================

module alu #(parameter int WIDTH = 32)(
    input  logic [WIDTH-1:0] a,
    input  logic [WIDTH-1:0] b,
    input  logic [3:0]       alu_op,
    output logic [WIDTH-1:0] result,
    output logic             zero
    );

    // Operation encodings
    localparam ADD  = 4'b0000;
    localparam SUB  = 4'b0001;
    localparam AND  = 4'b0010;
    localparam OR   = 4'b0011;
    localparam XOR  = 4'b0100;
    localparam SLT  = 4'b0101;
    localparam SLTU = 4'b0110;
    localparam SLL  = 4'b0111;
    localparam SRL  = 4'b1000;
    localparam SRA  = 4'b1001;

    // Number of bits needed to index a bit position in a WIDTH-wide operand.
    // At WIDTH=32 this is 5, so the shift amount is b[4:0]
    localparam int SHAMT_W = $clog2(WIDTH);

    // Continuous assignment, lives outside the always block and tracks result.
    assign zero = (result == {WIDTH{1'b0}}); 

    always_comb begin
        case (alu_op)
            ADD:  result = a + b;
            SUB:  result = a - b;
            AND:  result = a & b;
            OR:  result = a | b;
            XOR:  result = a ^ b;
            SLT:  result = ($signed(a) < $signed(b));   // signed compare, 1-bit result zero-extends
            SLTU: result = (a < b);                     // unsigned compare
            SLL: result = a << b[SHAMT_W-1:0];          // left shift, zero-fills from LSB
            SRL: result = a >> b[SHAMT_W-1:0];          // logical right, zero-fills from MSB
            SRA: result = $signed(a) >>> b[SHAMT_W-1:0];// arithmetic right, sign-fills from MSB
            default: result = {WIDTH{1'b0}};            // unknown opcode, defined 0, no latch
        endcase
    end
endmodule
