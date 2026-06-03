`timescale 1ns/1ps

module full_adder_tb ();
  logic tb_a;
  logic tb_b;
  logic tb_cin;
  logic tb_sum;
  logic tb_cout;
  
  full_adder DUT (
    .in_a(tb_a),
    .in_b(tb_b),
    .in_carry(tb_cin),
    .out_sum(tb_sum),
    .out_carry(tb_cout)
  );
  
  initial
    begin
      $monitor ("Time = %0t | a = %b, b = %b, cin = %b | cout = %b, out = %b", $time, tb_a, tb_b, tb_cin, tb_cout, tb_sum);
                
		tb_a = 0; tb_b = 0; tb_cin = 0; #10;
		tb_a = 0; tb_b = 0; tb_cin = 1; #10;
		tb_a = 0; tb_b = 1; tb_cin = 0; #10;
		tb_a = 0; tb_b = 1; tb_cin = 1; #10;
		tb_a = 1; tb_b = 0; tb_cin = 0; #10;
		tb_a = 1; tb_b = 0; tb_cin = 1; #10;
		tb_a = 1; tb_b = 1; tb_cin = 0; #10;
		tb_a = 1; tb_b = 1; tb_cin = 1; #10;
        
      $finish;
	end
endmodule