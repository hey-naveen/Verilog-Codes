module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    input w,
    output z
);
    
    parameter A = 0, B = 1, C = 2, D = 3, E = 4, F = 5;
    reg [2:0] state, next;
    
    // next state logic
    always @(*) begin
        case(state)
        	A : next = w ? B : A;
            B : next = w ? C : D;
            C : next = w ? E : D;
            D : next = w ? F : A;
            E : next = w ? E : D;
            F : next = w ? C : D;
            default : next = A;
        endcase
    end
    
    // next state transition
    always @(posedge clk) begin
        if (reset) state <= A;
        else state <= next;
    end
    
    // output logic
    always @(*) begin
        case(state)
            E, F : z = 1'b1;
            default : z = 1'b0;
        endcase
    end
  // or we can also write output logic as
  // assign z = (state == E) || (state == F);

endmodule
