module sub_lectura

#(parameter ancho = 4)
(
	input  logic 		      clk,
	input  logic 		      rst,
	input  logic [ancho - 1 : 0]  in,
	output logic [ancho - 1 : 0]  out
);
	//Flip-flops
	logic [ancho - 1 : 0] ff_1 = 0;
	logic [ancho - 1 : 0] ff_2 = 0;

	//Primera etapa


	always @(posedge clk) begin

		if (rst) begin  //Reinicio de los flip-flops

			ff_1 <= '0;
			ff_2 <= '0; //4'b0000	
			out <= '0;			
	
		end else begin
	
			//Primera etapa
			ff_1 <= in;

			//Segunda etapa
			ff_2 <= ff_1;


			//Salida
			out <= ff_2;
		end

	end

endmodule
