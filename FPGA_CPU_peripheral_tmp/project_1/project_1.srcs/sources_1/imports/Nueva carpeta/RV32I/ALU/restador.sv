`timescale 1ns / 1ps

module restador #(parameter W = 32)(
    input  logic    [W-1:0] a,
    input  logic    [W-1:0] b,
    output logic    [W-1:0] res,
    output logic            borrow,
    output logic            negative,
    output logic            overflow
    );
    logic                   carry_out;
    assign {carry_out,res} = a + ~b +1;
    assign borrow = carry_out;
    assign negative = res[W-1];
    assign overflow = (a[W-1] ^ b[W-1]) & (a[W-1] ^ res[W-1]);
endmodule