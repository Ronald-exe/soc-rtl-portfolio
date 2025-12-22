`timescale 1ns / 1ps

module Reset(
    input   logic           clk,
    input   logic           sig,
    output  logic           out
    );
    
    logic [2:0] filtro = 3'd0;  

    logic sin1;
    logic sin2;
    
    always_ff @(posedge clk) begin
        filtro <= {filtro[1:0], sig}; // Desplazamiento correcto
        
        if (filtro == 3'b111) begin// Se activa solo si se mantiene estable
            sin1 <= 1'b1;
            sin2 <= sin1;
            out <= sin2;
        end else  
            sin1 <= 1'b0;
            sin2 <= sin1;
            out <= sin2;
        end
endmodule