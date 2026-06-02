module or_3_gate (
    input logic in_a,
    input logic in_b,
    input logic in_c,
    output logic out
);

    assign out = in_a | in_b | in_c;
endmodule