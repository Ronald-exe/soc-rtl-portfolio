module con_hacia_abajo
	#(parameter ancho = 2)
(
	input logic	clk,
	input logic	rst,
	input logic	habilitar,
	input logic	[ancho - 1 : 0]	n_i,
	output logic	fin,
	output logic	[ancho - 1 : 0]	cuenta_o    
);

always_ff @(posedge clk) begin
	if(rst) begin
		cuenta_o <= n_i;  //Cuando se inicia empieza la cuenta en el valor de n_i
	end else if (habilitar) begin //Cuando se habilita el contador

		if(cuenta_o == 0) begin

			cuenta_o <= n_i; //Vuelve a iniciar la cuenta cuando es cero
			fin <= 1;
		end

		else begin

			cuenta_o <= cuenta_o - 1'b1; //Si no es cero, empieza a contar hacia abajo desde el valor que se desee
			fin <= 0;
	    

		end
	end
end


endmodule
