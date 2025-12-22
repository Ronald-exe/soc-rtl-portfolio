`timescale 1ns / 1ps

module Filtro_Antirebotes(
    input   logic   clk,
    input   logic   rst,
    input   logic   sig,
    output  logic   out
    );
    
    logic   [3:0]   filtro;

    always_ff @(posedge clk)begin
        if (rst) begin
            filtro <= 4'b0000;
            out <= 1'b0;        
        end else begin
            filtro <= {filtro[2:0], sig}; 
            if (filtro == 4'b1111) 
                out <= 1'b1;
            else  
                out <= 1'b0;
        end
    end
    
endmodule
