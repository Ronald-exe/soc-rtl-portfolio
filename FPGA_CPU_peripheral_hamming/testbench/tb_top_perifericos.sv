`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/27/2025 08:52:39 AM
// Design Name: 
// Module Name: tb_top_perifericos
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_top_perifericos;

  logic clk;
  logic rst;
  logic wr_i;
  logic reg_sel_i;
  logic [31:0] entrada_i;
  logic [31:0] salida_o;

  // DUT (Device Under Test)
  top_perifericos perifericos (
    .clk        (clk),
    .rst        (rst),
    .wr_i       (wr_i),
    .reg_sel_i  (reg_sel_i),
    .entrada_i  (entrada_i),
    .salida_o   (salida_o)
  );

 
  initial begin
    clk = 0;
    forever #5 clk = ~clk; 
  end


  initial begin
    $display("Tiempo | entrada_i | salida_o");
    $monitor("%4t     | %h        | %h", $time, entrada_i, salida_o);
  end

  integer i;

  initial begin
    // Inicializaci?n
    rst = 1;
    wr_i = 0;
    reg_sel_i = 0;
    entrada_i = 32'd0;
    #20;

    rst = 0;
    #10;

    // Probar m?ltiples entradas
    for (i = 0; i < 8; i++) begin
      // Escritura
      entrada_i = i;
      wr_i = 1;
      reg_sel_i = 0;
      #10;

      // Fin de escritura
      wr_i = 0;
      #10;

      // Lectura
      reg_sel_i = 1;
      #10;

      // Fin de lectura
      reg_sel_i = 0;
      #10;
    end

    $finish;
  end

endmodule
