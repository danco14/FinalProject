module pokemon_names(input [9:0] DrawX, DrawY,
                     input [2:0] poke_id,
                     output [7:0] text_hex);

  //hex codes of the pokemon names
  parameter [7:0] blastoise [0:8] = {8'h42, 8'h4c, 8'h41, 8'h53, 8'h54, 8'h4f, 8'h49, 8'h53, 8'h45};
  parameter [7:0] charizard [0:8] = {8'h43, 8'h48, 8'h41, 8'h52, 8'h49, 8'h5a, 8'h41, 8'h52, 8'h44};
  parameter [7:0] dragonite [0:8] = {8'h44, 8'h52, 8'h41, 8'h47, 8'h4f, 8'h4e, 8'h49, 8'h54, 8'h45};
  parameter [7:0] gengar [0:4] =    {8'h47, 8'h45, 8'h4e, 8'h47, 8'h41, 8'h52};
  parameter [7:0] mew [0:2] =       {8'h4d, 8'h45, 8'h57};
  parameter [7:0] pikachu [0:6] =   {8'h50, 8'h49, 8'h4b, 8'h41, 8'h43, 8'h48, 8'h55};
  parameter [7:0] venusaur [0:7] =  {8'h56, 8'h45, 8'h4e, 8'h55, 8'h53, 8'h41, 8'h55, 8'h52};
  parameter [7:0] weezing [0:6] =   {8'h57, 8'h45, 8'h45, 8'h5a, 8'h49, 8'h4e, 8'h47};
  parameter pokemon_names [0:7] = '{blastoise, charizard, dragonite, gengar, mew, pikachu, venusaur, weezing};

endmodule
