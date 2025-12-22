`timescale 1ns / 1ps

module mux_alu_result #(parameter W = 32)(
    input   logic   [3:0]   alu_sel,
    input   logic   [W-1:0] sum,
    input   logic   [W-1:0] res,
    input   logic   [W-1:0] sll,
    input   logic   [W-1:0] srl,
    input   logic   [W-1:0] sra,
    input   logic   [W-1:0] slt,
    input   logic   [W-1:0] sltu,
    input   logic   [W-1:0] xor_,
    input   logic   [W-1:0] or_,
    input   logic   [W-1:0] and_,
    output  logic   [W-1:0] alu_result
    );   
    always_comb begin
        case(alu_sel)
            4'b0000:    alu_result = sum;
            4'b1000:    alu_result = res;
            4'b0001:    alu_result = sll;
            4'b0010:    alu_result = slt;
            4'b0011:    alu_result = sltu;
            4'b0100:    alu_result = xor_;
            4'b0101:    alu_result = srl;
            4'b1101:    alu_result = sra;
            4'b0110:    alu_result = or_;
            4'b0111:    alu_result = and_;
            default:    alu_result = '0;
        endcase
    end
endmodule
