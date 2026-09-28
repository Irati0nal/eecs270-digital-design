`timescale 1ns/1ps
module counter(input clk, reset, enable, up_down, output reg [3:0] count);
    always @(posedge clk) begin
        if(reset) count<=0;
        else if(enable) count<=up_down ? count+1'b1 : count-1'b1;
    end
endmodule
