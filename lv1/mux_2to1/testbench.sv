`timescale 1ns/1ps

module mux_2to1_tb;
  logic tb_a;
  logic tb_b;
  logic tb_s;
  logic tb_o;
  
  mux_2to1 DUT (
    .in_a(tb_a),
    .in_b(tb_b),
    .sel(tb_s),
    .out(tb_o)
  );
  
  initial
    begin
      $monitor ("Time = %0t | a = %b, b = %b, sel = %b | out = %b", $time, tb_a, tb_b, tb_s, tb_o);
      
      tb_a = 0; tb_b = 0; tb_s = 0; #10;
      tb_a = 0; tb_b = 0; tb_s = 1; #10;
      tb_a = 0; tb_b = 1; tb_s = 0; #10;
      tb_a = 0; tb_b = 1; tb_s = 1; #10;
      tb_a = 1; tb_b = 0; tb_s = 0; #10;
      tb_a = 1; tb_b = 0; tb_s = 1; #10;
      tb_a = 1; tb_b = 1; tb_s = 0; #10;
      tb_a = 1; tb_b = 1; tb_s = 1; #10;
      
      $finish;
    end
endmodule