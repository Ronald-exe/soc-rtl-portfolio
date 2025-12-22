module mult_with_no_sm#(
  parameter N = 4
)(
	//entradas
  input logic clk,	//clock
  input logic rst,	//reset
  
  input logic [N-1:0] A,	//valor de A
  input logic [N-1:0] B,	//valor de B
  
  input logic load_A,		//enable de A para cargar A de la FSM
  input logic load_B,		//enable de B para cargar B de la FSM
  input logic load_add,		//enable de add_subb de la FSM
  input logic shift_HQ_LQ_Q_1,	//enable para hacer desplazamiento de la FSM
  input logic add_sub,		//enable de la FSM que define sumar o restar
  
  output logic [1:0] Q_LSB,	//arreglo de salida Q0 y Q-1 que entra a retroalimentación a la FSM como entrada
  output logic [2*N-1:0] Y	// salida del datapath
);
 
  logic [N-1:0] M;		//Registro que lleva el valor de A
  logic [N-1:0] adder_sub_out;	//Resultado de sumar o restar
  logic signed [2*N:0] shift;	//registro de cambios de HQ+LQ+Q-1
  logic [N-1:0] HQ;		//HQ
  logic [N-1:0] LQ;		//LQ
  logic Q_1;			//Q-1
  
  //reg_M

  always_ff@(posedge clk) begin 
    if(rst) 
      M<='b0;
    else 
      M <= (load_A)? A : M;
  end
  
  // adder/sub
  
  always_comb begin 
    if(add_sub) 
      adder_sub_out = HQ + M;
    else
      adder_sub_out = HQ - M;
  end
  
  //shift registers
  
  always_comb begin 
    
    HQ = shift[2*N:N+1];
    LQ = shift[N:1];
    Q_1 = shift[0];
    Q_LSB = {LQ[0],Q_1};
	Y = {HQ,LQ};
  end
  
  always_ff@(posedge clk) begin 
    if(rst)
      shift <= 'b0;
    else if(shift_HQ_LQ_Q_1)
      //arithmetic shift
      shift <= ($signed(shift))>>>1;
    else begin 
      if(load_B)
        shift[N:1] <= B;
      if(load_add)
        shift[2*N:N+1] <= adder_sub_out;
      end
  end
  
endmodule
