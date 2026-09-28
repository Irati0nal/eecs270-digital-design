`timescale 1ns/1ps
// Assert asynchronously, release after two system-clock edges.
module reset_sync(input clk, input async_reset, output reset);
    (* ASYNC_REG = "TRUE" *) reg [1:0] pipe = 2'b11;
    always @(posedge clk or posedge async_reset)
        if (async_reset) pipe <= 2'b11;
        else pipe <= {pipe[0], 1'b0};
    assign reset = pipe[1];
endmodule
