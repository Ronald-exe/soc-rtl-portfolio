`timescale 1ns / 1ps

module LEDs(
    input   logic           clk_i,
    input   logic           rst_i,
    
    input   logic           we_led_i,
    input   logic   [15:0]  led_i,
    output  logic   [15:0]  led_o
    );
    always_ff @(posedge clk_i or posedge rst_i) begin
        if      (rst_i)     led_o <= 16'h0000;
        else if (we_led_i)  led_o <= led_i;
    end
endmodule