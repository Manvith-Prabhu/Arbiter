`timescale 1ns/1ns
`include "Priority_arbiter.v"

module Priority_arbiter_tb();
reg req0,req1,req2,req3,req4,reset,clock;
wire gnt0,gnt1,gnt2,gnt3,gnt4;
integer i;
Priority_arbiter n1(clock,reset,req0,req1,req2,req3,req4,gnt0,gnt1,gnt2,gnt3,gnt4);

initial begin
    $dumpfile("test.vcd");
    $dumpvars();
end

always #5 clock=~clock;

initial begin
clock=1;
reset=1;
end

initial begin
	#380 $finish;
end
initial begin
#20;
for(i=0;i<32;i=i+1)begin
reset=0;
{req0,req1,req2,req3,req4}=i;
#10;
end
{req0,req1,req2,req3,req4}=0;#50;
{req0,req1,req2,req3,req4}=5'b00110;#10;
end

endmodule
