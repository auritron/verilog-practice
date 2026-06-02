`timescale 1ns/1ps

module half_adder_tb;
  logic tb_a;
  logic tb_b;
  logic tb_s;
  logic tb_c;
  
  half_adder DUT (
    .in_a(tb_a),
    .in_b(tb_b),
    .sum(tb_s),
    .carry(tb_c)
  );
  
  initial
    begin
      $monitor ("Time = %0t | a = %b, b = %b | carry = %b , sum = %b ", $time, tb_a, tb_b, tb_c, tb_s);
      
      tb_a = 0; tb_b = 0; #10;
      tb_a = 0; tb_b = 1; #10;
      tb_a = 1; tb_b = 0; #10;
      tb_a = 1; tb_b = 1; #10;
      
      $finish;
    end
endmodule