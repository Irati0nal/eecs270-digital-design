`timescale 1ns/1ps
module digital_clock #(parameter CLOCK_HZ=100000000, parameter SCAN_CYCLES=100000)(
    input clk, reset, output [3:0] an, output [6:0] seg
);
    wire rst;
    reset_sync reset_conditioner(clk,reset,rst);
    localparam W=(CLOCK_HZ<2)?1:$clog2(CLOCK_HZ);
    reg [W-1:0] divider;
    reg [3:0] tens, ones;
    always @(posedge clk) begin
        if(rst) begin divider<=0; tens<=0; ones<=0; end
        else if(divider==CLOCK_HZ-1) begin
            divider<=0;
            if(ones==9) begin ones<=0; tens <= (tens==5)?0:tens+1'b1; end
            else ones<=ones+1'b1;
        end else divider<=divider+1'b1;
    end
    display_mux #(.SCAN_CYCLES(SCAN_CYCLES)) display(
        clk,rst,{5'd17,5'd17,1'b0,tens,1'b0,ones},an,seg);
endmodule
