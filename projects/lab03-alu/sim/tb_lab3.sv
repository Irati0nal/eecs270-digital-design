`timescale 1ns/1ps
module tb_lab3;
reg [3:0] a,b; reg [1:0] op; wire [3:0] result; wire cout;
integer x,y,s,expected_result,expected_carry;
alu4 dut(a,b,op,result,cout);
initial begin
 for(s=0;s<4;s=s+1) for(x=0;x<16;x=x+1) for(y=0;y<16;y=y+1) begin
  a=x;b=y;op=s; #1;
  case(s)
   0:begin expected_result=(x+y)%16; expected_carry=(x+y)>15; end
   1:begin expected_result=(x-y)&15; expected_carry=x>=y; end
   2:begin expected_result=x&y; expected_carry=0; end
   3:begin expected_result=x|y; expected_carry=0; end
  endcase
  if(result!==expected_result[3:0] || cout!==expected_carry[0])
    $fatal(1,"ALU op=%0d a=%0d b=%0d",s,x,y);
 end
 $display("PASS lab3: all 1024 operation/operand combinations"); $finish;
end
endmodule
