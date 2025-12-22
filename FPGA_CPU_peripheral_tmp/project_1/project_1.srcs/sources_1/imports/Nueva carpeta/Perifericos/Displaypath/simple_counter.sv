`timescale 1ns/1ps

module simple_counter #(parameter MOD = 31, parameter i = 0) (
    input  logic clk,
    input  logic rst,

    input  logic en,
    output logic [($clog2(MOD)-1): 0] count
);
    always_ff @(posedge clk or posedge rst) begin 
        if(rst)                     count <= '0;
        else if(en) begin
            if (count < MOD - 1)    count <= count + 1'b1;
            else                    count <= i;
        end
    end  
endmodule