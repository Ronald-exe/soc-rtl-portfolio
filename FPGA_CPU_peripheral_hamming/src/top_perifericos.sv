`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/27/2025 08:37:38 AM
// Design Name: 
// Module Name: top_perifericos
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top_perifericos(
input logic         clk,
input logic         rst,
input logic         wr_i     ,
input logic         reg_sel_i,
input logic  [31:0] entrada_i,
output logic [31:0] salida_o
);

logic        wr_1          ;
logic [31:0] sal_1_data_ent;
logic [31:0] sal_2_data_ent;
logic [31:0] sal_3_data_sal;
logic [3:0]  sal_fsm;
logic        signal;

assign wr_1 = ~reg_sel_i && wr_i;

registro_base registro_entrada(
.clk      (clk),
.rst      (rst),
.wr       (wr_1),
.data_in  (entrada_i),
.data_out (sal_1_data_ent)
);

FSM_register FSM(
    .clk(clk),
    .rst(rst),
    .in(sal_1_data_ent),
    .signal(signal),
    .out(sal_fsm)
    );

hamming_code hamming_1(
.data_men_i(sal_fsm),
.signal    (signal),
.sal       (sal_2_data_ent)
);

registro_base registro_salida(
.clk      (clk),
.rst      (rst),
.wr       (1'b1),
.data_in  (sal_2_data_ent),
.data_out (sal_3_data_sal)
 );
 
mux_2a1 mux_1(
.s_i     (reg_sel_i),
.a_i     (sal_1_data_ent),
.b_i     (sal_3_data_sal),
.sal_o   (salida_o)
); 

endmodule
