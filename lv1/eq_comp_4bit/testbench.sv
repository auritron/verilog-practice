`timescale 1ns/1ps

module eq_comp_4bit_tb;
  logic [3:0] tb_a;
  logic [3:0] tb_b;
  logic tb_e;
  
  eq_comp_4bit DUT (
    .in_a(tb_a),
    .in_b(tb_b),
    .equal(tb_e)
  );
  
  initial
    begin
      $monitor ("Time = %0t | a = %b, b = %b | equal = %b ", $time, tb_a, tb_b, tb_e);
      
      tb_a = 4'b0000; tb_b = 4'b0000; #10;
      tb_a = 4'b0010; tb_b = 4'b1100; #10;
      tb_a = 4'b0101; tb_b = 4'b1010; #10;
      tb_a = 4'b0110; tb_b = 4'b0110; #10;
      tb_a = 4'b1111; tb_b = 4'b1001; #10;
      tb_a = 4'b1111; tb_b = 4'b1111; #10;
      tb_a = 4'b0010; tb_b = 4'b1101; #10;
      tb_a = 4'b0011; tb_b = 4'b0011; #10;
      
      $finish;
    end
endmodule