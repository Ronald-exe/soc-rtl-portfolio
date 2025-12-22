`timescale 1ns / 1ps

module extend_rv32i(
    input  logic    [2:0]   imm_sel,
    input  logic    [24:0]  instr31to7,
    output logic    [31:0]  imm_out
);
    logic           [31:0]  i;
    assign          i = {instr31to7,7'b000000};
    always_comb begin
        case(imm_sel)
            3'b000:     imm_out = {{20{i[31]}}, i[31:20]};                              //instr Type I
            3'b001:     imm_out = {{20{i[31]}}, i[31:25], i[11:7]};                     //instr Type S   
            3'b010:     imm_out = {{19{i[31]}}, i[31], i[7], i[30:25], i[11:8], 1'b0};  //instr Type B
            3'b011:     imm_out = {{11{i[31]}}, i[31], i[19:12], i[20], i[30:21], 1'b0};//instr Type J
            3'b100:     imm_out = {i[31:12], 12'b0};                                    //instr Type U
            default:    imm_out = 32'hDEADBEEF;
        endcase
    end
endmodule
            
