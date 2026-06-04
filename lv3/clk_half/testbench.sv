`timescale 1ns/1ps

module clk_half_tb ();
  logic tb_clk;
  logic tb_clk_half;
  
  clk_half DUT (
    .clk(tb_clk),
    .clk_out(tb_clk_half)
  );
  
  //clock pulse
  initial begin
    tb_clk = 0;
    forever begin
      #10; 
      tb_clk = ~tb_clk;
    end
  end
  
  //monitor
  initial
    begin
      $monitor ("Time = %0t | clk = %b | clk(half) = %b", $time, tb_clk, tb_clk_half);

      //200 time units monitoring (10 cycles)
      #200
        
      $finish;
	end
endmodule