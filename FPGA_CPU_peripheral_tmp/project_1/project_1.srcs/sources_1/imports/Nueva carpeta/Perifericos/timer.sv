`timescale 1ns/1ps

module timer (
    input  logic        clk,
    input  logic        rst,
    input  logic        addr_bit2,
    input  logic        we_t,
    input  logic [31:0] data_in,

    output logic [31:0] data_out
);
    //Señal adicional
    logic [31:0] count;

    //Registros
    logic [31:0] ctrl;
    logic [31:0] data;

    //Proceso de escritura y conteo
    always_ff @(posedge clk or posedge rst) begin
        if(rst) begin
            ctrl  <= 32'b0;
            data  <= 32'b0;
            count <= 32'b0;
        end else begin
            //Escritura en registro
            if(we_t) begin
                if(!addr_bit2 && count == 32'b0) begin
                    ctrl    <= {data_in[31:2], 1'b0, data_in[0]};
                end else if (addr_bit2 && count == 32'b0) begin
                    data <= data_in;
                end else begin
                    data <= data;
                end
            end

            //Conteo
            if(ctrl[0] && !ctrl[1]) begin
                if(count == data) begin
                    ctrl[1]     <= 1'b1;
                    ctrl[0]     <= 1'b0;
                    count       <= 32'b0;
                end else begin
                    count <= count + 1'b1;
                end
            end
        end
    end
    
    //Salida
    always_comb begin
        data_out = addr_bit2 ? data : ctrl;
    end
endmodule