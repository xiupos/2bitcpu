module divfreq (clock, reset, out);
  parameter MAG = 5000000;

	input clock, reset;
	output reg out;
	reg [25:0] c;

	always @(posedge clock or negedge reset) begin
		if (!reset) begin
			c <= 0;
			out <= 0;
		end else if (c == (MAG-1)) begin // 10Hz
			c <= 0;
			out <= ~out;
		end else begin
			c <= c + 1;
		end
	end
endmodule
