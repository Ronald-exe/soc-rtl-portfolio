`timescale 1ns / 1ps

module mux_alu_flags(
    input   logic   [3:0]   alu_sel,
    input   logic           i_negative,
    input   logic           i_borrow,
    input   logic           i_carry_out,
    input   logic           i_ovf_sum,
    input   logic           i_ovf_res,
    
    output  logic           negative,
    output  logic           borrow,
    output  logic           carry_out,
    output  logic           overflow
    );
    always_comb begin
        case (alu_sel)
            4'b0000: begin  //CASO SUMA
                negative    = i_negative;
                borrow      = 0;
                carry_out   = i_carry_out;
                overflow    = i_ovf_sum;
            end
            4'b1000: begin  //CASO RESTA
                negative    = i_negative;
                borrow      = i_borrow;
                carry_out   = 0;
                overflow    = i_ovf_res;
            end  
            default: begin  //CASO DE OTRA OPERACION DE LA ALU
                negative    = 0;
                borrow      = 0;
                carry_out   = 0;
                overflow    = 0;
            end
        endcase
    end
endmodule
