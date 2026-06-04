`timescale 1ns/1ps

module cntr_4bit_updown_tb ();
  logic tb_clk;
  logic tb_reset;
  logic tb_dir;
  logic [3:0] tb_cnt;
  
  cntr_4bit_updown DUT (
    .reset(tb_reset),
    .clk(tb_clk),
    .dir(tb_dir),
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
      $monitor ("Time = %0t | reset = %b, clk = %b, dir = %b | count = %0d", $time, tb_reset, tb_clk, tb_dir, tb_cnt);

      tb_reset = 1; //reset initially
      tb_dir = 1; //set as upcounter initially
      @(posedge tb_clk);
      tb_reset = 0;
      @(posedge tb_clk);
      
      #200; //count through 10 more clock cycles
      tb_dir = 0; //count down
      
      #120; //count through 6 more clock cycles
      tb_reset = 1; //reset again while keeping dir = 0
      @(posedge tb_clk);
      tb_reset = 0; 
      
      #160; //count through 8 clock cycles
      tb_dir = 1; //switch back to up
      
      #100; //count through 5 clock cycles
        
      $finish;
	end
endmodule