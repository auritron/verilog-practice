typedef enum logic [2:0] {
  ADD,   //000
  SUB,   //001
  AND,   //010
  OR,    //011
  XOR,   //100
  NOT_A, //101
  SL,    //110
  SR     //111
} Operation;

module ALU_8bit (
  input logic [7:0] a,
  input logic [7:0] b,
  input Operation op,
  output logic [7:0] result
);
  
  always_comb begin
    case (op)
      ADD:   result = a + b;
      SUB:   result = a - b;
      AND:   result = a & b;
      OR:    result = a | b;
      XOR:   result = a ^ b;
      NOT_A: result = ~a;
      SL:	 result = a << b;
      SR:	 result = a >> b;
      default: result = a + b;
    endcase
  end
  
endmodule