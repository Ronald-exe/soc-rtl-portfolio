`timescale 1ns / 1ps

module Top_Antirebote(
    
    input   logic           clk,
    input   logic           rst,
    input   logic           Boton,
    input   logic           modo,
    input   logic           sig_boton_ext,
    
    output  logic           o_boton
    );
    
    logic   sig_filtro;
    logic   sig_sincronizador;
    logic   sig_mux;
    
    Filtro_Antirebotes dat (
    .clk            (clk),
    .rst            (rst),
    .sig            (Boton),
    .out            (sig_filtro)
    );
    
    MUX_Filtro mux_f (
    .clk            (clk),
    .rst            (rst),
    .modo           (modo),
    .sig            (sig_filtro),
    .sig_ext        (sig_boton_ext),
    .out            (sig_mux)
    );
    
    Sincronizador det (
    .clk            (clk),
    .rst            (rst),
    .sig            (sig_mux),
    .out            (sig_sincronizador)
    );
    
    Filtro_boton dit (
    .clk            (clk),
    .rst            (rst),
    .sig            (sig_sincronizador),
    .out            (o_boton)
    );
    
    
endmodule
