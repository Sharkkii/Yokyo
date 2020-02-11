`timescale 1ns / 100ps
`default_nettype none

module mul_testbench();
  int i, j;
  wire is_signed;
  logic clk;

  // NOTE: signed mul
  wire signed [31:0] src, sink;
  wire signed [63:0] dest, ans;
  logic signed [31:0] src_logic, sink_logic;
  logic signed [63:0] ans_logic;
  assign is_signed = 1'b1;

  // NOTE: unsigned mul
  // wire [31:0] src, sink;
  // wire [63:0] dest, ans;
  // logic [31:0] src_logic, sink_logic;
  // logic [63:0] ans_logic;
  // assign is_signed = 1'b0;

  assign is_signed = 1'b1;
  assign src = src_logic;
  assign sink = sink_logic;
  assign ans = ans_logic;

  mul u0(clk,is_signed,src,sink,dest);

  initial begin
    clk <= 1'b0;
    for (i=0; i<1; i++) begin
      src_logic = 32'h1;
      sink_logic = 32'hffff;

      #1;
      clk <= !clk; #1;
      clk <= !clk; #1;
      clk <= !clk; #1;
      clk <= !clk; #1;
      clk <= !clk; #1;
      clk <= !clk; #1;
      clk <= !clk; #1;
      clk <= !clk; #1;
      #1;

      ans_logic = src * sink;

      #1;

      if (dest != ans) begin
      $display(" src = %b %b", src[31:16], src[15:0]);
      $display("sink = %b %b", sink[31:16], sink[15:0]);
      $display("dest = %b %b %b %b", dest[63:48], dest[47:32], dest[31:16], dest[15:0]);
      $display(" ans = %b %b %b %b", ans[63:48], ans[47:32], ans[31:16], ans[15:0]);
      $display();
      end
    end
  end
endmodule