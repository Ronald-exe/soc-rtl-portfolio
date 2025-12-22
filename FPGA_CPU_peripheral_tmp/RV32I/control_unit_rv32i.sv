`timescale 1ns / 1ps

module control_unit_rv32i(
    input  logic    [6:0]   op,             //opcode
    input  logic    [2:0]   funct3,         //funcion 3
    input  logic            funct7_bit5,    //bit 5 de funcion 7
    input  logic            TakeBranch,     //ejecutor de branch
    
    output logic            PCSrc,          //seleccionador de Mux_PCNext
    output logic    [1:0]   ResultSrc,      //seleccionador de Mux_Result
    output logic            RegWrite,       //we del Register_File
    output logic    [2:0]   ImmSrc,         //seleccionador de Extend
    output logic            AluSrc,         //seleccionador de Mux_SrcB
    output logic    [3:0]   AluControl,     //seleccionador de alu
    output logic    [2:0]   BranchSrc,      //seleccionador de branch
    output logic            MemWrite        //we de salida para la RAM
);
    //LOGICA DE BRANCHES/SALTOS 
    logic   Branch;
    logic   Jump;
    assign  BranchSrc = funct3;
    assign  PCSrc = (Branch && TakeBranch) || Jump;
    
    //LOGICA DE SELECCION DE OPERACION DE LA ALU
    logic  [1:0]   AluOp ;

    //DECODIFICADOR DE INSTRUCIONES CON EL OPCODE
    always_comb begin
        case (op)

            51:begin    //R-type
                ResultSrc   = 2'b00;    //Resultado de la ALU
                RegWrite    = 1'b1;
                ImmSrc      = 3'b000;   //Inmediato de I-Type
                AluSrc      = 1'b0;     //Se usa dato de rs2, se ignora el valor de ImmSrc
                MemWrite    = 1'b0;
                
                Branch      = 1'b0;
                Jump        = 1'b0;
                AluOp       = 2'b10;    //Escoge operacion en la alu
            end
            
            19:begin    //I_type op
                ResultSrc   = 2'b00;    //Resultado de la ALU
                RegWrite    = 1'b1;
                ImmSrc      = 3'b000;   //Inmediato de I-Type
                AluSrc      = 1'b1;     //Se usa dato de inmediato
                MemWrite    = 1'b0;
                
                Branch      = 1'b0;
                Jump        = 1'b0;
                AluOp       = 2'b10;    //Escoge operacion en la alu
            end
            
            3 :begin    //I-type lw
                ResultSrc   = 2'b01;    //Resultado del dato de lectura de memoria
                RegWrite    = 1'b1;
                ImmSrc      = 3'b000;   //Inmediato de I-Type
                AluSrc      = 1'b1;     //Se usa dato de inmediato
                MemWrite    = 1'b0;
                
                Branch      = 1'b0;
                Jump        = 1'b0;
                AluOp       = 2'b00;    //suma
            end
            
            35:begin    //S-type sw
                ResultSrc   = 2'b00;    //Resultado de la ALU
                RegWrite    = 1'b0;     //No escritura en el banco de registros, asi que se ignora el valor de ResultSrc
                ImmSrc      = 3'b001;   //Inmediato S-type
                AluSrc      = 1'b1;
                MemWrite    = 1'b1;     //Se guarda en memoria el valor de rs2
                
                Branch      = 1'b0;
                Jump        = 1'b0;
                AluOp       = 2'b00;    //suma
            end
            
            99:begin    //B-type
                ResultSrc   = 2'b00;    //Resultado de la ALU
                RegWrite    = 1'b0;     //No escritura en el banco de registros, asi que se ignora el valor de ResultSrc
                ImmSrc      = 3'b010;   //Inmediato B-type
                AluSrc      = 1'b0;
                MemWrite    = 1'b0;
                
                Branch      = 1'b1;     //Se activa el uso de branch
                Jump        = 1'b0;
                AluOp       = 2'b01;    //resta
            end
            
            111:begin   //J-type jal
                ResultSrc   = 2'b10;    //Resultado de PC+4
                RegWrite    = 1'b1;     //Se guarda el valor de PC+4
                ImmSrc      = 3'b011;   //Inmediato J-type
                AluSrc      = 1'b0;
                MemWrite    = 1'b0;
                
                Branch      = 1'b0;
                Jump        = 1'b1;     //Salto de PCTarget fijo
                AluOp       = 2'b00;    //suma, pero la suma no influye en la operacion
            end
               
            default:begin //default
                ResultSrc   = 2'b00;
                RegWrite    = 1'b0;
                ImmSrc      = 3'b000;
                AluSrc      = 1'b0;
                MemWrite    = 1'b0;
                
                Branch      = 1'b0;
                Jump        = 1'b0;
                AluOp       = 2'b00;
            end
              
        endcase
    end
    
    //DECODIFICADOR DE ALUCONTROL
    always_comb begin
        casex({AluOp, op[5], funct7_bit5, funct3})
            //S-type sw //I-type lw
            7'b00xxxxx: AluControl = 4'b0000;   //suma
            //B-type
            7'b01xxxxx: AluControl = 4'b1000;   //resta
            //R-type    //I-type op
            7'b100x000: AluControl = 4'b0000;   //addi
            7'b1010000: AluControl = 4'b0000;   //add
            7'b1011000: AluControl = 4'b1000;   //sub
            7'b10xx001: AluControl = 4'b0001;   //sll   y   slli
            7'b10xx010: AluControl = 4'b0010;   //slt   y   slti
            7'b10xx011: AluControl = 4'b0011;   //sltu  y   sltui
            7'b10xx100: AluControl = 4'b0100;   //xor   y   xori
            7'b10x0101: AluControl = 4'b0101;   //srl   y   srli
            7'b10x1101: AluControl = 4'b1101;   //sra   y   srai
            7'b10xx110: AluControl = 4'b0110;   //or    y   ori
            7'b10xx111: AluControl = 4'b0111;   //and   y   andi
            default   : AluControl = 4'b0000;   //suma
        endcase
    end
endmodule