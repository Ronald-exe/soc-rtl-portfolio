`timescale 1ns/1ps
module tb_con_hacia_abajo;
	
	parameter N      = 4;
	parameter ancho  = 4;

//Variables de entrada

	logic			 clk        = 0;
	logic			 rst        = 1; //Activa el reset
	logic			 habilitar  = 1; //Activa el contador
	logic [ancho - 1 : 0]	 n_i        = N - 1; //Inicializa la cuenta el valor deseado

//Variable de salida

	logic [ancho - 1 : 0]    cuenta_o;

con_hacia_abajo DUT (

.clk		(clk),      
.rst		(rst),
.habilitar	(habilitar),
.n_i		(n_i),
.cuenta_o	(cuenta_o)

);

initial forever #5 clk = ~clk; //Periodo de 10 ns, lo que da un reloj de 100 MHz

initial begin
	
	#10;
			
	rst = 0; //Desactiva el reset

	repeat(100) begin

		@(posedge clk);
	
	end	
	

	$finish;

	
end

always @(posedge clk) begin //Observacion de las salidas

	$display("Tiempo: %0t, Contador: %d", $time, cuenta_o); 

end

endmodule
