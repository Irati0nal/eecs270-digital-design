`timescale 1ns/1ps
// Portable gate-level reference for the original Multisim full adder.
module full_adder(input a, input b, input cin, output sum, output cout);
    wire propagate = a ^ b;
    assign sum = propagate ^ cin;
    assign cout = (a & b) | (propagate & cin);
endmodule
