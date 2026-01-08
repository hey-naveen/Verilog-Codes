module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
    wire [31:0] b1;
    wire c, c1;

  // XOR gate acts like controlled not (invert one inputer when another input is high)
  // Substraction when sub is high, takes 1's complement of b and added (sub = 1) to get 2's complement
    assign b1 = {32{sub}} ^ b;
    add16 a0 (a[15:0], b1[15:0], sub, sum[15:0], c);
    add16 a1 (a[31:16], b1[31:16], c, sum[31:16], c1);
    

endmodule
