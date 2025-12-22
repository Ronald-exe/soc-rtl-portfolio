`timescale 1ns / 1ps

module adder #(parameter W = 32)(
    input   logic   [W-1:0] a,
    input   logic   [W-1:0] b,
    output  logic   [W-1:0] sum
);
    assign sum = a + b; 
endmodule