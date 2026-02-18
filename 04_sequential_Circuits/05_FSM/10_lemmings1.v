module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right); //  

    parameter LEFT=0, RIGHT=1;
    reg state, next;

    // state transition logic
    always @(*) begin
        case(state) 
            LEFT : next = bump_left ? RIGHT : LEFT;
            RIGHT : next = bump_right? LEFT : RIGHT ;
            default : next = LEFT;
        endcase
    end

    // state transition logic
    always @(posedge clk, posedge areset) begin
        if (areset) 
            state <= LEFT;
        else 
            state <= next;
    end

    // Output logic
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);

endmodule
