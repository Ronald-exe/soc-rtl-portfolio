`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/27/2025 08:05:08 AM
// Design Name: 
// Module Name: mux_2a1
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


module mux_2a1(
input logic          s_i,
input logic  [32:0]  a_i,
input logic  [32:0]  b_i,
output logic [32:0]  sal_o
); 

always_comb begin
    case(s_i) 
    1'b1: sal_o = b_i;
    1'b0: sal_o = a_i;
    default: sal_o = 'b0;
    endcase
end
endmodule
