module sub_lectura

(
	input  logic clk,
	input  logic rst,
	input  logic  in,
	output logic out

);

	//Flip-flops
	logic ff_1;
	logic ff_2;

	//Primera etapa
	always @(posedge clk or posedge rst) begin
		if (rst)
			ff_1 <= 1'b0;
		else
			ff_1 <= in;
	end

	//Segunda etapa
	always @(posedge clk or posedge rst) begin
	
		if (rst)
			ff_2 <= 1'b0;
		else
			ff_2 <= ff_1;
	end

	//Tercera etapa
	always @(posedge clk or posedge rst) begin
	
		if (rst)
			out <= 1'b0;
		else
			out <= ff_2;

	end

endmodule
