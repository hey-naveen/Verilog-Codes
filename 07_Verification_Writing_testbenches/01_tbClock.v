module top_module ( );
    
    reg clk = 0;
  // or we can also initial clock like this
  /* 
    reg clk;
    initial clk = 0;
  */
    always #5 clk = ~clk;
    dut d(clk);

endmodule
