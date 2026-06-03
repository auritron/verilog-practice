module full_adder (
  input logic in_a,
  input logic in_b,
  input logic in_carry,
  output logic out_sum,
  output logic out_carry
);
  
  assign out_sum = in_a ^ in_b ^ in_carry;
  assign out_carry = (in_a & in_b) | (in_carry & (in_a ^ in_b));
  
endmodule