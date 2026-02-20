module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 
    
    parameter walk_r=0, walk_l=1, fall_r=2, fall_l=3, dig_r=4, dig_l=5;
    reg [2:0] state,  next;

    // Digging Precedence: Ensure that if ground is true, the lemming checks dig before checking bump.
    always @(*) begin
        case(state) 
          // i like the simplicity of using ternary operator, you can use if-else also...
            walk_l : next = (!ground) ? fall_l : (dig ? dig_l : (bump_left ? walk_r : walk_l));
            walk_r : next = (!ground) ? fall_r : (dig ? dig_r : (bump_right ? walk_l : walk_r));
            dig_l : next = !ground ? fall_l : dig_l;
            dig_r : next = !ground ? fall_r : dig_r;
            fall_l : next = ground ? walk_l : fall_l;
            fall_r : next = ground ? walk_r : fall_r;
            default : next = walk_l;
        endcase
    end
    
    always @(posedge clk, posedge areset) begin
        if (areset)
            state <= walk_l;
        else 
            state <= next;
    end
    
    assign walk_left = (state == walk_l);
    assign walk_right = (state == walk_r);
    assign aaah = (state == fall_r) | (state == fall_l);
    assign digging = (state == dig_r) | (state == dig_l);

endmodule
