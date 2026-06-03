//4 bit adder module
module adder_4bit (
  input logic [3:0] in_a,
  input logic [3:0] in_b,
  input logic cin,
  output logic [3:0] sum,
  output logic cout
);
  
  logic [4:0] s;
  assign s[0] = cin;
  
  genvar i;
  generate
    for (i = 0; i < 4; i++) begin : fa_loop
      full_adder fa_mod (
        .in_a(in_a[i]),
        .in_b(in_b[i]),
        .in_carry(s[i]),
        .out_sum(sum[i]),
        .out_carry(s[i+1])
      );
    end
  endgenerate
  
  assign cout = s[4];
  
endmodule

//full adder module
module full_adder (
  input logic in_a,
  input logic in_b,
  input logic in_carry,
  output logic out_sum,
  output logic out_carry
);
  
  assign out_sum = in_a ^ in_b ^ in_carry;
  assign out_carry = (in_a & in_b) | (in_carry & (in_a ^ in_b));
  
endmodule