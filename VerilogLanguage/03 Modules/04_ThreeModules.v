module top_module ( input clk, input d, output q );
    wire w1, w2;
    
    // make three instances and connect ports by position
    my_dff d0(clk, d, w1);
    my_dff d1(clk, w1, w2);
    my_dff d2(clk, w2, q);
endmodule
