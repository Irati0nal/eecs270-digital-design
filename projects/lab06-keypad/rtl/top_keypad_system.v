`timescale 1ns/1ps
module top_keypad_system #(
    parameter SCAN_CYCLES=100000, DEBOUNCE_FRAMES=5, DISPLAY_CYCLES=100000
)(input clk, reset, input [3:0] row, output [3:0] col, an, output [6:0] seg);
    wire rst, valid;
    wire [3:0] code;
    reg [3:0] stored;
    reset_sync reset_conditioner(clk,reset,rst);
    keypad_scanner #(.SCAN_CYCLES(SCAN_CYCLES),.DEBOUNCE_FRAMES(DEBOUNCE_FRAMES))
        scanner(clk,rst,row,col,code,valid);
    always @(posedge clk) begin
        if(rst) stored<=0;
        else if(valid) stored<=code;
    end
    display_mux #(.SCAN_CYCLES(DISPLAY_CYCLES)) display(
        clk,rst,{5'd17,5'd17,5'd17,1'b0,stored},an,seg);
endmodule
