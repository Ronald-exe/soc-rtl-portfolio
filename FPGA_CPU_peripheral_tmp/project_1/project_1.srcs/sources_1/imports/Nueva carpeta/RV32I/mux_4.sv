`timescale 1ns / 1ps

module mux_4 #(parameter W = 32)(
    input   logic   [1:0]   sel,
    input   logic   [W-1:0] a,
    input   logic   [W-1:0] b,
    input   logic   [W-1:0] c,
    input   logic   [W-1:0] d,
    output  logic   [W-1:0] y
);
    always_comb begin
        case(sel)
            2'b00:   y = a;
            2'b01:   y = b;
            2'b10:   y = c;
            2'b11:   y = d;
            default: y = '0;
        endcase
    end
endmodule