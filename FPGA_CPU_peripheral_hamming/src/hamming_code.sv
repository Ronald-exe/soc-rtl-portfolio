`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/27/2025 08:07:09 AM
// Design Name: 
// Module Name: hamming_code
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


module hamming_code(
input logic   [3:0] data_men_i,
input logic         signal,
output logic  [31:0] sal
);
logic [6:0] hamming_sal;
logic [6:0] hamming_sal2;
logic c0,c1,c2,c3,c4,c5,c6;

//creacion de los valores de hamming
assign c3 = data_men_i[0];
assign c4 = data_men_i[1];
assign c5 = data_men_i[2];
assign c6 = data_men_i[3];


//valores calculados
assign c0 = c5^c4^c3;
assign c1 = c6^c5^c4;
assign c2 = c6^c4^c3;

always_comb begin 
  if(signal) begin
    hamming_sal = {c0,c1,c2,c3,c4,c5,c6};
  end else begin 
    hamming_sal2 = {c0,c1,c2,c3,c4,c5,c6};
  end
end

assign sal = {18'b0, hamming_sal2, hamming_sal};

endmodule 
