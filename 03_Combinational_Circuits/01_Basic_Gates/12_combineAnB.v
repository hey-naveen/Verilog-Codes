module top_module (input x, input y, output z);
  // m = 1 : using hierachial design
  wire wA1, wA2, wB1, wB2, wo1, wa1;
  A IA1(wA1, x, y);
  A IA2(wA2, x, y);
  B IB1(wB1, x, y);
  B IB2(wB2, x, y);
    
  or IOr1(wo1, wA1, wB1);
  and IAnd1(wa1, wA2, wB2);
  xor Ixor1(z, wo1, wa1); 

  
  // m = 2 : using partial boolean expression
  // -----------------------------------------
  /*
  wire wA1, wA2, wB1, wB2, wo1, wa1;
  A IA1(wA1, x, y);
  A IA2(wA2, x, y);
  B IB1(wB1, x, y);
  B IB2(wB2, x, y);
  
  assign z = (wA1 | wB1) ^ (wA2 & wB2);
  */

  // m = 3 : same functionality without hierarchy
  /*
  assign z = ((((x ^ y) & x) | (~(x^y))) ^ (((x ^ y) & x) & (~(x^y))));

  // or you can simplify the above including submodules
  // assign z = x|~y;

  */
    
endmodule


// ----------------------------------------
// Module Instantiations
// ----------------------------------------
module A(output z, input x, y);
    assign z = (x^y) & x;
endmodule

module B(output z, input x, y);
    assign z = ~(x ^ y);     
endmodule
