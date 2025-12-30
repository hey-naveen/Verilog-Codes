module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); 

    // Use FSM from Fsm_serial
    parameter IDLE = 0, START = 1, RECV = 2, WAIT = 3, STOP = 4;
    reg [2:0] state, next, i;
    reg [7:0] temp;
    
    // State Transitions and Counter incrementer
    always @(posedge clk) begin
        if (reset) begin
           state <= IDLE;
            i <= 0;
        end
        else state <= next;
        
        // counter increment logic
        if (state == RECV) i <= i + 1'b1;
        else i <= 0;
    end
    
    // Next State Logic
    always @(*) begin
        case(state)
            IDLE : next = in ? IDLE : START;
            START : next = RECV;
            RECV : begin if (i == 7) next = in ? STOP : WAIT;
                	else next = RECV;                
                end
            WAIT: next = in ? IDLE : WAIT;
            STOP : next = in ? IDLE : START;
            default : next = IDLE;
        endcase
    end
    
    // Comb logic for output
   assign done = (state == STOP);


    // New: Datapath to latch input bits.
    always @(posedge clk) begin
        if (next == RECV) begin
            temp <= {in, out_byte[7:1]}; 
        end
    end
    
   assign out_byte = done ? temp : 8'bx;

endmodule
