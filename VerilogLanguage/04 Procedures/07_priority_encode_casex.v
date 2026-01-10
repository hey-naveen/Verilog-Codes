module top_module (
    input [7:0] in,
    output reg [2:0] pos );

  // don't use xxxx1xxx as it will match multiple conditons then ordering is important, which condition will match first will get executed.
    always @(*) 
        casex(in)  
            8'bxxxxxxx1 : pos = 3'd0;
            8'bxxxxxx10 : pos = 3'd1;
            8'bxxxxx100 : pos = 3'd2;
            8'bxxxx1000 : pos = 3'd3;
            8'bxxx10000 : pos = 3'd4;
            8'bxx100000 : pos = 3'd5;
            8'bx1000000 : pos = 3'd6;
            8'b10000000 : pos = 3'd7;
            default: pos = 3'd0;   
        endcase

  // m == 2
  /*
      always @(*)
        begin
            casex (in)
                8'bzzzzzzz1: pos = 0;
                8'bzzzzzz10: pos = 1;
                8'bzzzzz100: pos = 2;
                8'bzzzz1000: pos = 3;
                8'bzzz10000: pos = 4;
                8'bzz100000: pos = 5;
                8'bz1000000: pos = 6;
                8'b10000000: pos = 7;
                default : pos = 0;                
            endcase
        end
  */

endmodule
