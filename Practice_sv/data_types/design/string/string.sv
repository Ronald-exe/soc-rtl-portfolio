module tb(); 
string dialog = "Hola";

initial begin
  $display("output menssaje:$%s",dialog);

    for (int i = 0; i < dialog.len(); i++) begin
      $display("dialog[%0d] = %c", i, dialog[i]);
    end
end
endmodule
