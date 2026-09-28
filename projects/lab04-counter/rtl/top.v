`timescale 1ns/1ps
module top #(parameter DEBOUNCE_CYCLES=1000000)(
    input clk, clk_btn, rst_btn, up_down_sw,
    output [3:0] led, output [6:0] seg, output [3:0] an
);
    wire reset, step, direction;
    reset_sync rst(clk,rst_btn,reset);
    button #(.STABLE_CYCLES(DEBOUNCE_CYCLES)) btn(clk,reset,clk_btn,step);
    input_sync dir_sync(clk,reset,up_down_sw,direction);
    counter count_core(clk,reset,step,direction,led);
    seven_segment decoder({1'b0,led},seg);
    assign an=4'b1110;
endmodule
