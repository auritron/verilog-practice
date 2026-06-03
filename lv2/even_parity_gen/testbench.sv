`timescale 1ns/1ps

module even_parity_gen_tb ();
  logic [7:0] tb_data;
  logic tb_parity;
  
  even_parity_gen DUT (
    .data(tb_data),
    .parity(tb_parity)
  );
  
  initial
    begin
      $monitor ("Time = %0t | data = %b | parity = %b", $time, tb_data, tb_parity);
      
      tb_data = 8'b00101101; #10;
      tb_data = 8'b11010101; #10;
      tb_data = 8'b11011011; #10;
      tb_data = 8'b00000000; #10;
      tb_data = 8'b01111111; #10;
      tb_data = 8'b01011011; #10;
      tb_data = 8'b11011010; #10;
      tb_data = 8'b00001111; #10;
        
      $finish;
	end
endmodule