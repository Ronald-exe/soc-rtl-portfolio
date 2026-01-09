// Instituto Tecnológico de Costa Rica
// EL-3310 Diseño de sistemas digitales
// Autor:       Juan José Montero Rodríguez
// Fecha:       28.07.2024
// Descripción: FIFO parametrizable con flip-flops D

`timescale 1ns/1ps

module fifo_flops #(parameter DEPTH = 16, BITS = 8) (
    input             clk,
    input             rst,
    input  [BITS-1:0] Din,
    output [BITS-1:0] Dout,
    input             push,
    input             pop,
    output            full,
    output            pndng
);

    wire [$clog2(DEPTH)-1:0] Pointer_in;  // address with number of bits required
    wire [$clog2(DEPTH)-1:0] Pointer_out; // address with number of bits required
    wire                     clk_ff  [DEPTH];
    wire [BITS-1:0]          D_in_n  [DEPTH];
    wire [BITS-1:0]          D_out_n [DEPTH];

    genvar i;
    generate
        for(i=0; i<DEPTH; i=i+1) begin
            flop fifo_flop_n (clk_ff[i], rst, D_in_n[i], D_out_n[i]);
        end
    endgenerate

    mux       #(DEPTH,BITS) mux_out   (Pointer_out,D_out_n,Dout);
    demux     #(DEPTH,BITS) demux_in  (Pointer_in,Din,D_in_n);
    demux     #(DEPTH,1)    demux_clk (Pointer_in,~push & ~full,clk_ff);
    Cntr_in   #(DEPTH,BITS) ctrl_in   (clk,rst,push,pop,full,Pointer_in);
    Cntr_out  #(DEPTH,BITS) ctrl_out  (clk,rst,push,pop,pndng,Pointer_out);

endmodule


module Cntr_in #(parameter DEPTH = 16, BITS = 8) (
    input                          clk,
    input                          rst,
    input                          push,
    input                          pop,
    output                         full,
    output reg [$clog2(DEPTH)-1:0] Pointer_in
);
    logic                   overflow;

    reg [$clog2(DEPTH)+1:0] data_count;

    // write logic
    always @(posedge clk) begin
        if(rst)       Pointer_in <= 'b0;
        else if(push & !full) Pointer_in <= Pointer_in + 'b1;
        else          Pointer_in <= Pointer_in;
    end

    // flags
    always @(posedge clk) begin
        if(rst)       data_count <= 'b0;
        else if(push & !full) data_count <= data_count + 1'b1;
        else if(pop)  data_count <= data_count - 1'b1;
        else          data_count <= data_count;
    end

    assign full = (data_count==DEPTH)? 1'b1 : 1'b0;
    assign overflow = full;

endmodule


module Cntr_out #(parameter DEPTH = 16, BITS = 8) (
    input                          clk,
    input                          rst,
    input                          push,
    input                          pop,
    output reg                     pndng,
    output reg [$clog2(DEPTH)-1:0] Pointer_out
);
    reg [$clog2(DEPTH)+1:0] data_count;
    logic                   empty;
    // read logic
    always @(posedge clk) begin
        if(rst)                 Pointer_out <= 'b0;
        else if(pop & !empty)   Pointer_out <= Pointer_out + 'b1;
        else                    Pointer_out <= Pointer_out;
    end

    // flags
    always @(negedge clk) begin
        if(rst)                 pndng <= 1'b0;
        else if(pop & !empty)   pndng <= 1'b1;
        else                    pndng <= 1'b0;
    end

    // flags
    always @(posedge clk) begin
        if(rst)                         data_count <= 'b0;
        else if(push & data_count > 0)  data_count <= data_count - 1'b1;
        else if(pop & !empty)           data_count <= data_count + 1'b1;
        else                            data_count <= data_count;
    end

    assign empty = (data_count==DEPTH)? 1'b1 : 1'b0;

endmodule


module mux #(parameter DEPTH=16,BITS=8) (
    input  [$clog2(DEPTH)-1:0] Pointer_out,
    input  [BITS-1:0]          D_out_n [DEPTH],
    output [BITS-1:0]          D_out
);

    assign D_out = D_out_n[Pointer_out];

endmodule


module demux #(parameter DEPTH=16,BITS=8) (
    input  [$clog2(DEPTH)-1:0] Pointer_in,
    input  [BITS-1:0]          D_in,
    output [BITS-1:0]          D_in_n [DEPTH]
);

    genvar i;
    generate 
        for (i = 0; i < DEPTH; i = i + 1) begin
            assign D_in_n[i] = Pointer_in==i ? D_in : {BITS{1'b0}};
        end
    endgenerate

endmodule


module flop #(parameter BITS=8) (
    input                 clk,
    input                 rst,
    input      [BITS-1:0] D,
    output reg [BITS-1:0] Q
);

always @ (posedge clk or posedge rst) 
    if (rst) Q <= {BITS{1'b0}};
    else     Q <= D;

endmodule
