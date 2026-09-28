`timescale 1ns/1ps
// Multi-bit inputs must be held stable before an action is requested.
module input_sync #(parameter WIDTH=1)(
    input clk, input reset, input [WIDTH-1:0] async_in,
    output wire [WIDTH-1:0] sync_out
);
    (* ASYNC_REG = "TRUE" *) reg [WIDTH-1:0] meta;
    (* ASYNC_REG = "TRUE" *) reg [WIDTH-1:0] settled;
    assign sync_out = settled;
    always @(posedge clk) begin
        if (reset) begin meta <= 0; settled <= 0; end
        else begin meta <= async_in; settled <= meta; end
    end
endmodule
