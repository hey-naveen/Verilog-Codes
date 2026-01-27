module top_module (
    input d, 
    input ena,
    output q);
    
    assign q = ena? d : q;    // since clock s not involved can be modeled as combinational circuit, although latches are sequential circuits
  // A D-latch acts like a wire (or non-inverting buffer) when enabled, and preserves the current value when disabled.

  // m = 2:
  //Latches are level-sensitive (not edge-sensitive) circuits, so in an always block, they use level-sensitive sensitivity lists.
  /*
      always @(*)
        begin
          if (ena)   q <= d;            // else part need not to be required.
        end
        */

endmodule
