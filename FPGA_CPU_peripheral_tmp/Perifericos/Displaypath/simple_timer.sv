`timescale 1ns / 1ps

module simple_timer #(parameter MOD = 20000000)(
    input  logic        clk,
    input  logic        rst, 
    input  logic        en,
    output logic        pulse
    );
    logic [($clog2(MOD)-1):0]     conta_o;
    
    always_ff @(posedge clk) begin
        if(rst || ~en) begin
            conta_o <= 0;
            pulse   <= 0;
        end
        else begin
            if (conta_o < MOD - 1) begin
                conta_o <= conta_o + 1;
                pulse   <= 0;
            end
            else begin
                conta_o <= 0;
                pulse   <= 1;
            end
        end
     end
endmodule