`timescale 1ns/1ps
// Active-low {g,f,e,d,c,b,a}; symbols 0..15=hex, 16=minus, 17+=blank.
module seven_segment(input [4:0] symbol, output reg [6:0] seg);
    always @* begin
        case(symbol)
            0:seg=7'b1000000; 1:seg=7'b1111001;
            2:seg=7'b0100100; 3:seg=7'b0110000;
            4:seg=7'b0011001; 5:seg=7'b0010010;
            6:seg=7'b0000010; 7:seg=7'b1111000;
            8:seg=7'b0000000; 9:seg=7'b0010000;
            10:seg=7'b0001000; 11:seg=7'b0000011;
            12:seg=7'b1000110; 13:seg=7'b0100001;
            14:seg=7'b0000110; 15:seg=7'b0001110;
            16:seg=7'b0111111;
            default:seg=7'b1111111;
        endcase
    end
endmodule
