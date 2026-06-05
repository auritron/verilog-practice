module shift_reg_4bit (
  input logic reset,
  input logic clk,
  input logic serial_in,
  output logic [3:0] q = 4'b0000
);
  
  logic [4:0] data; 
  assign data[0] = serial_in;
  
  genvar i;
  generate
    for (i = 0; i < 4; i++) begin : sr_arr
      dff reg_mod (
        .d(data[i]),
        .clk(clk),
        .reset(reset),
        .q(data[i+1])
      );
    end
  endgenerate
  
  assign q = data[4:1];
  
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