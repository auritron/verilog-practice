module mux_2to1(
  input logic in_a,
  input logic in_b,
  input logic sel,
  output logic out
);
  
  always @(*) 
    begin
      case (sel)
        1'b0 : out = in_a;
        1'b1 : out = in_b;
      endcase
    end 

endmodule