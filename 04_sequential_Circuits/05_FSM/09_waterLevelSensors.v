module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 
    parameter belowS1=0, 
    		S1_S2=1, // between S1 and S2 (low to high) 
    		S2_S3=2, // between S2 and S3 (low to high) 
    		aboveS3=3, 
    		S3_S2=4, // b/w S3 and S2 (high to low)
    		S2_S1=5; // b/w S2 and S1 (high to low)
    reg [2:0] state, next;
    
    reg [3:0] fr;
    assign {fr3,fr2,fr1,dfr} = fr;
    
   // next state combinational logic
    always @(*) begin
        case(state)
            belowS1:next = (s[1]) ? S1_S2 	: belowS1;	
            S1_S2: 	next = (s[2]) ? S2_S3 	: ((s[1]) ? S1_S2 : belowS1);	// goes to state below S1 since dfr is on this state
            S2_S1: 	next = (s[2]) ? S2_S3 	: ((s[1]) ? S2_S1 : belowS1);
            S2_S3: 	next = (s[3]) ? aboveS3 : ((s[2]) ? S2_S3 : S2_S1);
            S3_S2: 	next = (s[3]) ? aboveS3 : ((s[2]) ? S3_S2 : S2_S1);
            aboveS3:next = (s[3]) ? aboveS3 : S3_S2;		// if s3=0 then goes to S3_S2 else remain in aboveS3;           
            default : next = belowS1;
        endcase
    end
    
    // next state sequential transition
    always @(posedge clk) begin
        if (reset) 
            state <= belowS1;
        else 
            state <= next;
    end
    
    // output state logic
    always @(*) begin
        fr = 0;
        case(state)
            belowS1: fr = 4'b1111;
            S1_S2: fr = 4'b0110;
            S2_S3: fr = 4'b0010;
            S3_S2: fr = 4'b0011;
            S2_S1: fr = 4'b0111;
            default: fr = 0;
        endcase
    end

endmodule
