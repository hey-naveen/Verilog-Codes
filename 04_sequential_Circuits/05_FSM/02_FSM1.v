// Note: this is little different: all processes occurs in the single clocked block
// This can be done using three always block also, but I suggest try doing by this method to understand block and non-blocking assignment
module top_module(clk, reset, in, out);
    input clk;
    input reset;    // Synchronous reset to state B
    input in;
    output out;//  
    reg out;

    // Fill in state name declarations
	parameter A=0, B=1;
    reg present_state, next_state;

    always @(posedge clk) begin
        if (reset) begin  
            // Fill in reset logic
            present_state <= B;
            out <= 1;
        end else begin
            case (present_state)
                // Fill in state transition logic
                B : next_state = (!in) ? A : B;
                A : next_state = (!in) ? B : A;
                default : next_state = B;
            endcase

            // State flip-flops
            present_state = next_state;   
          

          // since previous line is blocking, hence, present state is updated before case statement
          // in case we use non blocking assignment, then we have to use next_state in the case (present state value will be updated upon the clock edge) 
          case (present_state)
                // Fill in output logic
                B : out = 1;
                default : out=0;
            endcase
        end
    end

endmodule
