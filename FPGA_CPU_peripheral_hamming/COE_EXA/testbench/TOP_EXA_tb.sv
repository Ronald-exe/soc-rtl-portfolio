`timescale 1ns / 1ps


module TOP_EXA_tb;
logic           clk;
logic           rst;
logic [15:0]    led;
logic [15:0]    sw;
logic [3:0]     btn;
logic [6:0]     segmentos;
logic [3:0]     anodos;
logic           dp;

initial begin
    clk=0;
    forever #5 clk = ~clk;
end

initial begin
    rst = 1; //RESET ACTIVO EN ALTO
    sw = 16'h0000;
    btn = 4'd0;
    #2000;
    @(posedge clk);
    @(posedge clk);
    #1 rst <= 0;
    
end

TOP_SISTEMA_EXAMEN DU(
    .clock_i        (clk),
    .reset_i        (rst),
    .led_o          (led),
    .sw_i           (sw),
    .btn_i          (btn),
    .segmentos_o    (segmentos),
    .anodos_o       (anodos),
    .dp_o           (dp)
);
    
endmodule
