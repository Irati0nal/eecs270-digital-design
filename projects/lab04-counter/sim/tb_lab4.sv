`timescale 1ns/1ps
module tb_lab4;
reg clk=0, clk_btn=0, rst_btn=1, up_down_sw=1;
wire [3:0] led,an; wire [6:0] seg; integer i;
always #5 clk=~clk;
top #(.DEBOUNCE_CYCLES(4)) dut(clk,clk_btn,rst_btn,up_down_sw,led,seg,an);
task cycles(input integer n); repeat(n) begin @(posedge clk); #1; end endtask
task press;
 begin @(negedge clk); clk_btn=1; cycles(15); @(negedge clk);clk_btn=0; cycles(15);end
endtask
initial begin
 cycles(5); @(negedge clk);rst_btn=0;cycles(8);
 if(led!==0) $fatal(1,"Counter reset");
 // Short glitches must not count.
 @(negedge clk);clk_btn=1;cycles(1);@(negedge clk);clk_btn=0;cycles(10);
 if(led!==0) $fatal(1,"Button bounce counted");
 for(i=1;i<=16;i=i+1) begin press; if(led!==(i%16)) $fatal(1,"Up count %0d",i); end
 @(negedge clk);up_down_sw=0;cycles(8);
 press; if(led!==15) $fatal(1,"Down wrap");
 @(negedge clk);clk_btn=1;cycles(100);
 if(led!==14) $fatal(1,"Held button repeated");
 @(negedge clk);rst_btn=1;cycles(3);
 if(led!==0 || an!==4'b1110 || seg!==7'h40) $fatal(1,"Reset/display");
 $display("PASS lab4: bounce rejection, hold, up/down wrap, reset and display");$finish;
end
initial begin #100000;$fatal(1,"Timeout");end
endmodule
