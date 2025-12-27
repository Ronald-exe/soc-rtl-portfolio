module d_ff (
  input logic  clk,
  input logic  rst,
  input logic  d,
  output logic q
  );

  always_ff @(posedge clk or negedge rst) begin
    if(!rst)
          q <= 1'b0;
    else
          q <= d;
  end

  endmodule
