`timescale 1ns / 1ps

module Switches(
    input   logic           clk_i,
    input   logic           rst_i,
    
    input   logic   [15:0]  sw_i,
    input   logic           b0_i,
    input   logic           b1_i,
    input   logic           b2_i,
    input   logic           b3_i,
    output  logic   [31:0]  data_btn_sw_o
    );    
    always_ff @(posedge clk_i or posedge rst_i) begin
        if (rst_i)  data_btn_sw_o <= 16'h0000;
        else        data_btn_sw_o <= {12'd0, b3_i, b2_i, b1_i, b0_i, sw_i};
    end
endmodule
