class Big_Packet;
  // size is an instance constant, determined at object creation
  const int size;

  byte payload [];

  function new();
    // The instance constant 'size' is assigned its value once in the constructor
    size = $urandom % 10;
    payload = new[ size ];
  endfunction
endclass

module tb;
  Big_Packet 	m_pkt;

  initial begin
    m_pkt = new();

    $display("size=%d", m_pkt.payload.size());
    $finish;
    // This will result in a compilation error
    // xmvlog: *E,CLSCON (testbench.sv,23|13): Instance constant class properties cannot be assigned outside of a constructor.
    // m_pkt.size = 50;
  end
endmodule
