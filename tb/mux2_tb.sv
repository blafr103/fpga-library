`timescale 1ns/1ps

module mux2_tb;

    // DUT inputs
    logic a;
    logic b;
    logic sel;

    // DUT output
    logic y;

    // Instantiate the Device Under Test (DUT)
    mux2 dut (
        .a(a),
        .b(b),
        .sel(sel),
        .y(y)
    );

    initial begin
        $display("Starting mux2 testbench...");
        $display(" a b sel | y ");

        // Test all possible input combinations
        for (int i = 0; i < 8; i++) begin
            {a, b, sel} = i[2:0];
            #10;

            $display(" %b %b  %b  | %b", a, b, sel, y);

            // Self-check
            if (y !== (sel ? b : a)) begin
                $error("Test FAILED: a=%b b=%b sel=%b y=%b",
                        a, b, sel, y);
            end
        end

        $display("All tests passed.");
        $finish;
    end

endmodule
