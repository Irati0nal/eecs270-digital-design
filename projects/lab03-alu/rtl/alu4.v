`timescale 1ns/1ps
// Subtraction carry is no-borrow, matching A + ~B + 1.
module alu4(input [3:0] a,b, input [1:0] op, output reg [3:0] result, output reg cout);
    always @* begin
        case(op)
            0:{cout,result}={1'b0,a}+{1'b0,b};
            1:{cout,result}={1'b0,a}+{1'b0,~b}+5'd1;
            2:begin result=a&b; cout=0; end
            3:begin result=a|b; cout=0; end
        endcase
    end
endmodule
