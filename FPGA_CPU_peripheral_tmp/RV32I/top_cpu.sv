`timescale 1ns / 1ps

module top_cpu(
    input  logic            clk_i,
    input  logic            rst_i,
    
    //PERIFERICOS
    output logic    [15:0]  led_o,  //leds
    output logic    [6:0]   seg_o,  //7seg
    output logic    [3:0]   an_o,   //anodo
    input  logic    [15:0]  sw_i,   //switches
    input  logic            b0_i,   //boton0
    input  logic            b1_i,   //boton1
    input  logic            b2_i,   //boton2
    input  logic            b3_i    //boton3
    //FALTA SENSOR
    );
    
    //CONECCION CPU CON ROM
    logic           [31:0]  rom_addr;   //DIRECCION DE LA INSTRUCCION QUE SALE DEL CPU  
    logic           [31:0]  rom_instr;  //DATO DE INSTRUCCION QUE ENTRA AL CPU

    //CONEXION CPU CON PERIFERICOS
    logic           [31:0]  address;    //DATO DE DIRECCION EXTERNO QUE SALE DEL CPU. ALU RESULT
    logic           [31:0]  write;      //DATO DE ESCRITURA EXTERNO QUE SALE DEL CPU. WRITE DATA
    logic           [31:0]  read;       //DATO DE LECTURA EXTERNO QUE ENTRA AL CPU. READ DATA
    logic                   we;         //HABILITADOR DE ESCRITURA EXTERNO QUE SALE DEL CPU. MEMWRITE
    
    //CONEXION RAM CON PERIFERICOS
    logic           [7:0]   addr_ram;
    logic           [31:0]  write_ram;
    logic           [31:0]  data_ram;
    logic                   we_ram;

    //CPU
    rv32i cpu (
    .clk_i                  (clk_i),
    .rst_i                  (rst_i),  
    //CONECTOR CON ROM
    .ProgIn_i               (rom_instr),
    .ProgAdress_o           (rom_addr),
    //CONECTOR CON RAM
    .DataAdress_o           (address),
    .DataOut_o              (write),
    .DataIn_i               (read),
    .we_o                   (we)
    );
    
    //MEMORIA ROM
    instr_mem instr_mem1 (
        .a                  (rom_addr[10:2]),
        .spo                (rom_instr)
    );
    
    //MEMORIA RAM
    data_mem data_mem1 (
        .clk                (clk_i),
        .we                 (we_ram),
        .a                  (addr_ram),
        .d                  (write_ram),
        .spo                (data_ram)
    );
        
    //PERIFERICOS
    Perifericos perifericos1 (
    .clk_i                  (clk_i),
    .rst_i                  (rst_i),
    //cpu
    .addr_byte_i            (address[15:2]),  // address[15:2] de la cpu para direccionamieto por byte. Se omiten los 2 bits LSB
    .write_i                (write),
    .read_o                 (read),
    .we_i                   (we),
    //ram
    .addr_ram_o             (addr_ram),
    .write_ram_o            (write_ram),
    .data_ram_i             (data_ram),
    .we_ram_o               (we_ram),
    //periferioos
    .led_o                  (led_o),//leds
    .seg_o                  (seg_o),//7seg
    .an_o                   (an_o), //anodo
    .sw_i                   (sw_i), //switches
    .b0_i                   (b0_i), //boton0
    .b1_i                   (b1_i), //boton1
    .b2_i                   (b2_i), //boton2
    .b3_i                   (b3_i) //boton3
    //FALTA SENSOR
    );   
endmodule
