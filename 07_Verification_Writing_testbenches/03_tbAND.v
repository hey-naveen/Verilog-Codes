module top_module();
    reg [1:0] in;
    wire out;
    
    andgate dut(in, out);

// m = 1 : normal way
  /*
    initial begin
        in= 2'b0;
        #10 in[0] = 1'b1; // in[1] remains 0;
        #10 in = 2'b10;
        #10 in = 2'b11;
    end
   */
  
  // m = 2: SCALABLE version
    integer i;
    initial begin
        for (i = 0; i<4 ; i++) begin
            in = i;
            #10;
        end
    end
endmodule
