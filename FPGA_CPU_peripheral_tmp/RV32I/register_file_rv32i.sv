`timescale 1ns / 1ps

module register_file_rv32i #(parameter W = 32)( // registros temporales por eso son 32 al igual que en la hoja de especificaciones
    input  logic            clk,
    input  logic            rst,
    
    input  logic            we,     //enable que permite la escritura
    input  logic    [4:0]   rs1,    //primera direccion del banco para lectura
    input  logic    [4:0]   rs2,    //segunda direccion del banco para lectura
    input  logic    [4:0]   rd,     //tercera direccion del banco para escritura
    input  logic    [W-1:0] wd,     //dato de escritura
    
    output logic    [W-1:0] rd1,    //dato dado por rs1
    output logic    [W-1:0] rd2     //dato dado por rs2
);
    logic           [W-1:0] mem[32];
    integer i;
    
    always_ff@(posedge clk or posedge rst) begin
        if(rst) begin
            for(i = 0; i < 32; i++) begin
                mem[i] <= '0;
            end
        end else if(we && rd != 0) 
            mem[rd] <= wd;
    end

    always_comb begin
        if (rs1 != 0) rd1 = mem[rs1]; 
        else rd1 = 0;
        if (rs2 != 0) rd2 = mem[rs2]; 
        else rd2 = 0;
    end
endmodule