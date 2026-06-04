`timescale 1ns/1ps

module cntr_4bit_tb ();
  logic tb_reset;
  logic tb_clk;
  logic [3:0] tb_cnt;
  
  cntr_4bit DUT (
    .reset(tb_reset),
    .clk(tb_clk),
    .count(tb_cnt)
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
      $monitor ("Time = %0t | reset = %b | clk = %b | count = %0d", $time, tb_reset, tb_clk, tb_cnt);

      //initialization
      tb_reset = 1;
      @(posedge tb_clk);
      
      tb_reset = 0;
      
      @(posedge tb_clk);
      @(posedge tb_clk);
      @(posedge tb_clk);
      @(posedge tb_clk);
      @(posedge tb_clk);
      @(posedge tb_clk);
      @(posedge tb_clk);
      @(posedge tb_clk);
      @(posedge tb_clk);
      @(posedge tb_clk);
      @(posedge tb_clk);
      @(posedge tb_clk);
      @(posedge tb_clk);
      @(posedge tb_clk);
      @(posedge tb_clk);
      @(posedge tb_clk);
        
      $finish;
	end
endmodule