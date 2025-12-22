`timescale 1ns / 1ps

module registro_control(
    input   logic           clk,              
    input   logic           rst,
            
    input   logic           wr_1,
    input   logic           wr_2,
    input   logic   [31:0]  limpiador,  
    input   logic   [31:0]  in,
    
    output  logic   [31:0]  out             
);

    logic [31:0] control_reg;             

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            control_reg <= 32'h0;  
        end else begin
            if (wr_2) begin   
                control_reg <= limpiador;  
            end else if (wr_1) begin
                control_reg <= in; 
            end
        end
    end

    assign out = control_reg;
endmodule