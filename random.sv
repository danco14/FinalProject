module random(input logic Clk,
              input logic Reset,
              output logic [7:0] num
              );

  // XORShift algorithm taken from https://en.wikipedia.org/wiki/Xorshift
  parameter [31:0] state = 32'hECEBCAFE;

  logic [31:0] shift;
  logic [31:0] shift_in = 32'hECEBCAFE;
  // logic [31:0] nl = 32'DEADBEEF;
  logic [31:0] a, b;

  always_ff @ (posedge Clk)
  begin
    if(Reset)
      shift <= state;

    else
      shift <= shift_in;
  end

  always_comb
  begin
    a = shift ^ (shift << 13);
    b = a ^ (a >> 17);
    shift_in = b ^ (b << 5);

    num = shift[15:8];
  end

endmodule
