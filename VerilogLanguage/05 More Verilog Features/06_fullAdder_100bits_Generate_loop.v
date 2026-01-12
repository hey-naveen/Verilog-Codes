module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );
    
    generate
        genvar i;
        fullAdder fa0(a[0], b[0], cin, cout[0], sum[0]);        
        for (i = 1; i < $bits(a); i++) begin : fa_block
            fullAdder fa(a[i], b[i], cout[i-1], cout[i], sum[i]);
        end            
    endgenerate

  // -------------------------------------------------------------------
  // m =2 : using assign statements (structural modeling)
  /*
  genvar i;
  
  assign sum[0] = a[0]^b[0]^cin;
  assign cout[0]=a[0]&b[0] | a[0]&cin | b[0]&cin;
  
  generate
      for(i=1; i<100 ; i=i+1)begin:FA_block
          assign sum[i] = a[i]^b[i]^cout[i-1];
          assign cout[i] = a[i]&b[i] | a[i]&cout[i-1] | b[i]&cout[i-1];
      end
  endgenerate
  */

  // -------------------------------------------------------------------
  // m = 3 : using combinational for loop
  /*
      always @(*) begin
        for (int i = 0; i<$bits(a); i++ )
            begin
                if (i == 0) {cout[i], sum[i]} = a[i] + b[i] + cin;
                else {cout[i], sum[i]} =  a[i] + b[i] + cout[i-1];
            end
        end
    */
  // -------------------------------------------------------------------

endmodule

// instantiation of Full Adder Module
module fullAdder( 
    input a, b, cin,
    output cout, sum );
	
    assign {cout, sum} = a+ b+ cin;
endmodule
