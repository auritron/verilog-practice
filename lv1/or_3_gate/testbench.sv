`timescale 1ns/1ps

module or_3_gate_tb ();
  logic tb_a;
  logic tb_b;
  logic tb_c;
  logic tb_o;
  
  or_3_gate DUT (
    .in_a(tb_a),
    .in_b(tb_b),
    .in_c(tb_c),
    .out(tb_o)
  );
  
  initial
    begin
      $monitor ("Time = %0t | a = %b, b = %b, c = %b | out = %b", $time, tb_a, tb_b, tb_c, tb_o);
                
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