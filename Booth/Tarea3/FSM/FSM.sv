modulo FSM (
	//Entradas
	input logic	clk,
	input logic	rst,
	input logic	valid,
	input logic	Q_0,
	input logic	Q_1,
	input logic	comp_con,

	//Salidas
	output logic	load_A,
	output logic	load_add,
	output logic	load_B,
	output logic	shift
	output logic	add_sub,
	output logic	done,
	output logic	load_con,
	output logic	reduce_con
	
);

	//Variables de estado

	typedef enum logic [2:0] {
		e_esperar,
		e_comparar,
		e_sumar,
		e_restar,
		e_finalizar
	}	estado_t;

	estado_t estado, siguiente_estado;

	//Blque de memoria

	always_ff @(posedge clk) begin
		if(rst) estado <= '0;
		else	estado <= siguiente_estado;
	end

	//Lógica de siguiente estado y salida
	load_a       = 0;
	load_add     = 0;
	load_b       = 0;
	shift_q      = 0;
	add_sub      = 0;
	done         = 0;
	load_con     = 0;
	reduce_con   = 0;
	always_comb begin
		case(estado)
			e_esperar:	if(!valid) begin
						siguiente_estado = e_esperar;
						load_A = 0;
						load_add = 0;
						load_B = 0;
						shift = 0:
						done = 0;
						load_con = 0;
						reduce_con = 0;

					end else begin
						siguiente_estado = e_comparar;
						load_A = 1;
						load_add = 0;
						load_B = 1;
						shift = 0:
						done = 0;
						load_con = 1;
						reduce_con = 0;
					end

			e_comparar:	if(!Q_0 && Q_1 == 1)begin
						siguiente_estado = e_sumar;
						load_A = 0;
						load_add = 1;
						load_B = 0;
						shift = 0:
						add_sub = 1;
						done = 0;
						load_con = 0;
						reduce_con = 0;

					end else if(!Q_1 && Q_0 == 1) begin
						siguiente_estado = e_restar;
						load_A = 0;
						load_add = 1;
						load_B = 0;
						shift = 0:
						add_sub = 0;
						done = 0;
						load_con = 0;
						reduce_con = 0;

					end else(Q_1 == Q_0) begin 
						siguiente_estado = e_finalizar;
						load_A = 0;
						load_add = 0;
						load_B = 0;
						shift = 1:
						done = 0;
						load_con = 0;
						reduce_con = 1;
					end
			
			e_sumar:	siguiente_estado = e_finalizar;
					load_A = 0;
					load_add = 0;
					load_B = 0;
					shift = 1:
					done = 0;
					load_con = 0;
					reduce_con = 1;

			e_restar:	siguiente_estado = e_finalizar;
					load_A = 0;
					load_add = 0;
					load_B = 0;
					shift = 1:
					done = 0;
					load_con = 0;
					reduce_con = 1;

			e_finalizar:	if(!comp_con) begin
						siguiente_estado = e_comparar;
						load_A = 0;
						load_add = 0;
						load_B = 0;
						shift = 0:
						done = 0;
						load_con = 0;
						reduce_con = 0;

					end else 
						siguiente_estado = e_esperar;
						load_A = 0;
						load_add = 0;
						load_B = 0;
						shift = 0:
						done = 1;
						load_con = 0;
						reduce_con = 0;
					end

			default:	siguiente_estado = e_esperar;
		endcase
	end
endmodule


