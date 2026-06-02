module eq_comp_4bit(
  input logic [3:0] in_a,
  input logic [3:0] in_b,
  output logic equal
);
  
  logic [3:0] eq_in;
  always_comb begin
    for (int i = 0; i < 4; i = i+1)
      eq_in[i] = in_a[i] ~^ in_b[i];
  end
  
  assign equal = &eq_in;
  
  //can also be done simply with "assign equal = (in_a == in_b); but that wasn't fun enough :3"

endmodule