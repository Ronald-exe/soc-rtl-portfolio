`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/27/2025 08:01:08 AM
// Design Name: 
// Module Name: registro_base
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


module registro_base(
input logic         clk,
input logic         rst,
input logic         wr,
input logic  [31:0] data_in,
output logic [31:0] data_out
 );
 
 logic       [31:0] data_reg;
 
 always_ff @(posedge clk or posedge rst)begin
    if(rst) begin
        data_reg <= 'b0;
     end else if(wr) begin
        data_reg <= data_in;
     end 
 end 
 
assign data_out = data_reg;

endmodule
