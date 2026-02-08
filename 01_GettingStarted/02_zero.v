module top_module(
    output zero
);// Module body starts after semicolon

    assign zero = 1'b0; 

  // m = 2: may generate error for different synthesizers
 // Fun fact: For Quartus synthesis, not assigning a value to a signal usually results in 0. This problem is actually easier than the previous one.
endmodule
