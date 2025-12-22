`timescale 1ns / 1ps

module TOP_SISTEMA_EXAMEN(
        input logic clock_i,
        input logic reset_i,    //BOTON DE RESET ACTIVO EN ALTO
        
        output logic [15:0] led_o,
        input logic [15:0] sw_i,
        input logic [3:0] btn_i,
        
        output logic [6:0] segmentos_o,
        output logic [3:0] anodos_o,
        output logic dp_o
    );
    logic        clock_10;
    logic        locked;
    logic        reset_effectivo;

    logic [31:0] address_ext;
    logic [31:0] instr_bus;
    logic [31:0] ext_bus_data_in;
    logic [31:0] ext_bus_data_out;
    logic        ext_bus_we;
     
    logic [10:0] instr_addr_bus;
    logic [9:0]  ram_address_bus;
    logic        ram_we;
    logic [31:0] ram_data_in;
    logic [31:0] ram_data_out;

    logic [7:0] anodos_interno;


    microcontrolador_syn MC(
        .clock_10_i         (clock_10),
        .reset_i            (reset_i),
        .locked_i           (locked),
        .reset_effectivo_o  (reset_effectivo),

        .led_o              (led_o),
        .sw_i               (sw_i),
        .btn_i              (btn_i),
        .segmentos_o        (segmentos_o),
        .anodos_o           (anodos_interno),
        .dp_o               (dp_o),
        
        .instr_bus_i        (instr_bus),
        .instr_addr_bus_o   (instr_addr_bus),
        
        .address_ext_o      (address_ext),
        .ext_bus_data_i     (ext_bus_data_in),
        .ext_bus_data_o     (ext_bus_data_out),
        .ext_bus_we_o       (ext_bus_we),
        
        .ram_address_bus_o  (ram_address_bus),
        .ram_we_o           (ram_we),
        .ram_data_in_o      (ram_data_in),
        .ram_data_out_i     (ram_data_out)
    );

    assign anodos_o = anodos_interno[3:0];

    //CREAR IP CORES PARA ROM, RAM Y PLL, cambiar el nombre del modulo de acuerdo a como los genera
    
    dist_mem_gen_0 ROM(
        .a      (instr_addr_bus[10:2]),
        .spo    (instr_bus)
    );
    
   dist_mem_gen_1 RAM(
        .a       (ram_address_bus[9:2]),
        .d       (ram_data_in),
        .clk     (clock_10),
        .we      (ram_we),
        .spo     (ram_data_out)
    );
    
    //PLL salida 10Mhz con salida de locked
    clk_wiz_0 DIV 
    (
        // clock_i out ports
        .clk_out1(clock_10),
        // clock_i in ports
        .clk_in1(clock_i),
        .locked(locked)
    );
    
top_perifericos periferico(
    .clk        (clock_10),
    .rst        (reset_effectivo),
    .wr_i       (ext_bus_we ),
    .reg_sel_i  (address_ext[2]),
    .entrada_i  (ext_bus_data_out),
    .salida_o   (ext_bus_data_in)
);


    /*
    instancias de sus perifericos conectados a 

        address_ext      -- 32 bits de dirección 
        ext_bus_data_in  -- Datos desde el periferico hacia el procesador
        ext_bus_data_out -- Datos desde el procesador hacia el periferico
        ext_bus_we       -- Write Enable para el periferico

        USAR RESET ACTIVO EN ALTO!

    */
    
   

endmodule
