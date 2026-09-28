`timescale 1ns/1ps
module tb_lab5;
reg clk=0,reset=1; wire [3:0] an; wire [6:0] seg;
integer i,seen; reg [6:0] glyph[0:9];
always #5 clk=~clk;
digital_clock #(.CLOCK_HZ(16),.SCAN_CYCLES(2)) dut(clk,reset,an,seg);
task cycles(input integer n); repeat(n) begin @(posedge clk); #1; end endtask
initial begin
 glyph[0]=7'h40;glyph[1]=7'h79;glyph[2]=7'h24;glyph[3]=7'h30;glyph[4]=7'h19;
 glyph[5]=7'h12;glyph[6]=7'h02;glyph[7]=7'h78;glyph[8]=0;glyph[9]=7'h10;
 cycles(5);@(negedge clk);reset=0;
 wait(dut.rst===0);cycles(0);
 // Every count changes exactly on the 16th system-clock edge.
 for(i=0;i<61*16;i=i+1) begin
  cycles(1);
  if(dut.tens!==(((i+1)/16)%60)/10 || dut.ones!==(((i+1)/16)%60)%10)
    $fatal(1,"Timer cadence/rollover at cycle %0d",i+1);
  case(an)
   4'b1110:if(seg!==glyph[dut.ones]) $fatal(1,"Ones glyph");
   4'b1101:if(seg!==glyph[dut.tens]) $fatal(1,"Tens glyph");
   4'b1011,4'b0111:if(seg!==7'h7f) $fatal(1,"Blank digit");
   default:$fatal(1,"Anode selection");
  endcase
 end
 @(negedge clk);reset=1;cycles(3);
 if(dut.tens!==0 || dut.ones!==0) $fatal(1,"Mid-run reset");
 $display("PASS lab5: exact tick cadence, 00-59 rollover, all display slots and reset");$finish;
end
initial begin #100000;$fatal(1,"Timeout");end
endmodule
