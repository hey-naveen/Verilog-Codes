module top_module (
    input clk,
    input reset,      // Synchronous active-high reset
    output [3:0] q);
    
    always @(posedge clk) 
        q <= reset ? 4'b0 : q + 1;      // since max value of 4 bits is 15, so it will roll over to 0

  // m = 2: 
  /*
  	always @(posedge clk)
		if (reset)
			q <= 0;
		else
			q <= q+1;	
      */

endmodule
