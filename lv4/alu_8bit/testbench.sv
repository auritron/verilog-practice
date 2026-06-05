`timescale 1ns/1ps

module ALU_8bit_tb ();
  logic [7:0] tb_a = 0;
  logic [7:0] tb_b = 0;
  Operation tb_op;
  logic [7:0] tb_res;
  
  ALU_8bit DUT (
    .a(tb_a),
    .b(tb_b),
    .op(tb_op),
    .result(tb_res)
  );
  
  //monitor
  initial
	begin
      $monitor ("Time = %0t | a = %0d, b= %0d, op = %s | result = %0d", $time, tb_a, tb_b, tb_op.name(), tb_res);

      //adding
      tb_op = ADD;
      tb_a = 56;
      tb_b = 23;
      
      #10
      
      //subtracting
      tb_op = SUB;
      tb_a = 96;
      tb_b = 67;
      
      #10
      
      //and
      tb_op = AND;
      tb_a = 34;
      tb_b = 57;
      
      #10
      
      //or
      tb_op = OR;
      tb_a = 125;
      tb_b = 0;
      
	  #10
      
      //xor
      tb_op = XOR;
      tb_a = 14;
      tb_b = 74;
      
      #10
      
      //not a
      tb_op = NOT_A;
      tb_a = 29;
      
      #10
      
      //shift left
      tb_op = SL;
      tb_a = 8;
      tb_b = 4;
      
      #10
      
      //shift right
      tb_op = SR;
      tb_a = 113;
      tb_b = 3;
      
      #10

      $finish;
	end
endmodule