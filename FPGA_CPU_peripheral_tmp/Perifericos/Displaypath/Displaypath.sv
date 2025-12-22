`timescale 1ns / 1ps

module Displaypath (
    input logic             clk,
    input logic             rst,
    
    input logic     [15:0]  in,
    input logic             we,
    output logic    [3:0]   out_an,  
    output logic    [6:0]   out_seg
    );

    logic                   pulse_1milisec_done;
    logic           [1:0]   o_counter_display;
    logic           [15:0]  display_data;
    logic           [3:0]   o_mux_4;
    
    simple_register #(.W(16)) Register_n16 (
    .clk            (clk),
    .rst            (rst),
    .en             (we),
    .in             (in),
    .out            (display_data)
    );
    
    simple_timer #(.MOD(10000)) n_1milisec (
    .clk            (clk),
    .rst            (rst),
    .en             ('b1),
    .pulse          (pulse_1milisec_done)
    );
    
    simple_counter #(.MOD(4), .i(0)) C_Display (
    .clk            (clk),
    .rst            (rst),
    .en             (pulse_1milisec_done),
    .count          (o_counter_display)
    );
    
    deco_an Deco1 (
    .IN     (o_counter_display),
    .OUT    (out_an)
    );
    
    mux_4 #(.W(4)) mux_7seg (
        .sel        (o_counter_display),
        .a          (display_data[3:0]),
        .b          (display_data[7:4]),
        .c          (display_data[11:8]),
        .d          (display_data[15:12]),
        .y          (o_mux_4)
    );
    
    deco_seg Deco2 (
    .IN     (o_mux_4),
    .OUT    (out_seg)
    );
    
endmodule
