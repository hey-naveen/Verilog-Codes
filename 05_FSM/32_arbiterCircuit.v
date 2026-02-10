// arbiter circuit control access to the resources to requesting devices, and grants resources to one device at a time (acc. to priority)
// and goes in that state, until the device with higher priority request is high.
// moore fsm

module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output [3:1] g   // grant
); 
    parameter A = 2'd0, B = 2'd1, C = 2'd2, D= 2'd3;
    reg [2:0] state, next;		// two bits
    
    // next state combinational logic
    always @(*) begin
        next = A;		// assigning default state.
        case(state)

          //  i like using ternary operator for simpler code
          A : next = (r[1] ? B) : (r[2] ? C) : (r[3] ? D) : A;	
            // default state A: if r[1] is high then B, 
            // else if r[2] is high then C, 
            // else if r[3] is high then D (acc to priority), else stay in state A.
            B : next = r[1] ? B : A;
            C : next = r[2] ? C : A;
            D : next = r[3] ? D : A;
        endcase
    end
    
    // state transition sequential logic
    always @(posedge clk) begin
        if (!resetn) 
            state <= A;
        else 
            state <= next;
    end
    
    // output
    assign g = {(state == D), (state == C), (state == B)};	// only one will be high at a time


  // -------------------------------------------------------------------------------------------------
  // m = 2: using if else 
  /*
      parameter A = 2'd0, B = 2'd1, C = 2'd2, D= 2'd3;
    reg [2:0] state, next;	
    
    // next state combinational logic
    always @(*) begin
        next = A;
        case(state)
           A : begin
               if (r[1]) 
                next = B;
               else if (r[2])
                next = C;
               else if (r[3])
                next = D;
               else 
                next = A;
           end
            B : begin
                if (r[1]) 
                    next = B;
                else 
                    next = A;
            end
            
            C : begin
                if (r[2]) 
                    next = C;
                else 
                    next = A;
            end
            
            D : begin
                if (r[3]) 
                    next = D;
                else 
                    next = A;
            end
        endcase
    end
    
    // next state transition
    always @(posedge clk) begin
        if (!resetn) 
            state <= A;
        else
            state <= next;
    end
    
    
    // output logic
    assign g[1] = (state == B);
    assign g[2] = (state == C);
    assign g[3] = (state == D);
  */
    

endmodule
