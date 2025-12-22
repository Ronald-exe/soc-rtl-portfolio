'timescale 1ns/1ps
module tb_fsm;
parameter [area = 4];
//Entradas
logic			clk = 0;
logic			rst = 1;
logic			valid_1;
logic			valid_2;
logic			q_0;
logic			q_1;
logic			comparador;
logic	[area - 3:0]	limite;
logic	[area - 3:0]	contador;
logic	[area - 1:0]	a;
logic	[area - 1:0]	b;

//Salidas

logic			out_1; // load a
logic			out_2; // load add
logic			out_3; // load b
logic			out_4; // shift
logic			out_5; // add_sub
logic			out_6; // done
logic			out_7; // load_con
logic			out_8; // reduce_con
logic	[area*2 -1:0]	Respuesta;

//Conecciones

sub_lectura dat(
.clk		(clk), 
.rst		(rst),
.in		(valid_1),
.out		(valid_2)
);

fsm det(
//entradas
.clk		(clk), 
.rst		(rst),
.valid		(valid_2),
.q0		(q_0),
.q_1		(q_1),
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

mult_with_no_sm dit(
.clk			(clk), 
.rst			(out_7),
.add_sub		(out_5),
.load_A			(out_1), 
.load_add		(out_2),
.load_B			(out_3),
.A			(a),
.B			(b), 
.shift_HQ_LQ_Q_1	(out_4),
.Y			(Respuesta),
.Q_LSB[1]		(q_0),
.Q_LSB[0]		(q_1)

);

con_hacia_abajo dot(
.clk		(clk), 
.rst		(rst),
.n_i		(limite),
.habilitar	(out_8),
.cuenta_0	(contador),
.fin		(comparador)
);



initial forever #5 clk = ~clk; //Clock signal

initial begin

	@(posedge clk);
	
	limite = 4;
	rst = 0;
	

	valid_1 <= $random%2;
	a <= $random%2;
	b <= $random%2;

	$display("A: %d, B: %d, Respuesta: %d", a, b, Respuesta); // imprime respuesta
	
	$finish;

end

endmodule
