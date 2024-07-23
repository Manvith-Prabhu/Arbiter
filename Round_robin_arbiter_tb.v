`timescale 1ns / 1ns
`include "Round_robin_arbiter.v"

module Arbiter_test;
  reg clk;
  reg rst_n;
  reg [3:0] REQ;
  wire [3:0] GNT;
  RR_arbiter DUT(.clk(clk), .rst_n(rst_n), .REQ(REQ), .GNT(GNT));

  initial begin
    $dumpfile("test.vcd");
    $dumpvars();
  end
  
  always #5 clk = ~clk;

  initial begin
    clk = 0;
    rst_n = 1;
    REQ = 4'b0;
    //Deassert the Reset
    #3 rst_n = 0;
    #6 rst_n = 1;
    @(posedge clk) REQ = 4'b1000;    
    @(posedge clk) REQ = 4'b1010;
    @(posedge clk) REQ = 4'b0010;
    @(posedge clk) REQ = 4'b0110;
    @(posedge clk) REQ = 4'b1110;
    @(posedge clk) REQ = 4'b1111;
    @(posedge clk) REQ = 4'b0100;
    @(posedge clk) REQ = 4'b0100;
    @(posedge clk) REQ = 4'b0001;
    @(posedge clk) REQ = 4'b0010;
    @(posedge clk) REQ = 4'b0010;
    @(posedge clk) REQ = 4'b0010;
    #5 rst_n = 0;
    #100 $finish;
  end
  
endmodule