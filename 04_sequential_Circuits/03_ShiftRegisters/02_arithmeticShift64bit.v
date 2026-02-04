module top_module(
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg [63:0] q); 
    
    parameter w = 63;		// width-1
    always @(posedge clk) begin
        if (load) q <= data;
        else if (ena) begin
            case (amount)
              0: q <= {q[w-1:0],1'b0};      // can also use q <= (q << 1); since arithmetic left shift = logical left shift
              1: q <= {q[w-8:0], 8'b0};     // can also use q <= (q << 8); since arithmetic left shift = logical left shift
                2: q <= {{1{q[w]}}, q[w:1]};
                3: q <= {{8{q[w]}}, q[w:8]};                    
            endcase
        end
    end

endmodule
