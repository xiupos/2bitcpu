module Register (in, clock, reset, load, out);
  input [1:0] in;
  input clock, reset, load;
  output [1:0] out;

  genvar i;
  generate
    for (i = 0; i < 2; i = i + 1) begin: generate_dff
      dff dff (
        .d(load ? out[i] : in[i]),
        .clk(clock),
        .clrn(reset),
        .q(out[i])
      );
    end
  endgenerate
endmodule
