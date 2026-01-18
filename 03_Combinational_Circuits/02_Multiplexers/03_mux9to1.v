module top_module( 
    input [15:0] a, b, c, d, e, f, g, h, i,
    input [3:0] sel,
    output reg [15:0] out );
    
    always @(*) begin
        out = '1; 	// Apostrophe Literal: used in system verilog. sets all bits to 1 regardless of the widths. (there are other methods also)
                    // I prefer to assign a default value to 'out' instead of default case.
        case (sel)
            0 : out = a;
            1 : out = b;
            2 : out = c;
            3 : out = d;
            4 : out = e;
            5 : out = f;
            6 : out = g;
            7 : out = h;
            8 : out = i;
            // no need of default statement
        endcase
    end

endmodule
