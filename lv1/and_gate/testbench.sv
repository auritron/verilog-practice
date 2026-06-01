`timescale 1ns/1ps

module and_gate_tb;
  logic input_a;
  logic input_b;
  logic output_o;
  
  and_gate DUT (
    .in_a(input_a),
    .in_b(input_b),
    .out(output_o)
  );
  
  initial
    begin
      $monitor ("Time = %0t | a = %b, b = %b | out = %b", $time, input_a, input_b, output_o);
      
      input_a = 0; input_b = 0; #10;
      input_a = 1; input_b = 0; #10;
      input_a = 0; input_b = 1; #10;
      input_a = 1; input_b = 1; #10;
      
      $finish;
    end
endmodule