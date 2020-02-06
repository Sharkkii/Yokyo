// module div(
//   input wire [31:0] s,
//   input wire [31:0] t,
//   output wire [31:0] q,
//   output wire [31:0] r
// );

// wire [32:0][63:0] s_array;
// wire [32:0][63:0] t_array;
// assign s_array[0] = {31'b0, s};
// assign t_array[0] = {t, 31'b0};

// genvar i;
// generate
//   for (i=0;i<32;i=i+1) begin: for_q
//     assign q[31-i] = (s_array[i] > t_array[i]) ? 1'b1 : 1'b0;
//   end
//   for (i=0;i<32;i=i+1) begin: for_s_array
//     assign s_array[i+1] = (s_array[i] > t_array[i]) ? s_array[i] - t_array[i] : s_array[i];
//   end
//   for (i=0;i<32;i=i+1) begin: for_t_array
//     assign t_array[i+1] = t_array[i] >> 1;
//   end
// endgenerate

// assign r = s_array[32];

// endmodule


// NOTE: split into 8 part!

module div_stage #(
  parameter STAGE = 1
) (
  input wire [63:0] s_prev,
  input wire [63:0] t_prev,
  input wire [31:0] q_prev,
  output wire [63:0] s_next,
  output wire [63:0] t_next,
  output wire [31:0] q_next
);

wire [63:0] s_array [4:0];
wire [63:0] t_array [4:0];
assign s_array[0] = s_prev;
assign t_array[0] = t_prev;

assign q_next[31:4] = q_prev[27:0];

genvar i;
generate
  for (i=0;i<4;i=i+1) begin: for_q
    assign q_next[3-i] = (s_array[i] >= t_array[i]) ? 1'b1 : 1'b0;
  end
  for (i=0;i<4;i=i+1) begin: for_s_array
    assign s_array[i+1] = (s_array[i] >= t_array[i]) ? s_array[i] - t_array[i] : s_array[i];
  end
  for (i=0;i<4;i=i+1) begin: for_t_array
    assign t_array[i+1] = t_array[i] >> 1;
  end
endgenerate
assign s_next = s_array[4];
assign t_next = t_array[4];

endmodule

module div(
  input wire clk,
  input wire [31:0] s,
  input wire [31:0] t,
  output wire [31:0] q,
  output wire [31:0] r
);

wire [63:0] s1_prev, s2_prev, s3_prev, s4_prev, s5_prev, s6_prev, s7_prev, s8_prev;
wire [63:0] s1_next, s2_next, s3_next, s4_next, s5_next, s6_next, s7_next, s8_next;
wire [63:0] t1_prev, t2_prev, t3_prev, t4_prev, t5_prev, t6_prev, t7_prev, t8_prev;
wire [63:0] t1_next, t2_next, t3_next, t4_next, t5_next, t6_next, t7_next, t8_next;
wire [31:0] q1_prev, q2_prev, q3_prev, q4_prev, q5_prev, q6_prev, q7_prev, q8_prev;
wire [31:0] q1_next, q2_next, q3_next, q4_next, q5_next, q6_next, q7_next, q8_next;

assign s1_prev = {32'b0, s};
assign t1_prev = {1'b0, t, 31'b0};
assign q1_prev = 32'b0;
assign q = q8_next;
assign r = s8_next;

div_stage #(.STAGE(1)) u1(s1_prev,t1_prev,q1_prev,s1_next,t1_next,q1_next);
div_stage #(.STAGE(2)) u2(s2_prev,t2_prev,q2_prev,s2_next,t2_next,q2_next);
div_stage #(.STAGE(3)) u3(s3_prev,t3_prev,q3_prev,s3_next,t3_next,q3_next);
div_stage #(.STAGE(4)) u4(s4_prev,t4_prev,q4_prev,s4_next,t4_next,q4_next);
div_stage #(.STAGE(5)) u5(s5_prev,t5_prev,q5_prev,s5_next,t5_next,q5_next);
div_stage #(.STAGE(6)) u6(s6_prev,t6_prev,q6_prev,s6_next,t6_next,q6_next);
div_stage #(.STAGE(7)) u7(s7_prev,t7_prev,q7_prev,s7_next,t7_next,q7_next);
div_stage #(.STAGE(8)) u8(s8_prev,t8_prev,q8_prev,s8_next,t8_next,q8_next);

reg [63:0] s12, s23, s34, s45, s56, s67, s78;
reg [63:0] t12, t23, t34, t45, t56, t67, t78;
reg [31:0] q12, q23, q34, q45, q56, q67, q78;

assign s2_prev = s12;
assign s3_prev = s23;
assign s4_prev = s34;
assign s5_prev = s45;
assign s6_prev = s56;
assign s7_prev = s67;
assign s8_prev = s78;
assign t2_prev = t12;
assign t3_prev = t23;
assign t4_prev = t34;
assign t5_prev = t45;
assign t6_prev = t56;
assign t7_prev = t67;
assign t8_prev = t78;
assign q2_prev = q12;
assign q3_prev = q23;
assign q4_prev = q34;
assign q5_prev = q45;
assign q6_prev = q56;
assign q7_prev = q67;
assign q8_prev = q78;

always @(posedge clk) begin
  s12 <= s1_next;
  s23 <= s2_next;
  s34 <= s3_next;
  s45 <= s4_next;
  s56 <= s5_next;
  s67 <= s6_next;
  s78 <= s7_next;
  t12 <= t1_next;
  t23 <= t2_next;
  t34 <= t3_next;
  t45 <= t4_next;
  t56 <= t5_next;
  t67 <= t6_next;
  t78 <= t7_next;
  q12 <= q1_next;
  q23 <= q2_next;
  q34 <= q3_next;
  q45 <= q4_next;
  q56 <= q5_next;
  q67 <= q6_next;
  q78 <= q7_next;
end

endmodule