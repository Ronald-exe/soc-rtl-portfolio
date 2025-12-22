`timescale 1ns/1ps

module rv32i (
    input logic             clk_i,
    input logic             rst_i,
    
    //CONEXIONES CON ROM
    output logic    [31:0]  ProgAdress_o,   //direccion de instruccion
    input  logic    [31:0]  ProgIn_i,       //instruccion obtenida de la direccion de intruccion
    
    //CONEXIONES CON RAM
    output logic    [31:0]  DataAdress_o,   //direccion de memoria
    input  logic    [31:0]  DataIn_i,       //dato de lectura obtenido de la direccion de memoria
    output logic    [31:0]  DataOut_o,      //dato de escritura que se escribe en la direccion de memoria
    output logic            we_o            //habilitador de escritura del dato de escritura
);  
    //CONEXIONES DEL DATAPATH
    logic   [31:0]  PC;
    assign  ProgAdress_o = PC;          //SALIDA

    logic   [31:0]  Instr;
    assign  Instr = ProgIn_i;           //ENTRADA
    
    logic   [31:0]  ImmExt;
    logic   [31:0]  SrcA;
    logic   [31:0]  SrcB;
    
    logic   [31:0]  AluResult;
    assign  DataAdress_o = AluResult;   //SALIDA
    
    logic   [31:0]  WriteData;
    assign  DataOut_o = WriteData;      //SALIDA       
    
    logic   [31:0]  ReadData;
    assign  ReadData = DataIn_i;        //ENTRADA
    
    logic   [31:0]  PCNext;
    logic   [31:0]  PCPlus4;
    logic   [31:0]  PCTarget;

    logic   [31:0]  Result;
    
    //SALIDAS DE CONTROL
    logic           PCSrc;
    logic   [1:0]   ResultSrc;
    logic           RegWrite;    
    logic   [2:0]   ImmSrc;
    logic           AluSrc;
    logic   [3:0]   AluControl;
    logic   [2:0]   BranchSrc;

    logic           MemWrite;
    assign  we_o = MemWrite;            //SALIDA
    
    //BANDERAS DE LA ALU
    logic           Zero;
    logic           Negative;
    logic           Borrow;
    logic           Overflow;
    logic           CarryOut;
    
    //ENTRADA DE CONTROL PARA BRANCH
    logic           TakeBranch;

    //SUMADORES
    adder #(.W(32)) Adder_PCPlus4 (
        .a          (PC),
        .b          (4),
        .sum        (PCPlus4)
    );

    adder #(.W(32)) Adder_PCTarget (
        .a          (PC),
        .b          (ImmExt),
        .sum        (PCTarget)
    );

    //MUXES
    mux_2 #(.W(32)) Mux_PCNext (
        .sel        (PCSrc),
        .a          (PCPlus4),
        .b          (PCTarget),
        .y          (PCNext)  
    );

    mux_2 #(.W(32)) Mux_SrcB (
        .sel        (AluSrc),
        .a          (WriteData),
        .b          (ImmExt),
        .y          (SrcB)
    );

    mux_4 #(.W(32)) Mux_Result (
        .sel        (ResultSrc),
        .a          (AluResult),
        .b          (ReadData),
        .c          (PCPlus4),
        .d          ('0),
        .y          (Result)
    );
    
    //Program Counter 32 bits
    pc_rv32i Program_Counter (
        .clk        (clk_i),
        .rst        (rst_i),
        .pc         (PC),
        .pcnext     (PCNext)
    );
    
    //Banco de Registros de 32 registros
    register_file_rv32i #(.W(32)) Register_File (
        .clk        (clk_i),
        .rst        (rst_i),
        .we         (RegWrite), 
        .rs1        (Instr[19:15]),  
        .rs2        (Instr[24:20]),  
        .rd         (Instr[11:7]),  
        .wd         (Result),
        .rd1        (SrcA),
        .rd2        (WriteData)
    );

    //Generador de Inmediatos
    extend_rv32i Extend (
        .imm_sel    (ImmSrc),
        .instr31to7 (Instr[31:7]),
        .imm_out    (ImmExt)
    );

    //ALU
    alu_rv32i #(.W(32)) ALU ( 
        .a          (SrcA),
        .b          (SrcB),
        .alu_sel    (AluControl),
        .alu_result (AluResult),
        .zero       (Zero),
        .negative   (Negative),
        .borrow     (Borrow),
        .carry_out  (CarryOut),
        .overflow   (Overflow) 
    );

    //UNIDAD DE BRANCH
    branch_unit_rv32i Branch_Unit (
        .branch_sel (BranchSrc),
        .zero       (Zero),
        .negative   (Negative),
        .overflow   (Overflow),
        .borrow     (Borrow),
        .take_branch(TakeBranch)
    );
    
    //UNIDAD DE CONTROL PARA INSTRUCCIONES ESTANDAR Y NO COMPRIMIDAS
    control_unit_rv32i Control_Unit (
        .op         (Instr[6:0]),       //opcode
        .funct3     (Instr[14:12]),     //funcion 3
        .funct7_bit5(Instr[30]),        //bit 5 de funcion 7
        .TakeBranch (TakeBranch),       //ejecutor de branch
        .PCSrc      (PCSrc),            //seleccionador de Mux_PCNext
        .ResultSrc  (ResultSrc),        //seleccionador de Mux_Result
        .RegWrite   (RegWrite),         //we del Register_File
        .ImmSrc     (ImmSrc),           //seleccionador de Extend
        .AluSrc     (AluSrc),           //seleccionador de Mux_SrcB
        .AluControl (AluControl),       //seleccionador de alu
        .BranchSrc  (BranchSrc),        //seleccionador de branch
        .MemWrite   (MemWrite)          //we de salida para la RAM
    );
endmodule