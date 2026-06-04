module cntr_4bit_updown (
  input logic reset,
  input logic clk,
  input logic dir, //1 for up, 0 for down
  output logic [3:0] count = 4'b0000
);
  
  logic [3:0] next_cnt;
  
  always_comb begin
    if (reset) next_cnt = 4'b0000;
    else begin
      if (dir) next_cnt = count + 1'b1;
      else next_cnt = count - 1'b1;
    end
  end
  
  genvar i;
  generate
    for (i = 0; i < 4; i++) begin : cntr_arr
      dff reg_mod (
        .d(next_cnt[i]),
        .clk(clk),
        .q(count[i])
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