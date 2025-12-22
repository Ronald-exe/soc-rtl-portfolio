'timescale 1ns/1ps
module tb_fsm;

//Entradas
logic   clk = 0;
logic   rst = 0;
logic 	in_1;
logic	in_2;
logic	in_3;
logic	in_4;
logic	in_5;
logic	in_6;
logic	in_7;
logic	in_8;

//Salidas

logic	out_1;
logic	out_2;
logic	out_3;
logic	out_4;
logic	out_5;
logic	out_6;
logic	out_7;

//entradas
fsm dut(
.clk	        (clk), 
.rst	        (rst),
.valid	        (in_1),
.q0	        (in_2),
.q_1	        (in_3),
.comp_conta	(in_4),
//.n_i		(in_5),
//.in_6	(in_6),
//.in_7	(in_7),
//.in_8	(in_8),

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

con_hacia_abajo Ron(
.clk	        (clk), 
.rst	        (rst),
.n_i		(in_5),
.habilitar	(out_8),
.cuenta_0 	(comp_conta)


);
/*
//entradas estandarizadas
	input logic clk,
	input logic rst,
	
	//Entradas de la FMS
	input logic valid, 
	input logic q0,
	input logic q_1,
	input logic comp_conta,

	//salidas del sistema 
	output logic load_a,
	output logic load_add, 
	output logic load_b,
	output logic shift_q,
	output logic add_sub,
	output logic done, 
	output logic load_con, 
	output logic reduce_con */

initial forever #5 clk = ~clk; //Clock signal

initial begin

	@(posedge clk);
	repeat(100) begin

		in_1 <= $random%2;
		in_2 <= $random%2;
		in_3 <= $random%2;
		in_4 <= $random%2;
		//in_5 <= $random%2;
		//in_6 <= $random%2;
		//in_7 <= $random%2;
		//in_8 <= $random%2;

	end
	@(posedge clk);
	@(posedge clk);
	$finish;

end

endmodule
