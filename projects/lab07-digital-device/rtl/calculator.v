`timescale 1ns/1ps
module calculator(input clk, reset, mode, enter, input [3:0] operand,
                  output reg [3:0] acc, output reg overflow);
    reg previous_mode;
    wire [3:0] sum=acc+operand;
    always @(posedge clk) begin
        if(reset) begin acc<=0; overflow<=0; previous_mode<=0; end
        else begin
            previous_mode<=mode;
            if(mode && !previous_mode) begin acc<=0; overflow<=0; end
            else if(mode && enter) begin
                acc<=sum;
                overflow<=(acc[3]==operand[3]) && (sum[3]!=acc[3]);
            end
        end
    end
endmodule
