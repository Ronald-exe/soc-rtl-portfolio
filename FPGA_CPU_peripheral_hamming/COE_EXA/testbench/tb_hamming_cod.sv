`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/27/2025 08:35:04 AM
// Design Name: 
// Module Name: tb_hamming_cod
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


module tb_hamming_cod;

logic [3:0]  data_men_i;
logic [31:0] sal       ;

hamming_code hamming_test (
    .data_men_i(data_men_i),
    .sal(sal)
);

initial begin
    $display("tiempo | data_men_i | sal ");
    $monitor("%4t   | %b     | %b", $time, data_men_i, sal);
    for(int i=0; i<16;i++) begin
        data_men_i = i[3:0];
        #10;  
    end
    $finish;
end

endmodule
