module and_gate(
  input logic in_a,
  input logic in_b,
  output logic out
);
  
  assign out = in_a & in_b;
endmodule