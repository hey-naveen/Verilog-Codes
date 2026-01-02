module top_module(
input [1:0] a,
input b,e, 
output c
    );
  
    assign c = (a==2) ? b : e;
  
endmodule
