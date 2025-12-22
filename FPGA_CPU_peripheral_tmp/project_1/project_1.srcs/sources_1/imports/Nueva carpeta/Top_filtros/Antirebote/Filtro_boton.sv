`timescale 1ns / 1ps

module Filtro_boton(
    input   logic   clk,
    input   logic   rst,
    input   logic   sig,
    output  logic   out
    );
    
    logic   [1:0]   filtro;

    always_ff @(posedge clk)begin
        if (rst) begin
            filtro <= 2'b00; 
            out <= 1'b0;         
        end else begin
            filtro <= {filtro[0], sig}; 
            if (filtro == 2'b01) 
                out <= 1'b1;
            else  
                out <= 1'b0;
        end
    end
endmodule
