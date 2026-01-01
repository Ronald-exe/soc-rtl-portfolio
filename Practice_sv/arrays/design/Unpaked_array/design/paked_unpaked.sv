module tb;
  bit [3:0][7:0] 	stack [2][4]; 		// 2 rows, 4 cols

	initial begin
		// Assign random values to each slot of the stack
		foreach (stack[i])
          foreach (stack[i][j]) begin
            stack[i][j] = $random;
            $display ("stack[%0d][%0d] = 0x%0h", i, j, stack[i][j]);
			end

		// Print contents of the stack
		$display ("stack = %p", stack);

		// Print content of a given index
        $display("stack[0][0][2] = 0x%0h", stack[0][0][2]);
        $finish;
	end
endmodule
