module dff_sync_reset (
  input logic d,
  input logic reset,
  input logic clk,
  output logic q
);
  
  always_ff @(posedge clk) begin
    if (reset) q <= 0;
    else q <= d;
  end
  
endmodule