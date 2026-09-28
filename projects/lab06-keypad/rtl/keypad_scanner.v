`timescale 1ns/1ps
// Active-high matrix, one key at a time. A full frame samples all columns.
module keypad_scanner #(parameter SCAN_CYCLES=100000, parameter DEBOUNCE_FRAMES=5)(
    input clk, reset, input [3:0] row,
    output [3:0] col, output reg [3:0] code, output reg valid
);
    wire [3:0] rows;
    input_sync #(.WIDTH(4)) row_sync(clk,reset,row,rows);
    localparam W=(SCAN_CYCLES<2)?1:$clog2(SCAN_CYCLES);
    localparam D=(DEBOUNCE_FRAMES<2)?1:$clog2(DEBOUNCE_FRAMES+1);
    reg [W-1:0] divider;
    reg [1:0] column;
    reg [15:0] frame, previous;
    reg [D-1:0] stable;
    reg held;
    reg [15:0] next_frame;
    integer r,k;
    assign col=4'b0001<<column;
    always @* begin
        next_frame=frame;
        for(r=0;r<4;r=r+1) next_frame[r*4+column]=rows[r];
    end
    wire single_key=(next_frame!=0) && ((next_frame & (next_frame-16'd1))==0);
    always @(posedge clk) begin
        if(reset) begin
            divider<=0; column<=0; frame<=0; previous<=0;
            stable<=0; held<=0; code<=0; valid<=0;
        end else begin
            valid<=0;
            if(divider==SCAN_CYCLES-1) begin
                divider<=0; column<=column+1'b1; frame<=next_frame;
                if(column==3) begin
                    if(next_frame!=previous) begin previous<=next_frame; stable<=1; end
                    else if(stable<DEBOUNCE_FRAMES) stable<=stable+1'b1;
                    if((next_frame==previous && stable>=DEBOUNCE_FRAMES-1)
                       || DEBOUNCE_FRAMES==1) begin
                        if(next_frame==0) held<=0;
                        else if(single_key && !held) begin
                            held<=1; valid<=1;
                            for(k=0;k<16;k=k+1) if(next_frame[k]) code<=k;
                        end
                    end
                end
            end else divider<=divider+1'b1;
        end
    end
endmodule
