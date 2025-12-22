`timescale 1ns / 1ps

module mux_2 #(parameter W = 32)(
    input   logic           sel,
    input   logic   [W-1:0] a,
    input   logic   [W-1:0] b,
    output  logic   [W-1:0] y
);  
    assign y = sel ? b : a;  
endmodule