module top_module (
    input clk,
    input slowena,
    input reset,
    output [3:0] q);

  // m = 1:
    always @(posedge clk) begin
        // here slowena is given priority
        if (slowena || reset) begin
        	if (reset || q>=9) q <= 4'b0;
        	else q <=q + 4'b1;
        end        
        // else q will hold it's value, since we are intentionally creating a FF here, we can skip else part.
    end

  // m = 2 : another logic
  /*
    always @(posedge clk)
        begin            
            if (reset || (q >= 9 & slowena)) q <= 0;
            else if (slowena && !reset) q <= q + 1;            
        end
    */

endmodule
