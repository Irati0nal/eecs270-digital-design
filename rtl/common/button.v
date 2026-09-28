`timescale 1ns/1ps
module button #(parameter STABLE_CYCLES=1000000)(
    input clk, input reset, input raw, output reg pressed
);
    wire level;
    input_sync sync_button(clk, reset, raw, level);
    localparam W = (STABLE_CYCLES < 2) ? 1 : $clog2(STABLE_CYCLES);
    reg [W-1:0] count;
    reg debounced;
    always @(posedge clk) begin
        if (reset) begin count<=0; debounced<=0; pressed<=0; end
        else begin
            pressed<=0;
            if (level == debounced) count<=0;
            else if (count == STABLE_CYCLES-1) begin
                count<=0; debounced<=level; pressed<=level;
            end else count<=count+1'b1;
        end
    end
endmodule
