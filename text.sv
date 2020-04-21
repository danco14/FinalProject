module text();

  //hex codes of the pokemon names
  parameter [][] blastoise = {8'h42, 8'h4c, 8'h41, 8'h53, 8'h54, 8'h4f, 8'h49, 8'h53, 8'h45};
  parameter [][] charizard = {8'h43, 8'h48, 8'h41, 8'h52, 8'h49, 8'h5a, 8'h41, 8'h52, 8'h44};
  parameter [][] dragonite = {8'h44, 8'h52, 8'h41, 8'h47, 8'h4f, 8'h4e, 8'h49, 8'h54, 8'h45};
  parameter [][] gengar =    {8'h47, 8'h45, 8'h4e, 8'h47, 8'h41, 8'h52};
  parameter [][] mew =       {8'h4d, 8'h45, 8'h57};
  parameter [][] pikachu =   {8'h50, 8'h49, 8'h4b, 8'h41, 8'h43, 8'h48, 8'h55};
  parameter [][] venusaur =  {8'h56, 8'h45, 8'h4e, 8'h55, 8'h53, 8'h41, 8'h55, 8'h52};
  parameter [][] weezing =   {8'h57, 8'h45, 8'h45, 8'h5a, 8'h49, 8'h4e, 8'h47};
  parameter [2:0] pokemon_names = {blastoise, charizard, dragonite, gengar, mew, piakchu, venusaur, weezing};

endmodule;
