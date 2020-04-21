module calculation(input logic Clk, input logic Reset, output dmg);

parameter [18][18] type_chart = {
  1,   1,   1,   1,   1, 0.5,   1,   0, 0.5,   1,   1,   1,   1, 1, 1,   1,   1,   1,
  2,   1, 0.5, 0.5,   1,   2, 0.5,   0,   2,   1,   1,   1,   1, 1, 1,   1,   1,   1,
  1,   2,   1,   1,   1, 0.5,   2,   1, 0.5,   1,   1,   2, 0.5, 1, 1,   1,   1,   1,
  1,   1,   1, 0.5, 0.5, 0.5,   1, 0.5,   0,   1,   1,   2,   1, 1, 1,   1,   1,   2,
  1,   1,   0,   2,   1,   2, 0.5,   1,   2,   2,   1, 0.5,   2, 1, 1,   1,   1,   1,
  1, 0.5,   2,   1, 0.5,   1,   2,   1, 0.5,   2,   1,   1,   1, 1, 2,   1,   1,   1,
  1, 0.5, 0.5, 0.5,   1,   1,   1, 0.5, 0.5, 0.5,   1,   2,   1, 2, 1,   1,   2, 0.5,
  0,   1,   1,   1,   1,   1,   1,   2,   1,   1,   1,   1,   1, 2, 1,   1, 0.5,   1,
  1,   1,   1,   1,   1,   2,   1,   1, 0.5, 0.5, 0.5,   1, 0.5, 1, 2,   1,   1,   2,
  1,   1,   1,   1,   1, 0.5,   2,   1,   2, 0.5, 0.5,   2,   1, 1, 2, 0.5,   1,   1,
  1,   1,   1,   1,   2,   2,   1,   1,   1,   2, 0.5, 0.5,   1, 1, 1, 0.5,   1,   1,
  1,   1, 0.5, 0.5,   2,   2, 0.5,   1, 0.5, 0.5,   2, 0.5,   1, 1, 1, 0.5,   1,   1,
  1,   1,   2, 
};

logic damage, modifier;

always_comb
begin
  if(move_type == pokemon_type && )
    modifier =
  if(move_type != pokemon_type && )
    modifier =
  if(move_type != pokemon_type && )

  if(physical)
    damage = ((22 * power * attack / defense) / 50 + 2) * modifier;
  else
    damage = ((22 * power * sp_att / sp_def) / 50 + 2) * modifier;

  dmg = damage
end

endmodule
