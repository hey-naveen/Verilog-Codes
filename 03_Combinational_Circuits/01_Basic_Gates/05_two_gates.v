module top_module (
    input in1,
    input in2,
    input in3,
    output out);
    
    wire w;
    xnor g0(w, in1, in2);
    xor g1(out, w, in3);
  
  //m = 2
  //assign out = ~(in1 ^ in2) ^ in3;
endmodule
