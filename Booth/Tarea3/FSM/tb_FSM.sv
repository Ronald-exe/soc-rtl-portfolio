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

fsm dut(
.clk	(clk), //Entradas
.rst	(rst),
.in_1	(in_1),
.in_2	(in_2),
.in_3	(in_3),
.in_4	(in_4),
.in_5	(in_5),
.in_6	(in_6),
.in_7	(in_7),
.in_8	(in_8),
.out_1	(out_1), //Salidas
.out_2	(out_2),
.out_3	(out_3),
.out_4	(out_4),	
.out_5	(out_5),
.out_6	(out_6),
.out_7	(out_7));

initial forever #5 clk = ~clk; //Clock signal

initial begin

	@(posedge clk);
	repeat(100) begin

		in_1 <= $random%2;
		in_2 <= $random%2;
		in_3 <= $random%2;
		in_4 <= $random%2;
		in_5 <= $random%2;
		in_6 <= $random%2;
		in_7 <= $random%2;
		in_8 <= $random%2;

	end
	@(posedge clk);
	@(posedge clk);
	$finish;

end

endmodule
