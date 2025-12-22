`timescale 1ns / 1ps


module MUX_Filtro(
    input   logic   clk,
    input   logic   rst,
    input   logic   sig,
    input   logic   modo,
    input   logic   sig_ext,
    output  logic   out
    );
    
    logic   [1:0]   filtro;
    
    always_ff @(posedge clk)begin
        if (rst) begin
           out <= 1'b0;
        end else begin
            filtro <= {filtro[0], sig_ext}; 
                case (modo)
                    1'b0: out <= sig;           
                    1'b1: begin
                            if (filtro == 2'b01) out <= sig_ext;
                            else out <= 1'b0;
                          end
                    default: out <= 1'b0;
                endcase
            
        end
    end
endmodule
