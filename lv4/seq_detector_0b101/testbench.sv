`timescale 1ns/1ps

module seq_detector_0b101_tb ();
  logic tb_clk;
  logic tb_reset;
  logic tb_bit_in;
  logic tb_detected;
  
  seq_detector_0b101 DUT (
    .reset(tb_reset),
    .clk(tb_clk),
    .bit_in(tb_bit_in),
    .detected(tb_detected)
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
      $monitor ("Time = %0t | reset = %b, bit_in = %b | clk = %b | detected = %b", $time, tb_reset, tb_bit_in, tb_clk, tb_detected);

      tb_reset = 1; //reset initially
      #5;
      tb_reset = 0;
      tb_bit_in = 0; //initialize as 0
      @(posedge tb_clk);
      
      tb_bit_in = 0; //0b00
      @(posedge tb_clk);
      
      tb_bit_in = 1; //0b001
      @(posedge tb_clk);
      
      tb_bit_in = 0; //0b0010
      @(posedge tb_clk);

      tb_bit_in = 1; //0b00101 (detected)
      @(posedge tb_clk);

      tb_bit_in = 1; //0b001011
      @(posedge tb_clk);

      tb_bit_in = 0; //0b0010110
      @(posedge tb_clk);
      
      tb_bit_in = 1; //0b00101101 (detected)
      @(posedge tb_clk);

      tb_bit_in = 0; // //0b001011010
      @(posedge tb_clk);
      
      tb_reset = 1; //midway reset in sequence
      #5;
      tb_reset = 0;
      
      tb_bit_in = 1; //0b1
      @(posedge tb_clk);
      
      tb_bit_in = 1; //0b11
      @(posedge tb_clk);
      
      tb_bit_in = 0; //0b110
      @(posedge tb_clk);

      tb_bit_in = 1; //0b1101 (detected)
      @(posedge tb_clk);

      $finish;
	end
endmodule