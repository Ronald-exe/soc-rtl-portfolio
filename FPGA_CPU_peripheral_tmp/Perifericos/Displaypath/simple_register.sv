`timescale 1ns / 1ps

module simple_register #(parameter W = 32)(
    input logic             clk,
    input logic             rst,
    
    input logic             en,
    input logic     [W-1:0] in,
    output logic    [W-1:0] out
    );
    always_ff @(posedge clk) begin
        if      (rst)    out   <= '0;
        else if (en) out   <= in;
    end
endmodule
