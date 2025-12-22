`timescale 1ns / 1ps

module Selector(
    //direccion del cpu
    input   logic   [13:0]  addr_byte_i,  // address[15:2] de la cpu para direccionamieto por byte. Se omiten los 2 bits LSB
    //direcciones de los perifericos
    output logic            addr_timer_o,
    output logic            addr_tmp_o,
    //habilitador de escritura del cpu para los perifericos
    input   logic           we_i,
    //habilitadores de escritura para los perifericos
    output  logic           we_led_o,
    output  logic           we_7seg_o,
    output  logic           we_timer_o,
    output  logic           we_tmp_o,
    //datos de entrada de los perifericos para lectura en el cpu
    input   logic   [31:0]  data_btn_sw_i,
    input   logic   [31:0]  data_timer_i,
    input   logic   [31:0]  data_tmp_i,
    //ram
    output logic    [7:0]   addr_ram_o,
    input   logic   [31:0]  data_ram_i,
    output  logic           we_ram_o,
    //dato de lectura para el cpu
    output  logic   [31:0]  read_o
    );
    always_comb begin
        //Inicializacion de las salidas
        we_led_o   = 0;
        we_7seg_o   = 0;
        we_timer_o  = 0;
        we_tmp_o    = 0;
        we_ram_o    = 0;
        read_o      = '0;
        //Decodificador por dirección para perifericos alineada por palabra
        case (addr_byte_i)
            //SWITCHES y BOTONES
            14'h800: read_o      = data_btn_sw_i;   // 0x2000
            //LEDs
            14'h801: we_led_o   = we_i;             // 0x2004
            //7 SEGMENTOS
            14'h802: we_7seg_o   = we_i;            // 0x2008
            //TIMER CTRL
            14'h806: begin                          // 0x2018
                we_timer_o  = we_i;
                read_o      = data_timer_i;
            end
            //TIMER DATA
            14'h807: begin                          // 0x201C
                we_timer_o  = we_i;
                read_o      = data_timer_i;
            end
            //TMP CTRL
            14'h80C: begin                          // 0x2030
                we_tmp_o    = we_i;
                read_o      = data_tmp_i;
            end
            //TMP DATA
            14'h80D: begin                          // 0x2034
                we_tmp_o    = we_i;
                read_o      = data_tmp_i;
            end
            //OTRAS DIRECCIONES NO USADAS
            default: ;  //Salidas en 0
        endcase
        //RAM: Rango de 0x1000 a 0x13FC = 256 palabras
        if ((addr_byte_i >= 14'h400) && (addr_byte_i <= 14'h4ff)) begin
            we_ram_o = we_i;
            read_o   = data_ram_i;
        end         
    end
    assign addr_ram_o    = addr_byte_i[7:0];//Direccion de la RAM de byte en byte
    assign addr_timer_o  = addr_byte_i[0];  //Selector de registro de control o  de datos del timer
    assign addr_tmp_o    = addr_byte_i[0];  //Selector de registro de control o  de datos del tmp
endmodule
