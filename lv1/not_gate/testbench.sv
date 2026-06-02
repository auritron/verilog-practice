`timescale 1ns/1ps

module not_gate_tb ();
  logic tb_i;
  logic tb_o;
  
  not_gate DUT (
    .in(tb_i),
    .out(tb_o)
  );
  
  initial
    begin
      $monitor ("Time = %0t | in = %b | out = %b", $time, tb_i, tb_o);
                
		tb_i = 0; #10;
		tb_i = 1; #10;
        
      $finish;
	end
endmodule