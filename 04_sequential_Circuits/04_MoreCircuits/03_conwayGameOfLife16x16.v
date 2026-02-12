module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q ); 
    
    // ----------------- THEORY -------------------
    // matrix is [255 -------------- 240]
    // 			 [239 -------------- 224]
    // 			 [  -   -- -- - - ------]
    // 			 [15 ----------------  0]
    
    // broken in 16 rows and 16 col
    // the website have solved for row = 15 to 0, and col = 15 to 0, but...
    // can have row/col = 0 to 15 or 15 to 0 both are correct since sides wrap around
    // in this case i have taken row = 0 to 15 and col = 15 to 0 and it works fine.
    
    // next state logic
  // can also be parameterized for in general n, by replacing 16 by n, and 15 by n-2,
  // here i kept it simple for understanding purposes.
    parameter n = 16;
    reg [255:0] next;    
    generate 
        genvar row, col; 
        for (row = 0; row<16; row ++) begin : row1
            for (col =0; col<16; col++) begin : col1
                nextstate ns( 
                  q[(row == 0 ? 15 : (row-1))*n + (col == 15 ? 0 : (col+1)) ],   // ul    upper left
                  q[(row == 0 ? 15 : (row-1))*n +	(col)                     ],   // uc    upper center
                  q[(row == 0 ? 15 : (row-1))*n	+ (col == 0 ? 15 : (col-1)) ],   // ur    upper right
                  q[(n*row)	  				          + (col == 15 ? 0 : (col+1)) ],	 // l     left
                  q[(n*row)						          +	(col)                     ],   // c     center
                  q[n*(row)						          + (col == 0 ? 15 : (col-1)) ],   // r     right
                  q[(row == 15 ? 0 : (row+1))*n + (col == 15 ? 0 : (col+1)) ],   // ll    lower left
                  q[(row == 15 ? 0 : (row+1))*n +	(col)                     ],   // lc    lower center
                  q[(row == 15 ? 0 : (row+1))*n	+ (col == 0 ? 15 : (col-1)) ],   // lr    lower right
                  next[n*row + col]
                );
            end
        end
    endgenerate
             
     
    // next state transistion
    always @(posedge clk) begin
        if (load) q <= data;
        else q <= next;        
    end

endmodule

module nextstate(
    input ul, uc, ur, 
    input l, c, r,
    input dl, dc, dr, 
    output cn
);
  reg [3:0] sum;	// 4 bit sum since max can be 8;
    always @(*) begin
      sum = ul + uc + ur + l + r + dl + dc + dr;    // total number of neighbours (don't include 'c')
        case (sum)
            2 : cn = c;
            3 : cn = 1'b1;        
            default cn = 1'b0;
        endcase
    end
    
endmodule
