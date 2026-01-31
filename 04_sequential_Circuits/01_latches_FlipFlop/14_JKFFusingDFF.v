module top_module (
    input clk,
    input j,
    input k,
    output Q); 

  // Write characteristic table of JK FF and excitation table of D FF, connect them and solve k-map (3-var);
    always @(posedge clk)begin
        Q <= (j&~Q) | (~k&Q);		// Q on LHS is current value, and Q on RHS is prev value.
    end


  // m=2:
  /*
    always @(posedge clk) begin
        case({j, k})
            2'b00 : Q <= Q;
            2'b01 : Q <= 0;
            2'b10 : Q <= 1;
            2'b11 : Q <= ~Q;
        endcase
    end
  */

endmodule
