module top_module(
    input clk,
    input in,
    input areset,
    output out); //

    parameter A=2'd0, B=2'd1, C=2'd2, D=2'd3;
    reg [1:0] state, next;
    
    // State transition combinatinal logic
    always @(*) begin
        case(state) 
            A : next= in ? B : A;
            B : next = in ? B : C;
            C : next = in ? D : A;
            D : next = in ? B : C;
            default : next = A;
        endcase
    end

    // State D FFs with asynchronous reset
    always @(posedge clk, posedge areset) begin
        if (areset) 
            state <= A;
        else 
            state <= next;
    end

  // Output logic (combinational)
    assign out = (state == D);

endmodule
