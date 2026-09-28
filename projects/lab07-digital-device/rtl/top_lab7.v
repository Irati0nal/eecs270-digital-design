`timescale 1ns/1ps
module top_lab7 #(
    parameter SCAN_CYCLES=100000, ROLL_CYCLES=33333333, DEBOUNCE_CYCLES=1000000,
    parameter [47:0] MESSAGE0=48'h012345678901,
    parameter [47:0] MESSAGE1=48'h987654321098
)(input clk, btnC, input [15:0] sw, output led, output [3:0] an, output [6:0] seg);
    // Xilinx FPGA configuration initializes reset_sync; no external reset pin.
    wire reset, enter;
    wire [5:0] controls;
    reset_sync power_on(clk,1'b0,reset);
    input_sync #(.WIDTH(6)) switch_sync(clk,reset,{sw[15:14],sw[3:0]},controls);
    wire mode=controls[5], select_message=controls[4];
    wire [3:0] acc;
    wire overflow;
    button #(.STABLE_CYCLES(DEBOUNCE_CYCLES)) equal_button(clk,reset,btnC,enter);
    calculator calc(clk,reset,mode,enter,controls[3:0],acc,overflow);
    assign led=mode && overflow;
    localparam W=(ROLL_CYCLES<2)?1:$clog2(ROLL_CYCLES);
    reg [W-1:0] roll_count;
    reg [3:0] roll_index;
    always @(posedge clk) begin
        if(reset || mode) begin roll_count<=0; roll_index<=0; end
        else if(roll_count==ROLL_CYCLES-1) begin roll_count<=0; roll_index<=roll_index+1'b1; end
        else roll_count<=roll_count+1'b1;
    end
    function [4:0] character;
        input select;
        input [3:0] position;
        reg [47:0] message;
        begin
            message=select?MESSAGE1:MESSAGE0;
            character=(position<12)?{1'b0,message[(11-position)*4 +: 4]}:5'd17;
        end
    endfunction
    wire [3:0] magnitude=acc[3]?(~acc+1'b1):acc;
    wire [4:0] sign_symbol=acc[3]?5'd16:5'd17;
    wire [19:0] rolling={character(select_message,roll_index),
        character(select_message,roll_index+4'd1),
        character(select_message,roll_index+4'd2),character(select_message,roll_index+4'd3)};
    wire [19:0] symbols=mode?{5'd17,5'd17,sign_symbol,1'b0,magnitude}:rolling;
    display_mux #(.SCAN_CYCLES(SCAN_CYCLES)) display(clk,reset,symbols,an,seg);
endmodule
