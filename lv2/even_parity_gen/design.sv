module even_parity_gen (
  input logic [7:0] data,
  output logic parity
);
  
  assign parity = ^data; 
  
endmodule