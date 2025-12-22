`timescale 1ns / 1ps

module control_TMP (
    input   logic           clk,          
    input   logic           rst,
      
    input   logic   [31:0]  in,       
    output  logic   [31:0]  limpiador,
    output  logic           wr_data,          
    output  logic           wr_ctrl         
);

logic   [3:0]  contador;

typedef enum logic [1:0]{
    s0 = 2'b00,
    s1 = 2'b01,
    s2 = 2'b11,
    s3 = 2'b10
    } estado;
    estado est, est_sig;

always_ff @(posedge clk or posedge rst) begin
    if (rst) est <= s0;
    else est <= est_sig;
end

always_comb begin
    case (est)
        s0: begin
            if (in == 32'd1) begin
                est_sig = s1;
            end else begin
                est_sig = s0;
            end
        end
        
        s1: begin
            if (contador == 10) est_sig = s2;       
            else                  est_sig = s1;
        end
            
        s2: est_sig = s3;

        s3: est_sig = s0;

        default: est_sig = s0;
    endcase
end

always_comb begin
    limpiador = 0;
    wr_data = 0; 
    wr_ctrl = 0;
    case (est)
        s1: begin
            limpiador = 32'd2;
            wr_data = 1; 
            wr_ctrl = 1;
        end 

        s3: begin
            limpiador = 0;
            wr_data = 0; 
            wr_ctrl = 1;
        end

        default: begin
            limpiador = 0;
            wr_data = 0; 
            wr_ctrl = 0;
        end
    endcase
end

always_ff @(posedge clk) begin
    if(est == s1) begin
         contador <= contador +1;
    end
    else contador <= '0;
end
endmodule
