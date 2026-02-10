module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 
    parameter A = 0, B=1, C=2, D= 3, E=4, F=5, G=6, H=7, I=8;
    reg [3:0] state,next;
    
    // next state combinational logic
    always @(*) begin
        next = A;
        case(state)
            A : next = resetn ? B : A; 	// reset
            B : next = C;	// f = 1, wait for one cycle before monitoring input x
            C : next = x ? D : C;
            D : next = !x ? E : D;
            E : next = x ? F : C;
            F : next = y ? H : G ;
            G : next = y ? H : I;
            H : next = H;
            I : next = I;
        endcase
    end
    
    always @(posedge clk) begin
        if (!resetn) begin
            state <= A;
        end
        else begin
            state <= next;
        end
    end

    
    // output logic    
   always @(*) begin
        f = 0;
        g = 0;
        case (state)
            B : f = 1;
            F, G, H : g = 1;
        endcase
    end
    
    // m = 2:
    /*
    assign f = (state == B);
    assign g = (state == F) || (state == G) || (state == H);
    */
endmodule
