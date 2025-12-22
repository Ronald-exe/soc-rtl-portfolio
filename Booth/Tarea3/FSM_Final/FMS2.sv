module FMS_Booth(
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
	output logic reduce_con

);
	//son los bits representativos de cada estado
	enum logic [2:0] {
		espera_1,
		comp_Qq, // donde Q es el Q_0 y q es el Q_-1
		suma,    // representa hq+m
		resta,  // representa hq-m
		finalizar // fianalizacion de la fms
	} estado, sig_estado; // estos son cables

	always_ff @(posedge clk) begin    //funciona en flanco positivo
		if(!rst) estado <= espera_1; // esta funcion genera los cambios de estado
		else estado <= sig_estado;
	end  
		// definir los cambios de estados
	always_comb begin
		case(estado) //transiciones de estados
		espera_1:
			if(valid ==0) sig_estado = espera_1;
			else sig_estado = comp_Qq;
		comp_Qq:
			if((q0==0)&&(q_1==1)) sig_estado = suma;
			else if((q0==1)&&(q_1==0)) sig_estado = resta;
			else sig_estado = finalizar;
		suma:
			sig_estado = finalizar;    
		resta:
			sig_estado = finalizar;
		finalizar:
			if(comp_conta==1) sig_estado = espera_1;
			else sig_estado =comp_Qq;

		default:
			sig_estado = espera_1;
		endcase
	end

	//logica de salida

	always_comb begin // salidas incializadas en 0 de la maquina
		load_a       = 0;
		load_add     = 0;
		load_b       = 0;
		shift_q      = 0;
		add_sub      = 0;
		done         = 0;
		load_con     = 0;
		reduce_con   = 0;

	case(estado) // salidas de los estados de la maquina
		espera_1:
			if(valid ==0) begin 
			{load_a, load_add, load_b,shift_q, done, load_con, reduce_con } = 7'b1010010;
			end
		comp_Qq:
			if((q0==0)&&(q_1==1))
			{load_a, load_add, load_b,shift_q, add_sub, done, load_con, reduce_con }= 8'b01001000;
			else if((q0==1)&&(q_1==0))
			{load_a, load_add, load_b,shift_q, add_sub, done, load_con, reduce_con } =8'b01000000;
			else begin
			{load_a, load_add, load_b,shift_q, done, load_con, reduce_con } = 7'b0001001;
			end

		suma:
			{load_a, load_add, load_b,shift_q, add_sub, done, load_con, reduce_con }= 7'b0001001;
		resta:
			{load_a, load_add, load_b,shift_q, add_sub, done, load_con, reduce_con }=7'b0001001;
		finalizar:
			if(comp_conta==1) begin
			{load_a, load_add, load_b,shift_q, add_sub, done, load_con, reduce_con }=8'b00000100;
			end else begin
			{load_a, load_add, load_b,shift_q, done, load_con, reduce_con }=7'b0000000;
			end
	endcase
end


endmodule


