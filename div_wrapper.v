module div_wrapper(
  input wire clk,
  input wire [31:0] s,
  input wire [31:0] t,
  output wire [31:0] q,
  output wire [31:0] r
);

div u0(clk,s,t,q,r);

endmodule