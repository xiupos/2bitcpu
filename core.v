module core (in, clock, reset, out, rom_addr, rom_value);
  input clock, reset;

  output [1:0] out;
  input [1:0] in;

  output [1:0] rom_addr;
  input [3:0] rom_value;

  wire [1:0] w0, w1, w2, w3;
  wire carry;

  // レジスタ
  Register register (
    .in(w0),
    .clock(clock),
    .reset(reset),
    .load(|rom_value[3:2] | &(rom_value[1:0] ~^ 2'b10)),
    .out(w1)
  );

  // 外部出力
  Register output_led (
    .in(w0),
    .clock(clock),
    .reset(reset),
    .load(|(rom_value ^ 4'b0010) & |(rom_value[3:2] ^ 2'b01)),
    .out(out)
  );

  // プログラムカウンタ
  Counter counter (
    .in(w0),
    .clock(clock),
    .reset(reset),
    .load(~rom_value[3] | (rom_value[2] & carry)),
    .out(rom_addr)
  );

  // 1加算器
  assign w2 = w1 + rom_value[0];

  // キャリーフラグ
  dff carryflag (
    .d(&w1 & &(rom_value ~^ 4'b0001)),
    .clk(clock),
    .clrn(reset),
    .q(carry)
  );

  // 外部入力
  assign w3 = &rom_value[1:0] ? in : w2;

  // イミディエイトデータ
  assign w0 = |rom_value[3:2] ? rom_value[1:0] : w3;

endmodule
