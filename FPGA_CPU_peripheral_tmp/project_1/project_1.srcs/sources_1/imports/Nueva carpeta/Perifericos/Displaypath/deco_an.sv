module deco_an(
        input logic     [1:0] IN,
        output logic    [3:0] OUT
);

    always_comb begin
        case(IN)
            2'b00:      OUT= 4'b1110;
            2'b01:      OUT= 4'b1101;
            2'b10:      OUT= 4'b1011;
            2'b11:      OUT= 4'b0111;
            default:    OUT= 4'b1111;
        endcase
    end
endmodule