module clk_half (
  input logic clk,
  output logic clk_out = 1'b0
);
  
  always_ff @(posedge clk)
    clk_out <= ~clk_out;
  
endmodule	