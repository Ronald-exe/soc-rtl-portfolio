`timescale 1ns / 1ps

module Top_TMP(
    input   logic           clk,             
    input   logic           rst,             
    input   logic           address,
    input   logic   [31:0]  in,  
    input   logic           wr_en,
    input   logic           vauxp6,
    input   logic           vauxn6,
    input   logic           vp_in,
    input   logic           vn_in,
    
    output  logic   [31:0]  out        
);
    logic           wr_ctrl_1;
    logic           wr_ctrl_2;
    logic           wr_data;
    logic   [31:0]  limpiador;
    logic   [31:0]  out_ctrl;
    logic   [31:0]  out_data;
    logic   [7:0]   ADC_data;

    ADC adc(
        .clk                (clk),   
        .vauxp6             (vauxp6),
        .vauxn6             (vauxn6),
        .vp_in              (vp_in), 
        .vn_in              (vn_in),
        .led                (ADC_data) 
    );      

    MUX #(.W(32)) mux_1(
    .EN                     (address),
    .Sig_0                  (wr_en),
    .Sig_1                  ('d0),
    .out                    (wr_ctrl_1)
    );

    control_TMP TMP_i(
        .clk                (clk),
        .rst                (rst),
        .in                 (out_ctrl),
        .limpiador          (limpiador),
        .wr_data            (wr_data),
        .wr_ctrl            (wr_ctrl_2)    
    );       

    registro_control reg_control (
        .clk                (clk),
        .rst                (rst),
        .wr_1               (wr_ctrl_1),
        .wr_2               (wr_ctrl_2),
        .limpiador          (limpiador),
        .in                 (in),
        .out                (out_ctrl)        
    );

    registros_datos reg_datos (
        .clk                (clk),
        .rst                (rst),
        .wr_1               (wr_data),
        .in                 (ADC_data),
        .out                (out_data)                            
    );

    MUX #(.W(32)) mux_2(
    .EN                     (address),
    .Sig_0                  (out_ctrl),
    .Sig_1                  (out_data),
    .out                    (out)
    );

endmodule


