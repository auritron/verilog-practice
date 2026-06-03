`timescale 1ns/1ps

module decoder_2to4_tb ();
  logic [1:0] tb_in;
  logic [3:0] tb_out;
  
  decoder_2to4 DUT (
    .in(tb_in),
    .out(tb_out)
  );
  
  initial
    begin
      $monitor ("Time = %0t | in = %b | out = %b", $time, tb_in, tb_out);
      
      tb_in = 2'b00; #10;
      tb_in = 2'b01; #10;
      tb_in = 2'b10; #10;
      tb_in = 2'b11; #10;
        
      $finish;
	end
endmodule