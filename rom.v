module Rom (addr, data);
  input [1:0] addr;
  output [3:0] data;

  function [3:0] rom_out;
    input [1:0] addr;
    case (addr)
      2'b00: rom_out = 4'b0100;
      2'b01: rom_out = 4'b0101;
      2'b10: rom_out = 4'b0111;
      2'b11: rom_out = 4'b0110;
      default: rom_out = 4'hx;
    endcase
  endfunction

  assign data = rom_out(addr);
endmodule
