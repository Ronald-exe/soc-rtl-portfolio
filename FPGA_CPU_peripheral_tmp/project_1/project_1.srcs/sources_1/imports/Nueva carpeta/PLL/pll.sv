`timescale 1ns / 1ps

module pll(
    input  logic    clk_in,
    input  logic    rst,
    output logic    clk_out,
    output logic    locked
    );
    logic           clk_pll;
    logic           locked_pll;
    assign clk_out = clk_pll & locked;
    
     clk_wiz_10MHz clk_10MHz(
        .clk_in1    (clk_in),
        .reset      (rst),
        .clk_out1   (clk_pll),
        .locked     (locked_pll)
    );
    
    always @(posedge clk_pll or posedge rst) begin
        if(rst) locked <= 0;
        else    locked <= locked_pll; 
    end
endmodule
