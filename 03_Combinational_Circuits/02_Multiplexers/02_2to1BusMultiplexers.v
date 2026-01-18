module top_module( 
    input [99:0] a, b,
    input sel,
    output [99:0] out );

  // unlike prev. question this will fail.
  // assign out = (sel & b) | (~sel & a);    // valid only for one bit

    assign out = sel ? b : a;

endmodule
