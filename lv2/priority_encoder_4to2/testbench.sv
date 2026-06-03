`timescale 1ns/1ps

module priority_encoder_4to2_tb ();
  logic [3:0] tb_in;
  logic [1:0] tb_out;
  logic tb_valid;
  
  priority_encoder_4to2 DUT (
    .in(tb_in),
    .out(tb_out),
    .valid(tb_valid)
  );
  
  initial
    begin
      $monitor ("Time = %0t | in = %b | out = %b, valid = %b", $time, tb_in, tb_out, tb_valid);
      
      tb_in = 4'b1101; #10;
      tb_in = 4'b1111; #10;
      tb_in = 4'b0101; #10;
      tb_in = 4'b0110; #10;
      tb_in = 4'b0001; #10;
      tb_in = 4'b1011; #10;
      tb_in = 4'b0010; #10;
      tb_in = 4'b0000; #10;
        
      $finish;
	end
endmodule