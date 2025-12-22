`timescale 1ns / 1ps

module ADC(
    input   logic           clk,
    input   logic           vauxp6,
    input   logic           vauxn6,
    input   logic           vp_in,
    input   logic           vn_in,
    output  logic   [7:0]   led
    );
    
    logic        enable;
    logic        ready;
    logic [15:0] data;
    logic [6:0]  Address_in;
   /* logic clk10MHz;
    logic locked;
    
    clk_wiz_100MHz CLK (
    .clk_in1                (clk),
    .reset                  ('b0),
    .clk_out1               (clk10MHz),
    .locked                 (locked)
    );
    */
    xadc_wiz_0  ADC (
        .daddr_in(Address_in), 
        .dclk_in(clk), 
        .den_in(enable), 
        .di_in(0), 
        .dwe_in(0), 
        .busy_out(),                    
        .vauxp6(vauxp6),
        .vauxn6(vauxn6),
        .vn_in(vn_in), 
        .vp_in(vp_in), 
        .alarm_out(), 
        .do_out(data),
        .eoc_out(enable),
        .channel_out(),
        .drdy_out(ready)
    );
       
    assign led = data[15:8];
    assign Address_in = 8'h16;
        
endmodule
