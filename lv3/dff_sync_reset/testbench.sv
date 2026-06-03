`timescale 1ns/1ps

module dff_sync_reset_tb ();
  logic tb_d;
  logic tb_reset;
  logic tb_clk;
  logic tb_q;
  
  dff_sync_reset DUT (
    .d(tb_d),
    .reset(tb_reset),
    .clk(tb_clk),
    .q(tb_q)
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
      $monitor ("Time = %0t | d = %b, reset = %b | clk = %b | q = %b", $time, tb_d, tb_reset, tb_clk, tb_q);

      //initialization
    tb_d = 0;
    tb_reset = 0;
    @(posedge tb_clk);
    #5;
    
      //test case 1
    tb_d = 1;
    tb_reset = 0;
    @(posedge tb_clk);
    #5;
      
      //test case 2
    tb_reset = 1;
    @(posedge tb_clk);
    #5;
    
      //test case 3
    tb_d = 0;
    tb_reset = 0;
    @(posedge tb_clk);
    #5;
      
    tb_d = 0;
    tb_reset = 1;
    @(posedge tb_clk);
    #5;
        
      $finish;
	end
endmodule