`timescale 1ns/1ps
module tb_fsm;
parameter area = 4;
//Entradas de conexion generales del todo el sistema

logic			clk = 0;	//señal reloj
logic			rst;		//señal de reset

//conexiones internas de las entradas de la FSM

logic			valid_1;	//señal de boton
logic			valid_2;	//señal de retardo del boton

logic	[area - 3:0]	q0_1;  		//arreglo interno de q0 , q1


logic			comparador; //salida del contador cuando es igual a 0


//conexiones internas de las salidas de la FSM

logic			out_1; // load a
logic			out_2; // load add
logic			out_3; // load b
logic			out_4; // shift
logic			out_5; // add_sub
logic			out_6; // done
logic			out_7; // load_con
logic			out_8; // reduce_con


//Datapath datos

	//numeros a multiplicar
logic	[area - 1:0]	a1;		//señal de a
logic	[area - 1:0]	a2;		//señal de retardo a
logic	[area - 1:0]	b1;		//señal de b
logic	[area - 1:0]	b2;		//señal de retardo b

	//respuesta de la multiplicación
logic	[area*2 -1:0]	Respuesta;

//Contador
	//inicializador de valor del contador, se activa al activar load con
logic	[area - 3:0]	limite;

	//conexión interna de la salida del contador con el comparador
logic	[area - 3:0]	contador; 


//Sistemas de lectura para valid, A y B

	//Valid
sub_lectura #(.ancho(1)) valid_r(
.clk		(clk), 
.rst		(rst),
.in		(valid_1),
.out		(valid_2)
);

	//A
sub_lectura #(.ancho(4)) a_r(
.clk		(clk), 
.rst		(rst),
.in		(a1),
.out		(a2)
);

	//B
sub_lectura #(.ancho(4)) b_r(
.clk		(clk), 
.rst		(rst),
.in		(b1),
.out		(b2)
);


//SISTEMA FSM MEALY
fsm chamba(

//entradas
.clk		(clk), 
.rst		(rst),
.valid		(valid_2),
.q0_1		(q0_1),
.comp_conta	(comparador),
//salidas
.load_a		(out_1), 
.load_add	(out_2),
.load_b		(out_3),
.shift_q	(out_4),	
.add_sub	(out_5),
.done		(out_6),
.load_con	(out_7),
.reduce_con	(out_8)
);

//Sistema de Datapath
mult_with_no_sm datapath(

.clk			(clk), 
.rst			(rst), 
.add_sub		(out_5),
.load_A			(out_1), 
.load_add		(out_2),
.load_B			(out_3),
.A			(a2),
.B			(b2), 
.shift_HQ_LQ_Q_1	(out_4),
.Y			(Respuesta),
.Q_LSB			(q0_1)
);

//Sistema de Contador
con_hacia_abajo dot(
//entradas
.clk		(clk), 
.rst		(rst),
.n_i		(limite),
.inicializar	(out_7),
.habilitar	(out_8),
//salidas
.cuenta_o	(contador),
.fin		(comparador)
);


always begin
        #5 clk = ~clk;  // Invierte el reloj cada 5 unidades de tiempo
end

initial begin
        // Inicialización del reloj y el reset
        clk = 0;
        rst = 1;
	
	//se define el limite del contador
	limite = area-1;
	
	//Se realiza el procedimiento 3 veces
	repeat (3) begin

		//valores random para A y B
		a1 = $random;
		b1 = $random;
		
		//Boton apagado inicialmente
		valid_1 = 0;
		
		
		#10
		@(posedge clk)
		rst <=1;
		valid_1 <= 0;
		@(posedge clk)
		rst <=0;
		@(posedge clk)
		valid_1 <= 1;
		@(posedge clk)
		valid_1 <= 0;
		
		//Pasa 1 segundo antes de presionar el botón otra vez
	     	#1000

		//Mostrar resultados en binario
		$display("a: 		%b", a2);
		$display("b: 		%b", b2);
		$display("Respuesta: 	%b", Respuesta);
	end
	$finish;
end
endmodule
