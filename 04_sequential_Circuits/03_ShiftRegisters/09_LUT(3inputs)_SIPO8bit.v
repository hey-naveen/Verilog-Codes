module top_module (
    input clk,
    input enable,
    input S,
    input A, B, C,
    output Z ); 

    reg [7:0] Q, Qnext;

  // Next state logic
    always @(*) begin
      Qnext <= {Q[6:0],S};  	// MSB is shifted in first, Entry point is Q[0] which finally goes to Q[7] after 8 LEFT shifts
      // discarding Q[7] and shifting in S to LEFT
    end
    
    always @(posedge clk) begin
        if (enable) begin
           Q <= Qnext; 
        end
    end
    
    assign Z = Q[{A,B,C}];			// This creates a Mux, where {A,B,C} = 0,1, 2,... acts as select lines
  // There are many other ways to create a 8:1 mux, using combinational ckt, or using case statements...
endmodule
