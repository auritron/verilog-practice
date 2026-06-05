module seq_detector_0b101 (
    input logic clk,
    input logic reset,
    input logic bit_in,
    output logic detected
);
  
  logic q0, q1;
  logic d0, d1; //detected?
  
  dff ff0 (
    .d(d0),
    .clk(clk),
    .reset(reset),
    .q(q0)
  );
  
  dff ff1 (
    .d(d1),
    .clk(clk),
    .reset(reset),
    .q(q1)
  );
  
  assign d1 = (q0 & ~bit_in);
  assign d0 = bit_in;
  
  assign detected = (q1 & ~q0 & bit_in);
  
endmodule
  

module dff (
  input logic d,
  input logic clk,
  input logic reset,
  output logic q
);
  
  always_ff @(posedge clk or posedge reset) begin
    if (reset) q <= 1'b0;
    else q <= d;
  end
  
endmodule