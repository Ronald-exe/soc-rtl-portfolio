`timescale 1ns / 1ps

module pc_rv32i(                            //Es un registro que guarda la proxima direccion a ejecutar, cambia entre espacios de memoria
    input  logic        clk,
    input  logic        rst,
    
    input  logic [31:0] pcnext,             //es la siguiente direccion de registro
    output logic [31:0] pc                  //direccion de registro actual     
);
    always_ff @(posedge clk or posedge rst) begin
        if(rst) pc <= 32'h00400000;         // este es el incio del segmento de datos;
        else    pc <= pcnext;               // el registro actual guarda la direccion de memoria de la siguiente instruccion.
    end
endmodule
