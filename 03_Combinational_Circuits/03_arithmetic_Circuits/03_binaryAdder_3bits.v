module top_module( 
    input [2:0] a, b,
    input cin,
    output [2:0] cout,
    output [2:0] sum );

  // m = 1 : behavioural modeling
  // -------------------------------------------------------------------
  // for first bit
    assign {cout[0],sum[0]} = a[0] + b[0] + cin;
    
    genvar i;
    generate 
        for(i = 1; i < $bits(a); i = i + 1) begin: fablock
            assign {cout[i],sum[i]} = a[i] + b[i] + cout[i-1];            
        end
    endgenerate

  // m = 2 : structural modeling (using for loop)
  // --------------------------------------------------------------------
  /*
  assign sum[0] = a[0] ^ b[0] ^ cin;
  assign cout[0] = (a[0] & b[0]) | (a[0] & cin) | (b[0] & cin);
  
  always@(*) begin
    for(integer i=1; i<3; i++) begin
                  sum[i] = a[i] ^ b[i] ^ cout[i-1];
                  cout[i] = (a[i] & b[i]) | (a[i] & cout[i-1]) | (b[i] & cout[i-1]);
    end
  end
  */

  // m = 3 : using module
  // --------------------------------------------------------------------
  /*
    fadd f0 (a[0], b[0], cin, cout[0], sum[0]);
    fadd f1 (a[1], b[1], cout[0], cout[1], sum[1]);
    fadd f2 (a[2], b[2], cout[1], cout[2], sum[2]);
    */
  
endmodule
