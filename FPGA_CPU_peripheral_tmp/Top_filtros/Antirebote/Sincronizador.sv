`timescale 1ns / 1ps

module Sincronizador(
    input   logic   clk,
    input   logic   rst,
    input   logic   sig,
    output  logic   out
    );
    
    logic etapa_1;
    logic etapa_2;
    
        
    
    always_ff @(posedge clk)begin
        if (rst) begin
            etapa_1 <= 1'b0;
            etapa_2 <= 1'b0;
            out <= 1'b0;
            
        end else begin
            etapa_1 <= sig;
            etapa_2 <= etapa_1;
            out <= etapa_2; 
            
        end     
    end
endmodule


