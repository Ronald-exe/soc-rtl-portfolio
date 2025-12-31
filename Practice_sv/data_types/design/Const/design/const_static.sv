class Jumbo_Packet;
  //max_size is a global constant, same for all Jumbo_packet instances 
  const int max_size = 5*10;

  byte payload [];
  
  function new(int size);
    //payload sizw is limited by the global constant max_size
    payload = new[size > max_size ? max_size : size];
  endfunction
endclass

module tb;
  Jumbo_Packet m_pkt;

  initial begin
    m_pkt = new(12);
        $display("size=%d", m_pkt.payload.size());
        $finish;
  end
endmodule
