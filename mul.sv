module mul_stage1(
  input wire [31:0] s,
  input wire [31:0] t,
  output wire [15:0][63:0] array1
);

genvar i;
generate
  for (i=0; i<16; i=i+1) begin: stage1
    assign array1[i] = (t[i*2] ? {32'b0, s} : 64'b0) + (t[i*2+1] ? {31'b0, s, 1'b0} : 64'b0);
  end
endgenerate

endmodule

module mul_stage2(
  input wire [15:0][63:0] array1,
  output wire [7:0][63:0] array2
);

genvar i;
generate
  for (i=0; i<8; i=i+1) begin: stage2
    assign array2[i] = array1[i*2] + (array1[i*2+1] << 2);
  end
endgenerate

endmodule

module mul_stage3(
  input wire [7:0][63:0] array2,
  output wire [3:0][63:0] array3
);

genvar i;
generate
  for (i=0; i<4; i=i+1) begin: stage3
    assign array3[i] = array2[i*2] + (array2[i*2+1] << 4);
  end
endgenerate

endmodule

module mul_stage4(
  input wire [3:0][63:0] array3,
  output wire [1:0][63:0] array4
);

genvar i;
generate
  for (i=0; i<2; i=i+1) begin: stage4
    assign array4[i] = array3[i*2] + (array3[i*2+1] << 8);
  end
endgenerate

endmodule

module mul_stage5(
  input wire [1:0][63:0] array4,
  output wire [63:0] d
);

assign d = array4[0] + (array4[1] << 16);

endmodule

module mul(
  input wire clk,
  input wire [31:0] s,
  input wire [31:0] t,
  output wire [63:0] d
);

wire [15:0][63:0] array1_in, array1_out;
wire [7:0][63:0] array2_in, array2_out;
wire [3:0][63:0] array3_in, array3_out;
wire [1:0][63:0] array4_in, array4_out;
reg [15:0][63:0] array1_reg;
reg [7:0][63:0] array2_reg;
reg [3:0][63:0] array3_reg;
reg [1:0][63:0] array4_reg;

assign array1_in = array1_reg;
assign array2_in = array2_reg;
assign array3_in = array3_reg;
assign array4_in = array4_reg;

mul_stage1 u1(s,t,array1_out);
mul_stage2 u2(array1_in,array2_out);
mul_stage3 u3(array2_in,array3_out);
mul_stage4 u4(array3_in,array4_out);
mul_stage5 u5(array4_in,d);

always @(posedge clk) begin
  array1_reg <= array1_out;
  array2_reg <= array2_out;
  array3_reg <= array3_out;
  array4_reg <= array4_out;
end

endmodule

