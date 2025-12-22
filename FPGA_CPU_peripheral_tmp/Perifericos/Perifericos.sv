`timescale 1ns / 1ps

module Perifericos(
    input  logic            clk_i,
    input  logic            rst_i,
    
    //CONEXION CPU CON PERIFERICOS
    input  logic    [13:0]  addr_byte_i,  // address_i[15:2] de la cpu para direccionamieto por byte. Se omiten los 2 bits LSB
    input  logic    [31:0]  write_i,
    output logic    [31:0]  read_o,
    input  logic            we_i,
    
    //CONEXION RAM CON PERIFERICOS
    output logic    [7:0]   addr_ram_o,
    output logic    [31:0]  write_ram_o,
    input  logic    [31:0]  data_ram_i,
    output logic            we_ram_o,
    
    //PERIFERICOS
    output logic    [15:0]  led_o,  //leds
    output logic    [6:0]   seg_o,  //7seg
    output logic    [3:0]   an_o,   //anodo
    input  logic    [15:0]  sw_i,   //switches
    input  logic            b0_i,   //boton0
    input  logic            b1_i,   //boton1
    input  logic            b2_i,   //boton2
    input  logic            b3_i   //boton3
    //FALTA SENSOR
    );
    
    //CONEXIONES DEL SELECTOR
    
    //direcciones de los perifericos
    logic                   addr_timer;
    logic                   addr_tmp;
    //habilitadores de escritura para los perifericos
    logic                   we_led;
    logic                   we_7seg;
    logic                   we_timer;
    logic                   we_tmp;
    //datos de entrada de los perifericos para lectura en el cpu
    logic           [31:0]  data_btn_sw;
    logic           [31:0]  data_timer;
    logic           [31:0]  data_tmp;
    
    //Valor de salida del dato de escritura para RAM
    assign write_ram_o = write_i;
    
    //SELECTOR  ***********************************************************************
    
    Selector Data_map (
    //direccion del cpu
    .addr_byte_i        (addr_byte_i),  // address_i[15:2] de la cpu para direccionamieto por byte. Se omiten los 2 bits LSB
    //direcciones de los perifericos
    .addr_timer_o       (addr_timer),
    .addr_tmp_o         (addr_tmp),
    //habilitador de escritura del cpu para los perifericos
    .we_i               (we_i),
    //habilitadores de escritura para los perifericos
    .we_led_o           (we_led),
    .we_7seg_o          (we_7seg),
    .we_timer_o         (we_timer),
    .we_tmp_o           (we_tmp),
    //datos de entrada de los perifericos para lectura en el cpu
    .data_btn_sw_i      (data_btn_sw),
    .data_timer_i       (data_timer),
    .data_tmp_i         (data_tmp),
    //RAM
    .addr_ram_o         (addr_ram_o),
    .data_ram_i         (data_ram_i),
    .we_ram_o           (we_ram_o),
    //dato de lectura para el cpu
    .read_o             (read_o)
    );
    
    //PERIFERICOS   *******************************************************************
    
    //LEDs
    LEDs Leds (
        .clk_i              (clk_i),
        .rst_i              (rst_i),
        .we_led_i           (we_led),
        .led_i              (write_i[15:0]),
        .led_o              (led_o)
    );
    
    //7 SEGMENTOS
    Displaypath Display7seg (
        .clk                (clk_i),   
        .rst                (rst_i),
        .in                 (write_i[15:0]),
        .we                 (we_7seg) ,   
        .out_an             (an_o),
        .out_seg            (seg_o)
    );
    
    //Botones y Switches
    Switches Botones_Switches (
        .clk_i              (clk_i),       
        .rst_i              (rst_i),          
        .sw_i               (sw_i),       
        .b0_i               (b0_i),     
        .b1_i               (b1_i),     
        .b2_i               (b2_i),     
        .b3_i               (b3_i),
        .data_btn_sw_o      (data_btn_sw)
    );
    
    //Timer
    timer Timer (
    .clk                    (clk_i),
    .rst                    (rst_i),
    .addr_bit2              (addr_timer),
    .we_t                   (we_timer),
    .data_in                (write_i),
    .data_out               (data_timer)
    );
    
    //Timer momentaneo de TMP
    timer TMP (
    .clk                    (clk_i),
    .rst                    (rst_i),
    .addr_bit2              (addr_tmp),
    .we_t                   (we_tmp),
    .data_in                (write_i),
    .data_out               (data_tmp)
    );
endmodule
