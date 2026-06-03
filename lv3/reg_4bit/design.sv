module reg_4bit (
  input logic [3:0] d,
  input logic clk,
  output logic [3:0] q
);
  
  genvar i;
  generate
    for (i = 0; i < 4; i++) begin : reg_arr
      dff reg_mod (
        .d(d[i]),
        .clk(clk),
        .q(q[i])
      );
    end
  endgenerate
  
endmodule	
  

module dff (
  input logic d,
  input logic clk,
  output logic q
);
  
  always_ff @(posedge clk) q <= d;
  
endmodule