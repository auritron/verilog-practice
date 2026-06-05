`timescale 1ns/1ps

module traffic_light_seq_tb ();
  logic tb_clk;
  TrafficSignal tb_signal;
  
  traffic_light_seq DUT (
    .clk(tb_clk),
    .signal(tb_signal)
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
      $monitor ("Time = %0t | clk = %b | signal = %s", $time, tb_clk, tb_signal.name());

      #180; //9 cycles

      $finish;
	end
endmodule