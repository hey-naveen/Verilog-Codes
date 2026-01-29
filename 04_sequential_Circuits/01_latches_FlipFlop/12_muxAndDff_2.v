module top_module (
    input clk,
    input w, R, E, L,
    output Q
);
    
    // i am comfortable using ternary operator
    always @(posedge clk) 
        Q <= (L) ? R : (E ? w : Q);		// this will create two mux

  // m = 2: using if else
  /*
    always @(posedge clk) begin 
        if(L) Q <= R;
        else begin
            if(E) Q <= w;
            else Q <= Q;
        end
    end
  */

endmodule
