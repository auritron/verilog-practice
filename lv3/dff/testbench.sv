`timescale 1ns/1ps

module dff_tb ();
  logic tb_d;
  logic tb_clk;
  logic tb_q;
  logic tb_q_not;
  
  dff DUT (
    .d(tb_d),
    .clk(tb_clk),
    .q(tb_q),
    .q_not(tb_q_not)
  );
  
  //clock pulse
  initial begin
    tb_clk = 0;
    forever #10 tb_clk = ~tb_clk;
  end
  
  //monitor
  initial
    begin
      $monitor ("Time = %0t | d = %b, clk = %b | q = %b, q_not = %b", $time, tb_d, tb_clk, tb_q, tb_q_not);

      //initialization
    tb_d = 0;
    @(posedge tb_clk);
    #5;
    
      //test case 1
    tb_d = 1;
    @(posedge tb_clk);
    #5;
    
      //test case 2
    tb_d = 1;
    @(posedge tb_clk);
    #5;
    
      //test case 3
    tb_d = 0;
    @(posedge tb_clk);
    #5;
    
      //test case 4
    tb_d = 1; #2;
    tb_d = 0; #2;
    tb_d = 1;
    @(posedge tb_clk);
    #5;
        
      $finish;
	end
endmodule