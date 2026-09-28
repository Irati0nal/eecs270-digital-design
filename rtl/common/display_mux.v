`timescale 1ns/1ps
// One 100 MHz clock domain; 1 kHz digit changes, 250 Hz per digit.
module display_mux #(parameter SCAN_CYCLES=100000)(
    input clk, input reset, input [19:0] symbols,
    output [3:0] an, output [6:0] seg
);
    localparam W=(SCAN_CYCLES<2)?1:$clog2(SCAN_CYCLES);
    reg [W-1:0] count;
    reg [1:0] index;
    always @(posedge clk) begin
        if(reset) begin count<=0; index<=0; end
        else if(count==SCAN_CYCLES-1) begin count<=0; index<=index+1'b1; end
        else count<=count+1'b1;
    end
    assign an = ~(4'b0001 << index);
    wire [4:0] symbol = symbols[index*5 +: 5];
    seven_segment decoder(symbol, seg);
endmodule
