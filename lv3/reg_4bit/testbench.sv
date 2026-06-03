`timescale 1ns/1ps

module reg_4bit_tb ();
  logic [3:0] tb_d;
  logic tb_clk;
  logic [3:0] tb_q;
  
  reg_4bit DUT (
    .d(tb_d),
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
      $monitor ("Time = %0t | d = %b | clk = %b | q = %b", $time, tb_d, tb_clk, tb_q);

      //initialization
    tb_d = 4'b0000;
    @(posedge tb_clk);
    #5;
      
      tb_d = 4'b1101;
    @(posedge tb_clk);
    #5;
      
      tb_d = 4'b0011;
    @(posedge tb_clk);
    #5;
      tb_d = 4'b0011;
    @(posedge tb_clk);
    #5;
      
      tb_d = 4'b1111; #2;
      tb_d = 4'b0000; #2;
    @(posedge tb_clk);
    #5;
        
      $finish;
	end
endmodule