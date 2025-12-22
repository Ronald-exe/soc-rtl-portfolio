`timescale 1ns / 1ps

module registros_datos (
    input   logic           clk,              
    input   logic           rst,
            
    input   logic           wr_1, 
    input   logic   [7:0]   in,
    
    output  logic   [31:0]  out             
);

    logic [31:0] control_data;             

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            control_data <= 32'h0;  
        end else begin
            if (wr_1) begin   
                control_data <= {23'd0, in};  
            end else control_data <= control_data; 
        end
    end

    assign out = control_data;
endmodule
