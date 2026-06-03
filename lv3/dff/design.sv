module dff (
  input logic d,
  input logic clk,
  output logic q,
  output logic q_not
);
  
  always_ff @(posedge clk) begin
    q <= d;
    q_not <= ~d;
  end
  
endmodule