`timescale 1ns/1ps
module tb_lab1;
reg a,b,cin; wire sum,cout; integer i;
full_adder dut(a,b,cin,sum,cout);
initial begin
 for(i=0;i<8;i=i+1) begin
  {a,b,cin}=i; #1;
  if({cout,sum} !== (a+b+cin)) $fatal(1,"Full adder input %0d",i);
 end
 $display("PASS lab1: all 8 input combinations"); $finish;
end
endmodule
