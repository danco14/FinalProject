module random(input max, input min, output num);

  assign num = $urandom_range(max, min);

endmodule
