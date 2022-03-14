module Counter (in, clock, reset, load, out);
  input [1:0] in;
  input clock, reset, load;
  output [1:0] out;
  wire [1:0] w;

  assign w = load ? out + 1 : in;

  genvar i;
  generate
    for (i = 0; i < 2; i = i + 1) begin: generate_dff
      dff dff (
        .d(w[i]),
        .clk(clock),
        .clrn(reset),
        .q(out[i])
      );
    end
  endgenerate
endmodule
