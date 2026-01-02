module generate_MUX (
  input [15:0]  data,
  input [3:0]  select,
  output  out
);
  
  assign  out = data[select];
endmodule
