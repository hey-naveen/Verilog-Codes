module top_module( input in, output out );
	
	assign out = in;
	// Note that wires are directional.
  // assign in = out will reverse the data flow from out to in.
	
endmodule
