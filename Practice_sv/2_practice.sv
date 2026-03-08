class Statistics;
    int errors_tr;
    int total_tr;

    function new();
        this.errors_tr = 0;
        this.total_tr = 0;
    endfunction

    function new_trans(bit error);
        this.total_tr++;
        if(error == 1) begin
            this.errors_tr++; 
        end
    endfunction

    function  print_all();
        $display("=== ESTADÍSTICAS ===");
        $display("total_tr = 0x%0h, errors_tr = 0x%0h", this.total_tr, this.errors_tr);

    endfunction
endclass