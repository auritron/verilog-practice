module half_adder(
  input logic in_a,
  input logic in_b,
  output logic sum,
  output logic carry
);
  
  assign sum = in_a ^ in_b;
  assign carry = in_a & in_b;

endmodule