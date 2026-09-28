`timescale 1ns/1ps
module tb_lab2;
reg [3:0] bcd; wire [3:0] an; wire [6:0] seg;
reg [6:0] expected[0:17]; integer i;
reg [4:0] symbol; wire [6:0] common_seg;
seven_segment common_decoder(symbol,common_seg);
bcd_display dut(bcd,an,seg);
initial begin
 expected[0]=7'h40; expected[1]=7'h79; expected[2]=7'h24; expected[3]=7'h30;
 expected[4]=7'h19; expected[5]=7'h12; expected[6]=7'h02; expected[7]=7'h78;
 expected[8]=7'h00; expected[9]=7'h10;
 expected[10]=7'h08; expected[11]=7'h03; expected[12]=7'h46;
 expected[13]=7'h21; expected[14]=7'h06; expected[15]=7'h0e;
 expected[16]=7'h3f; expected[17]=7'h7f;
 for(i=0;i<16;i=i+1) begin
  bcd=i; #1;
  if(an!==4'b1110 || seg!==((i<10)?expected[i]:7'h7f)) $fatal(1,"BCD %0d",i);
 end
 for(i=0;i<32;i=i+1) begin
  symbol=i;#1;
  if(common_seg!==((i<18)?expected[i]:7'h7f)) $fatal(1,"Common symbol %0d",i);
 end
 $display("PASS lab2: all 16 BCD inputs and all 32 shared decoder symbols"); $finish;
end
endmodule
