`timescale 1ns/1ps

module mux_4to1_tb ();
  logic [3:0] tb_in;
  logic [1:0] tb_sel;
  logic tb_out;
  
  mux_4to1 DUT (
    .in(tb_in),
    .sel(tb_sel),
    .out(tb_out)
  );
  
  initial
    begin
      $monitor ("Time = %0t | in = %b, sel = %b | out = %b", $time, tb_in, tb_sel, tb_out);
      
      tb_in = 4'b0110; tb_sel = 2'b00; #10;
      tb_in = 4'b1101; tb_sel = 2'b00; #10;
      tb_in = 4'b0111; tb_sel = 2'b01; #10;
      tb_in = 4'b0001; tb_sel = 2'b01; #10;
      tb_in = 4'b1011; tb_sel = 2'b10; #10;
      tb_in = 4'b1000; tb_sel = 2'b10; #10;
      tb_in = 4'b0110; tb_sel = 2'b11; #10;
      tb_in = 4'b1111; tb_sel = 2'b11; #10;
        
      $finish;
	end
endmodule