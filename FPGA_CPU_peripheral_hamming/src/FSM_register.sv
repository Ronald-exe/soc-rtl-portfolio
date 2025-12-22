`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/27/2025 09:56:03 AM
// Design Name: 
// Module Name: FSM_register
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


module FSM_register(
    input logic clk,
    input logic rst,
    input logic[31:0] in,
    output logic      signal,
    output logic [3:0]out
    );
    
typedef enum logic [0:0] {
    Inicio,
    Fin
    } estado_t;
    
    estado_t estado, sig_estado;
    
    always_ff @(posedge clk or posedge rst) begin 
        if(rst) begin
            estado <= Inicio;
        end else begin
            estado <=sig_estado;
        end 
    end
    
    always_comb begin
        sig_estado = estado;
        case (estado)
            Inicio: sig_estado = Fin;
            Fin:    sig_estado = Inicio;
        endcase
    end
    
    
    always_comb begin
        case (estado)
            Inicio: begin 
                out = in[3:0];
                signal = 1'b1;
            end
            Fin: begin   
                out = in[7:4];
                signal = 1'b0;
              end
        endcase
    end
endmodule

