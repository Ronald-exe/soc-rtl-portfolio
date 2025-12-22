module con_hacia_abajo
	#(parameter ancho = 3)
(
	//entradas
	input logic	clk,
	input logic	rst,
	input logic	habilitar,
	input logic 	inicializar,
	input logic	[ancho - 2 : 0]	n_i,
	//salidas
	output logic	fin,
	output logic	[ancho - 2 : 0]	cuenta_o = 3 
);

always_ff @(posedge clk) begin
	if(rst ==1 || inicializar ==1) begin
		cuenta_o <= n_i;  //Cuando se inicia empieza la cuenta en el valor de n_i
		fin <= 0;
	end 
	else if (habilitar ==1) begin //Cuando se habilita el contador
		
		if(cuenta_o == 0) begin
			cuenta_o <= n_i; //Vuelve a iniciar la cuenta cuando es cero
			fin <= 1;
		end else begin
			cuenta_o <= cuenta_o - 1'b1; //Si no es cero, empieza a contar hacia abajo desde el valor que se desee
			fin <= 0;
		end
	end		
end

endmodule
