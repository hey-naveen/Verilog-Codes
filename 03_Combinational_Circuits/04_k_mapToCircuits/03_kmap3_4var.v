module top_module(
    input a,
    input b,
    input c,
    input d,
    output out  ); 

  // dont care can be 0 or 1, depending upon our use
    assign out = a | (c & ~b);     // SOP form

    // grouping zeros and taking 0 as A and 1 as ~A.
    // assign out = (a | ~b) & (a | c);    // POS form

    
  
endmodule
