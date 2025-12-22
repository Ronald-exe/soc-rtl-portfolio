`timescale 1ns / 1ps

module sumador #(parameter W = 32)(
    input  logic    [W-1:0] a,
    input  logic    [W-1:0] b,
    output logic    [W-1:0] sum,
    output logic            carry_out,
    output logic            overflow
    );
    assign {carry_out, sum} = a + b;
    assign overflow = (a[W-1] == b[W-1]) && (sum[W-1] != a[W-1]);
endmodule