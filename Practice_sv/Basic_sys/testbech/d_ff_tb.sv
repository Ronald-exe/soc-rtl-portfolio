`timescale 1ns/1ps

module d_ff_tb ();

//signals
  logic clk;
  logic rst;
  logic d;
  logic q;
  
  // instantiate design
  d_ff d_ff0(
      .clk(clk),
      .rst(rst),
      .d(d),
      .q(q)
    );

    //create clock
  initial clk <=1'b1;
  always #1  clk <= ~clk;


  task appli_rst();
      rst <= 0;
      d   <= 0;
  #10 rst <= 1;
  endtask



  initial begin
     $dumpfile("wave.vcd");  // Nombre del archivo de waveforms
     $dumpvars(0, d_ff_tb);  // 0 = todas las señales

    appli_rst();
    #10  d   <= 1;
    #10  d   <= 0;
    #10  d   <= 1;
    #10  d   <= 0;
end

initial begin
  $monitor("monitor: time=%t,d=%b,q=%b",$time,d,q);
  #200 $finish;
end

endmodule
