`timescale 1ns / 1ps

module top_cpu_10MHz(
    input   logic           clk_100MHz_i,
    input   logic           rst_i,
    
    //PERIFERICOS
    output  logic   [15:0]  led_o,  //leds
    output  logic   [6:0]   seg_o,  //7seg
    output  logic   [3:0]   an_o,   //anodo
    input   logic   [15:0]  sw_i,   //switches
    input   logic           b0_i,   //boton0
    input   logic           b1_i,   //boton1
    input   logic           b2_i,   //boton2
    input   logic           b3_i,   //boton3
    input   logic           vauxp6,
    input   logic           vauxn6,
    input   logic           vp_in,
    input   logic           vn_in
    );
    
    //CLOCK 10MHz
    logic               clk_10MHz;
    logic               locked;
    pll PLL_10MHz(
        .clk_in         (clk_100MHz_i),
        .rst            (rst_i),
        .clk_out        (clk_10MHz),
        .locked         (locked)
    );
    
    //LOGICA DE BOTONES CON FILTROS
    logic   r;
    logic   b0;
    logic   b1;
    logic   b2;
    logic   b3;
    
    Reset reset (
        .clk            (clk_10MHz),
        .sig            (rst_i),
        .out            (r)
    );
    
    Top_filtros filtros_botones(
        .clk            (clk_10MHz),
        .rst            (r),
        .b0_i           (b0_i), 
        .b1_i           (b1_i),
        .b2_i           (b2_i),    
        .b3_i           (b3_i),      
        .b0_o           (b0),
        .b1_o           (b1),
        .b2_o           (b2),
        .b3_o           (b3)      
    );
    
    
    //CPU
    top_cpu cpu_10MHz (
    .clk_i              (clk_10MHz),
    .rst_i              (rst_i),
    
    //PERIFERICOS
    .led_o              (led_o),//leds
    .seg_o              (seg_o),//7seg
    .an_o               (an_o), //anodo
    .sw_i               (sw_i), //switches
    .b0_i               (b0),   //boton0
    .b1_i               (b1),   //boton1
    .b2_i               (b2),   //boton2
    .b3_i               (b3),    //boton3
    .vauxp6             (vauxp6),
    .vauxn6             (vauxn6),
    .vp_in              (vp_in),
    .vn_in              (vn_in)
    );
endmodule
