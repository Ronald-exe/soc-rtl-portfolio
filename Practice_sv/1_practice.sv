class transaction;
    logic [3:0]     addr;
    logic [31:0]    dat_w;
    logic [31:0]    dat_r;
    logic [31:0]    mem      [16];

    function new ();                            //este es nuestro constructor
        this.addr   = 0;
        this.dat_w  = 0;
        this.dat_r  = 0;
        foreach (this.mem[i]) begin
            this.mem[i] = 0;
        end       
    endfunction

    function print_all (bit mode);
        if(mode == 1) begin
            $display("TRANSACCIÓN: WRITE");
            $display("addr = %0b, dat_w = 0x%0h, mem[addr] = 0x%0h", this.addr, this.dat_w,this.mem[this.addr]);
        end else begin
            $display("TRANSACCIÓN: READ");
            $display("addr = %0b,dat_r = 0x%0h, mem[addr] = 0x%0h", this.addr, this.dat_r,this.mem[this.addr]);
        end
    endfunction

    function do_write(logic [3:0] addr, logic [31:0] dat_w);
        this.addr = addr;
        this.dat_w = dat_w;
        this.mem[addr] = dat_w;
        this.print_all(1);
    endfunction

    function do_read(logic [3:0] addr, output logic [31:0] dat_r);
        this.addr = addr;
        dat_r = this.mem[addr];
        this.dat_r = dat_r;
        this.print_all(0);
    endfunction

endclass


