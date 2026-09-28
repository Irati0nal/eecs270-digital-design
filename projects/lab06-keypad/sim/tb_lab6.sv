`timescale 1ns/1ps
module tb_lab6;
reg clk=0,reset=1; reg [15:0] keys=0; reg [3:0] row;
wire [3:0] col,an; wire [6:0] seg; integer r,c,k,events=0,before_events;
always #5 clk=~clk;
// Electrical matrix model: a closed key connects its driven column to a row.
always @* begin
 row=0;
 for(r=0;r<4;r=r+1) for(c=0;c<4;c=c+1) row[r]=row[r] | (keys[r*4+c]&col[c]);
end
top_keypad_system #(.SCAN_CYCLES(8),.DEBOUNCE_FRAMES(3),.DISPLAY_CYCLES(2)) dut(clk,reset,row,col,an,seg);
always @(posedge clk) if(dut.valid) events=events+1;
task cycles(input integer n);repeat(n) begin @(posedge clk);#1;end endtask
initial begin
 cycles(5);@(negedge clk);reset=0;cycles(130);
 @(negedge clk);keys=16'h20;cycles(4);@(negedge clk);keys=0;cycles(150);
 if(events!=0) $fatal(1,"Short key bounce accepted");
 for(k=0;k<16;k=k+1) begin
  before_events=events;@(negedge clk);keys=16'b1<<k;cycles(200);
  if(dut.stored!==k[3:0] || events!=before_events+1) $fatal(1,"Key %0d",k);
  cycles(200);if(events!=before_events+1) $fatal(1,"Held key repeated");
  @(negedge clk);keys=0;cycles(200);
  if(dut.stored!==k[3:0]) $fatal(1,"Value lost on release");
 end
 before_events=events;@(negedge clk);keys=16'h0003;cycles(200);
 if(events!=before_events) $fatal(1,"Multiple keys accepted");
 @(negedge clk);keys=0;reset=1;cycles(4);
 if(dut.stored!==0) $fatal(1,"Keypad reset");
 $display("PASS lab6: all 16 physical key positions, bounce, hold, release, multi-key rejection, reset");$finish;
end
initial begin #200000;$fatal(1,"Timeout");end
endmodule
