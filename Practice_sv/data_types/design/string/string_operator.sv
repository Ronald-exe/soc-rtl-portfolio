module tb;
   string str = "Hello World!";

   initial begin
      string tmp;

      // Print length of string "str"
      $display("1. str.len() = %0d", str.len());

      // Assign to tmp variable and put char "d" at index 3
      tmp = str;
      tmp.putc(3, "d");
      $display("2. tmp.putc(3, d) = %s", tmp);

      // Get the character at index 2 - ¡CORREGIDO!
      $display("3. str.getc(2) = %c (ASCII: %0d)", str.getc(2), str.getc(2));
      // Cambié %s por %c ↑

      // Convert all characters to lower case
      $display("4. str.tolower() = %s", str.tolower());

      // Comparison
      tmp = "Hello World!";
      $display("5. [tmp,str are same] str.compare(tmp) = %0d", str.compare(tmp));
      
      tmp = "How are you ?";
      $display("6. [tmp,str are diff] str.compare(tmp) = %0d", str.compare(tmp));

      // Ignore case comparison
      tmp = "hello world!";
      $display("7. [tmp is in lowercase] str.compare(tmp) = %0d", str.compare(tmp));
      // Esto dará ≠ 0 porque compare() SÍ distingue mayúsculas/minúsculas
      
      tmp = "Hello World!";
      $display("8. [tmp,str are same] str.compare(tmp) = %0d", str.compare(tmp));

      // Extract new string from i to j
      $display("9. str.substr(4,8) = %s", str.substr(4,8));
      $finish;
   end
endmodule
