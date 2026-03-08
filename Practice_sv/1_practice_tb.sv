module testbench;
    transaction tx;
    logic [31:0] read_data;

    initial begin
        tx = new();
        
        // Prueba write
        tx.do_write(5'h5, 32'hA5A5A5A5);
        
        // Prueba read
        tx.do_read(5'h5, read_data);
        
        $display("Dato leído: 0x%0h", read_data);
    end
endmodule