module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 
    
    always @(posedge clk) begin
        if (reset) begin                            // 12:00:00 AM
            {hh,mm,ss} <= {8'h12,8'h00,8'h00};		// using hexadecimal to represent bcd
            pm <= 1'b0;
        end
        else if (ena) begin
            // ---- SECONDS RollOver-----
            if (ss[3:0] == 4'h9) begin
                ss[3:0] <= 4'h0;
                if (ss[7:4] == 4'h5) begin
                    ss[7:4] <= 4'h0;
                    // ---- MINUTES RollOver-----
                    if (mm[3:0] == 4'h9) begin
                        mm[3:0] <= 4'h0;
                        if (mm[7:4] == 4'h5) begin
                            mm[7:4] <= 4'h0;
                            // ---- HOURS RollOver-----
                            if (hh == 8'h11) pm <= ~pm;        // PM RollOver 11:59:59 → 12:00:00
                            if ((hh[7:4] == 4'h1) && (hh[3:0]==4'h2)) begin
                                hh <= 8'h01;
                            end
                            else if(hh[3:0] == 9) begin
                                hh[3:0] <= 4'h0;
                                hh[7:4] <= 4'h1;
                            end
                            else hh[3:0] <= hh[3:0] + 4'h1; 
                        end
                        else mm[7:4] <= mm[7:4] + 4'h1;
                    end
                    else mm[3:0] <= mm[3:0] + 4'h1;
                end
                else ss[7:4] <= ss[7:4] + 4'h1;
            end
            else ss[3:0] <= ss[3:0] + 4'h1;
                    
        end
    end

endmodule
