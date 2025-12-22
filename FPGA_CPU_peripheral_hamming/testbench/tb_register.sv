`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/27/2025 10:42:12 AM
// Design Name: 
// Module Name: tb_register
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


module tb_register;
  logic clk;
  logic rst;
  logic wr;
  logic [31:0] data_in;
  logic [31:0] data_out;
  
  
  registro_base registro(
    .clk      (clk),
    .rst      (rst),
    .wr       (wr),
    .data_in  (data_in),
    .data_out (data_out)
);

   initial begin
    clk = 0;
    forever #5 clk = ~clk; 
  end

  integer i;

  initial begin
    // Inicializaci?n
    rst = 1;
    wr = 0;
    data_in = 32'd0;
    #20;

    rst = 0;
    #10;

    // Probar m?ltiples entradas
    for (i = 0; i < 8; i++) begin
      // Escritura
      data_in = i;
      wr = 1;
         #10;

      // Fin de escritura
      wr = 0;
      #10;
    end

    $finish;
  end

endmodule
