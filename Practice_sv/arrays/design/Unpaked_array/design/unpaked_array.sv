module tb;
	byte 	stack [8]; 		// depth = 8, 1 byte wide variable

	initial begin
		// Assign random values to each slot of the stack
		foreach (stack[i]) begin
			stack[i] =byte'( $random);
			$display ("Assign 0x%0h to index %0d", stack[i], i);
		end

		// Print contents of the stack
		$display ("stack = %p", stack);
    $finish;
	end
endmodule
