`timescale 1ns/1ps

module tb_sub_lectura;

	parameter ancho = 4;

	//Entradas
	logic 		       clk  = 0;
	logic 		       rst  = 1;
	logic [ancho - 1 : 0]  in;

	//Salidas
	logic [ancho - 1 : 0]  out;

sub_lectura DUT (

.clk		(clk),
.rst		(rst),
.in		(in),
.out		(out)

);



initial forever #5 clk = ~clk;

initial begin

	in = 4'b1101;

	#5
	rst = 0;

	@(posedge clk);
	@(posedge clk);
	@(posedge clk);

	#10	
	$finish;

end

always @(posedge clk) begin

	$monitor("Tiempo: %0t, Entrada: %b, Salida %b", $time, in, out);

end

endmodule
