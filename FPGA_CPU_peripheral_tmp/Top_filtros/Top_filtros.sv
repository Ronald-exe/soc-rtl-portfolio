`timescale 1ns / 1ps

module Top_filtros(
    input   logic           clk,
    input   logic           rst,
    input   logic           b0_i,
    input   logic           b1_i,
    input   logic           b2_i,
    input   logic           b3_i,
    
    output  logic           b0_o,
    output  logic           b1_o,
    output  logic           b2_o,
    output  logic           b3_o
    );

    Top_Antirebote b0(
        .clk            (clk),
        .rst            (rst),
        .Boton          (b0_i),
        .modo           ('b0),
        .sig_boton_ext  ('b0),
        .o_boton        (b0_o)
    );
    
    Top_Antirebote b1(
        .clk            (clk),
        .rst            (rst),
        .Boton          (b1_i),
        .modo           ('b0),
        .sig_boton_ext  ('b0),
        .o_boton        (b1_o)
    );
    
    Top_Antirebote b2(
        .clk            (clk),
        .rst            (rst),
        .Boton          (b2_i),
        .modo           ('b0),
        .sig_boton_ext  ('b0),
        .o_boton        (b2_o)
    );
    
    Top_Antirebote b3(
        .clk            (clk),
        .rst            (rst),
        .Boton          (b3_i),
        .modo           ('b0),
        .sig_boton_ext  ('b0),
        .o_boton        (b3_o)
    );
endmodule

