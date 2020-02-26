`timescale 1ns / 100ps
`default_nettype none

module div_testbench();
  int i, j;
  logic clk;
  logic enable, completed;
  wire is_signed;

  // NOTE: signed div
  // wire signed [31:0] src, sink, quo, res, q, r;
  // logic signed [31:0] src_logic, sink_logic;
  // logic signed [31:0] q_logic, r_logic;
  // assign is_signed = 1'b1;

  // NOTE: unsigned div
  wire [31:0] src, sink, quo, res, q, r;
  logic [31:0] src_logic, sink_logic;
  logic [31:0] q_logic, r_logic;
  assign is_signed = 1'b0;

  assign src = src_logic;
  assign sink = sink_logic;
  assign q = q_logic;
  assign r = r_logic;

  div u0(clk,enable,completed,is_signed,src,sink,quo,res);

  initial begin
    clk <= 1'b0;
    for (i=0; i<10; i=i+1) begin
      src_logic = $urandom();
      sink_logic = $urandom();

      #1;
      enable <= 1'b1; #1;
      clk <= !clk; #1; clk <= !clk; #1;
      enable <= 1'b0; #1; 
      clk <= !clk; #1; clk <= !clk; #1; 
      clk <= !clk; #1; clk <= !clk; #1; 
      clk <= !clk; #1; clk <= !clk; #1; 
      clk <= !clk; #1; clk <= !clk; #1; 
      clk <= !clk; #1; clk <= !clk; #1; 
      clk <= !clk; #1; clk <= !clk; #1; 
      clk <= !clk; #1; clk <= !clk; #1;

      clk <= !clk; #1; clk <= !clk; #1; 
      clk <= !clk; #1; clk <= !clk; #1; 
      clk <= !clk; #1; clk <= !clk; #1; 
      clk <= !clk; #1; clk <= !clk; #1; 
      clk <= !clk; #1; clk <= !clk; #1; 
      clk <= !clk; #1; clk <= !clk; #1; 
      clk <= !clk; #1; clk <= !clk; #1; 
      clk <= !clk; #1; clk <= !clk; #1; 

      clk <= !clk; #1; clk <= !clk; #1; 
      clk <= !clk; #1; clk <= !clk; #1; 
      clk <= !clk; #1; clk <= !clk; #1; 
      clk <= !clk; #1; clk <= !clk; #1; 
      clk <= !clk; #1; clk <= !clk; #1; 
      clk <= !clk; #1; clk <= !clk; #1; 
      clk <= !clk; #1; clk <= !clk; #1; 
      clk <= !clk; #1; clk <= !clk; #1; 

      clk <= !clk; #1; clk <= !clk; #1; 
      clk <= !clk; #1; clk <= !clk; #1; 
      clk <= !clk; #1; clk <= !clk; #1; 
      clk <= !clk; #1; clk <= !clk; #1; 
      clk <= !clk; #1; clk <= !clk; #1; 
      clk <= !clk; #1; clk <= !clk; #1; 
      clk <= !clk; #1; clk <= !clk; #1;
      $display("completed = %b", completed); #1;
      clk <= !clk; #1; clk <= !clk; #1; 

      #1;

      q_logic = src / sink;
      r_logic = src % sink;

      #1;

      // if (q != quo || r != res) begin
      $display("completed = %b", completed);
      $display(" src = %b %b", src[31:16], src[15:0]);
      $display("sink = %b %b", sink[31:16], sink[15:0]);
      $display(" quo = %b %b", quo[31:16], quo[15:0]);
      $display(" res = %b %b", res[31:16], res[15:0]);
      $display("   q = %b %b", q[31:16], q[15:0]);
      $display("   r = %b %b", r[31:16], r[15:0]);
      $display();
      // end
    end
  end

endmodule