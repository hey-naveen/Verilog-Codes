module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);

  // enable logic
    assign ena[1] = (q[3:0] == 9);
    assign ena[2] = (q[3:0] == 9) && (q[7:4]==9);
    assign ena[3] = (q[3:0] == 9) && (q[7:4]==9) && (q[11:8] == 9);
    
    always @(posedge clk)begin
        if (reset) q <= 16'b0;
        else begin
          // 1st digit bcd counter
            if (q[3:0] >= 9) q[3:0] <= 0;
            else q[3:0] <= q[3:0] + 4'b1;

          // 2nd digit bcd counter will increment on ena[1]
            if (ena[1]) begin
            	if (q[7:4] >= 9) q[7:4] <= 0;
                else q[7:4] <= q[7:4] + 4'b1;
            end
            
            if (ena[2]) begin
                if (q[11:8] >= 9) q[11:8] <= 0;
                else q[11:8] <= q[11:8] + 4'b1;
            end
            
            if (ena[3]) begin
                if (q[15:12] >= 9) q[15:12] <= 0;
                else q[15:12] <= q[15:12] + 4'b1;
            end
        end
    end

endmodule
