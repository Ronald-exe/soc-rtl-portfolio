`timescale 1ns / 1ps

module alu_rv32i #(parameter W = 32)(
    input   logic   [3:0]   alu_sel,
    input   logic   [W-1:0] a,
    input   logic   [W-1:0] b,
    
    output  logic   [W-1:0] alu_result,
    output  logic           zero,
    output  logic           negative,
    output  logic           borrow,
    output  logic           carry_out,
    output  logic           overflow
    );
    //CREACION DE SHAMT PARA OPERACIONES sll, srl y sra
    localparam int  LP_SHAMT_W = $clog2(W);
    logic           [LP_SHAMT_W-1:0] shamt;
    assign shamt = b[LP_SHAMT_W-1:0];
    
    //OPERACIONES DE LA ALU
    logic           [W-1:0] sum;
    logic           [W-1:0] res;
    logic           [W-1:0] sll;
    logic           [W-1:0] srl;
    logic           [W-1:0] sra;
    logic           [W-1:0] slt;
    logic           [W-1:0] sltu;
    logic           [W-1:0] xor_;
    logic           [W-1:0] or_;
    logic           [W-1:0] and_;
    
    //BANDERAS INTERNAS DE LAS OPERACIONES DE SUMADOR Y RESTADOR
    logic                   i_negative;
    logic                   i_borrow;
    logic                   i_carry_out;
    logic                   i_ovf_sum;
    logic                   i_ovf_res;
    
    //SELECTOR DE RESULTADO DE LA ALU
    mux_alu_result #(.W(W)) Mux_ALU_Result (
    .alu_sel    (alu_sel), 
    .sum        (sum),      
    .res        (res),      
    .sll        (sll),
    .srl        (srl),
    .sra        (sra),    
    .slt        (slt),    
    .sltu       (sltu),
    .xor_       (xor_),      
    .or_        (or_),      
    .and_       (and_),
    .alu_result (alu_result)
    );
    
    //SELECTOR DE BANDERAS SEGUN EL RESULTADO DE LA ALU
    mux_alu_flags Mux_ALU_Flags (
    .alu_sel    (alu_sel),
    
    .i_negative (i_negative),
    .i_borrow   (i_borrow),
    .i_carry_out(i_carry_out),
    .i_ovf_sum  (i_ovf_sum),
    .i_ovf_res  (i_ovf_res),
    
    .negative   (negative),
    .borrow     (borrow),
    .carry_out  (carry_out),
    .overflow   (overflow)
);
    
    //SUMADOR CON BANDERAS
    sumador #(.W(W)) Sumador (
    .a              (a),
    .b              (b),
    .sum            (sum),
    .carry_out      (i_carry_out),
    .overflow       (i_ovf_sum)  
    );
    
    //RESTADOR CON BANDERAS
    restador #(.W(W)) Restador (
    .a              (a),
    .b              (b),
    .res            (res),
    .borrow         (i_borrow),
    .negative       (i_negative),
    .overflow       (i_ovf_res) 
    );
    
    //EL RESTO DE OPERACIONES
    assign sll  = a         <<      shamt;
    assign srl  = a         >>      shamt;
    assign sra  = $signed(a)>>>     shamt;
    assign slt  = {{(W-1){1'b0}},   i_negative ^ i_ovf_res};
    assign sltu = {{(W-1){1'b0}},   i_borrow};
    assign xor_ = a         ^       b;
    assign or_  = a         |       b;
    assign and_ = a         &       b; 
    
    //BANDERA DE ZERO 
    assign zero = ~|alu_result;
endmodule