module majority_circuit (
  input logic a,
  input logic b,
  input logic c,
  output logic y
);
  
  assign y = (a & b) + (b & c) + (a & c); 
  
endmodule