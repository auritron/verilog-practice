`timescale 1ns/1ps

module shift_reg_4bit_tb ();
  logic tb_clk;
  logic tb_reset;
  logic tb_serial_in;
  logic [3:0] tb_q;
  
  shift_reg_4bit DUT (
    .reset(tb_reset),
    .clk(tb_clk),
    .serial_in(tb_serial_in),
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
      $monitor ("Time = %0t | reset = %b, serial_in = %b | clk = %b | q = %b", $time, tb_reset, tb_serial_in, tb_clk, tb_q);

      tb_reset = 1; //reset initially
      #5;
      tb_reset = 0;
      tb_serial_in = 0; //initialize as 0
      @(posedge tb_clk);
      
      tb_serial_in = 1;
      @(posedge tb_clk);
      
      tb_serial_in = 0;
      @(posedge tb_clk);
      
      tb_serial_in = 1;
      @(posedge tb_clk);
      
      tb_serial_in = 1;
      @(posedge tb_clk);
      
      tb_serial_in = 0;
      @(posedge tb_clk);
      
      tb_serial_in = 1;
      @(posedge tb_clk);
      
      tb_reset = 1;
      #5;
      tb_reset = 0;
      
      tb_serial_in = 0;
      @(posedge tb_clk);
      
      tb_serial_in = 0;
      @(posedge tb_clk);
      
      tb_serial_in = 1;
      @(posedge tb_clk);
      
      tb_serial_in = 0;
      @(posedge tb_clk);

      $finish;
	end
endmodule