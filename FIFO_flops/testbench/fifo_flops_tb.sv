// Instituto Tecnológico de Costa Rica
// EL-3310 Diseño de sistemas digitales
// Autor:       Juan José Montero Rodríguez
// Fecha:       28.07.2024
// Descripción: FIFO parametrizable con flip-flops D

`timescale 1ns/1ps

`define BITS  8
`define DEPTH 16

module fifo_flops_tb();
    
    reg              clk;
    reg              rst;
    reg  [`BITS-1:0] Din;
    reg              push;
    reg              pop;

    wire [`BITS-1:0] Dout;
    wire             full;
    wire             pndng;
    parameter DEPTH = 16;

    fifo_flops #(`DEPTH,`BITS) uut(
        .clk             (clk),
        .rst             (rst),
        .Din             (Din),
        .Dout            (Dout),
        .push            (push),
        .pop             (pop),
        .full            (full),
        .pndng           (pndng)
    );

    initial begin                               // se le asignan los valores de la entrada
        Din  = 'b0;                              // inicializa en cero
        #20;
        repeat(DEPTH-1) begin
            #20;
            Din = $random;                     //se generan los valores random para la entrada       
        end 
    end

    initial begin

        $display("running...");

        rst  = 1;
        push = 0;
        pop  = 0;
        #10;
        rst  = 0;
        #5;
        repeat ((DEPTH)) begin  // no quitar la temporarizacion ya que esto afecta mucho las ondas y el funcionamiento completo...........
            #10;
            push= 1;
            pop = 0;
            #10;
            push = 0;
        end 
        #10;
        repeat ((DEPTH)) begin
            #10;
            push= 0;
            pop = 1;
            #10;
            pop = 0;
        end 

        // escriba aquí el resto del testbench

        #100 $finish();

    end

    initial begin

        clk  = 1'b0;

        forever #5 clk = !clk;

    end

endmodule

