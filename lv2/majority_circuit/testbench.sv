`timescale 1ns/1ps

module majority_circuit_tb ();
  logic tb_a;
  logic tb_b;
  logic tb_c;
  logic tb_y;
  
  majority_circuit DUT (
    .a(tb_a),
    .b(tb_b),
    .c(tb_c),
    .y(tb_y)
  );
  
  initial
    begin
      $monitor ("Time = %0t | a = %b, b = %b, c = %b | y = %b", $time, tb_a, tb_b, tb_c, tb_y);
      
      tb_a = 0; tb_b = 0; tb_c = 0; #10;
      tb_a = 0; tb_b = 0; tb_c = 1; #10;
      tb_a = 0; tb_b = 1; tb_c = 0; #10;
      tb_a = 0; tb_b = 1; tb_c = 1; #10;
      tb_a = 1; tb_b = 0; tb_c = 0; #10;
      tb_a = 1; tb_b = 0; tb_c = 1; #10;
      tb_a = 1; tb_b = 1; tb_c = 0; #10;
      tb_a = 1; tb_b = 1; tb_c = 1; #10;
        
      $finish;
	end
endmodule