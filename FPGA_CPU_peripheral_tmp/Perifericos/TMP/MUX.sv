`timescale 1ns / 1ps

module MUX #(parameter W = 4)(
    input   logic           EN,
    input   logic   [W-1:0] Sig_0,
    input   logic   [W-1:0] Sig_1,
    output  logic   [W-1:0] out
    );
    
    always_comb begin
        case(EN)
            'b0: out = Sig_0;  

            'b1: out = Sig_1;
        
            default: out = '0;
        endcase
    end
endmodule
