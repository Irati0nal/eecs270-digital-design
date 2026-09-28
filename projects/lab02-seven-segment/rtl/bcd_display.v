`timescale 1ns/1ps
module bcd_display(input [3:0] bcd, output [3:0] an, output [6:0] seg);
    assign an=4'b1110;
    wire [4:0] symbol=(bcd<=9)?{1'b0,bcd}:5'd17;
    seven_segment decoder(symbol,seg);
endmodule
