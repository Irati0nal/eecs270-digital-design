`timescale 1ns/1ps
module tb_lab7;
reg clk=0,reset=1,mode=0,enter=0; reg [3:0] operand=0;
wire [3:0] acc; wire overflow;
reg btn=0;reg [15:0] sw=0;wire led;wire [3:0] an;wire [6:0] seg;
integer a,b,sa,sb,expected_sum,ov,i;reg [3:0] old_roll;reg [19:0] old_symbols;
reg [4:0] message0[0:15],message1[0:15];
reg [3:0] position;
always #5 clk=~clk;
calculator core(clk,reset,mode,enter,operand,acc,overflow);
top_lab7 #(.SCAN_CYCLES(2),.ROLL_CYCLES(12),.DEBOUNCE_CYCLES(4)) dut(clk,btn,sw,led,an,seg);
task cycles(input integer n); repeat(n) begin @(posedge clk);#1;end endtask
task add(input [3:0] value);
 begin @(negedge clk);operand=value;enter=1;cycles(1);@(negedge clk);enter=0;cycles(1);end
endtask
task push(input [3:0] value);
 begin @(negedge clk);sw[3:0]=value;cycles(8);@(negedge clk);btn=1;cycles(20);@(negedge clk);btn=0;cycles(15);end
endtask
initial begin
 for(i=0;i<16;i=i+1) begin
  message0[i]=(i<12)?i%10:17;
  message1[i]=(i<12)?9-(i%10):17;
 end
 cycles(5);@(negedge clk);reset=0;
 // The reference uses integer signed arithmetic, including both overflow directions.
 for(a=0;a<16;a=a+1) for(b=0;b<16;b=b+1) begin
  @(negedge clk);mode=0;cycles(1);@(negedge clk);mode=1;cycles(1);
  add(a);if(acc!==a[3:0] || overflow!==0) $fatal(1,"First operand");
  add(b);sa=(a<8)?a:a-16;sb=(b<8)?b:b-16;expected_sum=(a+b)&15;
  ov=(sa+sb>7)||(sa+sb< -8);
  if(acc!==expected_sum[3:0] || overflow!==ov[0]) $fatal(1,"Signed pair %0d %0d",sa,sb);
 end
 // Public-port integration: mode entry, bounce, -8 then repeated +3.
 @(negedge clk);sw[15]=1;cycles(12);
 if(dut.acc!==0) $fatal(1,"Mode entry reset");
 @(negedge clk);sw[3:0]=1;btn=1;cycles(1);@(negedge clk);btn=0;cycles(15);
 if(dut.acc!==0) $fatal(1,"Bounce accepted");
 push(8);if(dut.acc!==8 || led!==0) $fatal(1,"Enter -8");
 // Check all scan slots for negative magnitude and sign.
 for(i=0;i<8;i=i+1) begin
  cycles(1);
  case(an)
   4'b1110:if(seg!==7'h00) $fatal(1,"Magnitude of -8");
   4'b1101:if(seg!==7'h3f) $fatal(1,"Minus glyph");
   default:if(seg!==7'h7f) $fatal(1,"Calculator blank");
  endcase
 end
 for(i=1;i<=7;i=i+1) begin
  push(3);expected_sum=(8+i*3)&15;
  if(dut.acc!==expected_sum[3:0] || led!==(i==6)) $fatal(1,"Repeated addition %0d",i);
 end
 @(negedge clk);btn=1;cycles(100);expected_sum=(expected_sum+3)&15;
 if(dut.acc!==expected_sum[3:0]) $fatal(1,"Held equals repeats");
 @(negedge clk);btn=0;sw[15]=0;cycles(20);
 old_roll=dut.roll_index;cycles(12);
 if(dut.roll_index!==(old_roll+4'd1) || led!==0) $fatal(1,"Rolling cadence");
 // Independent demo-message tables and four trailing blank positions.
 for(i=0;i<16;i=i+1) begin
  if(dut.character(0,i)!==message0[i]) $fatal(1,"Message 0");
  if(dut.character(1,i)!==message1[i]) $fatal(1,"Message 1");
 end
 // Follow a complete scrolling cycle, including 15 -> 0 and each window offset.
 for(i=0;i<16;i=i+1) begin
  old_roll=dut.roll_index;cycles(12);position=old_roll+4'd1;
  if(dut.roll_index!==position) $fatal(1,"Rolling wrap");
  if(dut.symbols!=={message0[position],message0[(position+1)%16],
                    message0[(position+2)%16],message0[(position+3)%16]})
    $fatal(1,"Rolling window");
 end
 @(negedge clk);sw[14]=1;cycles(5);
 if(dut.select_message!==1) $fatal(1,"Message switch synchronization");
 @(negedge clk);sw[15]=1;cycles(10);
 if(dut.acc!==0 || led!==0) $fatal(1,"Re-entry reset");
 $display("PASS lab7: all 256 signed pairs, overflow, repeated addition, debounce, signed display, rolling messages and mode reset");$finish;
end
initial begin #300000;$fatal(1,"Timeout");end
endmodule
