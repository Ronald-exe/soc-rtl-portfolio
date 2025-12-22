`timescale 1ns / 1ps

module branch_unit_rv32i(
    input  logic        [2:0]   branch_sel,
    input  logic                zero,
    input  logic                negative,
    input  logic                borrow,
    input  logic                overflow,
    output logic                take_branch
    );
    logic                       slt;
    assign slt = negative ^ overflow;
    always_comb begin       
        case(branch_sel) //CORRESPONDE SEGUN FUNCT3 DE RV32I
            3'b000:     take_branch = zero;     //BEQ
            3'b001:     take_branch = ~zero;    //BNE
            3'b100:     take_branch = slt;      //BLT
            3'b101:     take_branch = ~slt;     //BGE
            3'b110:     take_branch = borrow;   //BLTU
            3'b111:     take_branch = ~borrow;  //BGEU
            default:    take_branch = 0;
        endcase
    end
endmodule
