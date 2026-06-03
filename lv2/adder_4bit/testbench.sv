`timescale 1ns/1ps

module adder_4bit_tb ();
  logic [3:0] tb_a;
  logic [3:0] tb_b;
  logic tb_cin;
  logic [3:0] tb_sum;
  logic tb_cout;
  
  adder_4bit DUT (
    .in_a(tb_a),
    .in_b(tb_b),
    .cin(tb_cin),
    .sum(tb_sum),
    .cout(tb_cout)
  );
  
  initial
    begin
      $monitor ("Time = %0t | a = %d, b = %d, cin = %b | sum = %0d", $time, tb_a, tb_b, tb_cin, (tb_sum + (tb_cout*16)));
                
      tb_a = 4'd0; tb_b = 4'd0; tb_cin = 1'b0; #10;
      tb_a = 4'd4; tb_b = 4'd1; tb_cin = 1'b1; #10;
      tb_a = 4'd7; tb_b = 4'd8; tb_cin = 1'b0; #10;
      tb_a = 4'd2; tb_b = 4'd2; tb_cin = 1'b0; #10;
      tb_a = 4'd11; tb_b = 4'd14; tb_cin = 1'b1; #10;
      tb_a = 4'd0; tb_b = 4'd5; tb_cin = 1'b1; #10;
      tb_a = 4'd15; tb_b = 4'd5; tb_cin = 1'b1; #10;
      tb_a = 4'd12; tb_b = 4'd7; tb_cin = 1'b0; #10;
        
      $finish;
	end
endmodule