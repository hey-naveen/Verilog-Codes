module top_module(
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);

  // m = 1 : usual way
    always @(*) begin
        next_state[0] = (~in & (state[0] | state[1] | state[2] | state[3] | state[4] | state[7] | state[8] | state[9]));
        next_state[1] = (in & (state[0] | state[8] | state[9]));
        next_state[2] = in & state[1];
        next_state[3] = in & state[2];
        next_state[4] = in & state[3];
        next_state[5] = in & state[4];
        next_state[6] = in & state[5];
        next_state[7] = (in & state[6]) | (in & state[7]) ;
        next_state[8] = ~in & state[5];
        next_state[9] = ~in & state[6];                         
    end   

    assign out1 = state[8] | state[9];
    assign out2 = state[7] | state[9] ;


  // m = 2 : using reduction operator (shortcut method)
  /*
    // one hot, only one state is high at a time    
    // reduction operator is useful in finding if any bit is high, then result is high.
    // it is in the form of next_state [9:0]
    assign next_state = {     
        (state[6] && !in),    // state[9]
        (state[5] && !in),
        (state[7:6] && in),    // state[7]
        (state[5] && in),
        (state[4] && in),
        (state[3] && in),
        (state[2] && in),
        (state[1] && in),    
        (|{state[0], state[9:8]} && in),        
        (|{state[4:0], state[9:7]} && !in),	// if any of the following state is high, and in is low        
    };

    assign out1 = |(state[9:8]);
    assign out2 = |({state[9], state[7]});
  */
    

endmodule
