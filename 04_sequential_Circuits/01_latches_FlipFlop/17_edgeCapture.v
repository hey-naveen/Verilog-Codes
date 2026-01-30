module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);
    reg [31:0] prev_in;
    always @(posedge clk) begin
       prev_in <= in;
        out <= (reset) ? 0 : (out | (~in & prev_in));

      // out | (~in & prev_in)  : will capture the result: if out is set once, then only goes low upon reset.
    end

  // m = 2 : using if else (for better understanding)
  /*
    always @(posedge clk) begin
        prev <= in;
        if (reset) out <= 1'b0;
        else  	out <= out | (~in & prev);
    end
    */

endmodule
