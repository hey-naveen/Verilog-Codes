module top_module(
    input clk,
    input reset,    // Synchronous reset to OFF
    input j,
    input k,
    output out); //  

    parameter OFF= 1'd0, ON= 1'd1; 
    reg state, next;

    always @(*) begin
        case(state) 
            OFF : next = j ? ON  : OFF;
            ON  : next = k ? OFF : ON ;
            default : next = OFF;
        endcase
    end

    always @(posedge clk) begin
        if (reset) 
            state <= OFF;
        else 
            state <= next;
    end

    assign out = (state == ON);

endmodule
