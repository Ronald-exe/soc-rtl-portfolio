`timescale 1ns / 1ps

module top_basys_cpu(
    input   logic           clk,
    input   logic           btnC,
    
    output  logic   [15:0]  led,    //leds
    output  logic   [6:0]   seg,    //7seg
    output  logic   [3:0]   an,     //anodo
    input   logic   [15:0]  sw,     //switches
    input   logic           btnD,   //boton0
    input   logic           btnR,   //boton1
    input   logic           btnL,   //boton2
    input   logic           btnU,   //boton3
    input   logic           vauxp6,
    input   logic           vauxn6,
    input   logic           vp_in,
    input   logic           vn_in
    );
    
    //CPU FINAL
    top_cpu_10MHz cpu_pll (
    .clk_100MHz_i   (clk),
    .rst_i          (btnC),

    //PERIFERICOS
    .led_o          (led),  //leds
    .seg_o          (seg),  //7seg
    .an_o           (an),   //anodo
    .sw_i           (sw),   //switches
    .b0_i           (btnD), //boton0
    .b1_i           (btnR), //boton1
    .b2_i           (btnL), //boton2
    .b3_i           (btnU), //boton3
    .vauxp6         (vauxp6),
    .vauxn6         (vauxn6),
    .vp_in          (vp_in),
    .vn_in          (vn_in)
    );
    
endmodule
