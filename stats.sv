module stats(input pokemon_addr, input move_addr, output pokemon_data, output move_data);
  parameter none = 0;
  parameter water = 1;
  parameter fire = 2;
  parameter grass = 3;
  parameter flying = 4;
  parameter rock = 5;
  parameter groun = 6;
  parameter ice = 7;
  parameter ghost = 8;
  parameter steel = 9;
  parameter fighting = 10;
  parameter bug = 11;
  parameter electric = 12;
  parameter fairy = 13;
  parameter poison = 14;
  parameter psychic = 15;
  parameter dark = 16;
  parameter normal = 17;
  parameter dragon = 18;

  parameter physical = 1;
  parameter special = 0;

  parameter [][] Pokemon = {
    // Blastoise
    water,
    none,
    79, // Attack
    103, // Defense
    135, // Sp. Atk
    115, // Sp. Def
    78, // Speed
    // hydro_pump, crunch, ice_beam, aura_sphere,
    // Charizard
    fire,
    flying,
    78,
    84,
    78,
    109,
    85,
    100,
    // flamethrower, thunder_punch, air_slash, dragon_claw,
    // Venusaur
    grass,
    poison,
    80,
    82,
    83,
    100,
    100,
    80,
    // energy_ball, sludge_bomb, earthquake, petal_dance,
    // Pikachu
    electric,
    none,
    35,
    55,
    40,
    50,
    50,
    90,
    // thunderbolt, slam, surf, thunder,
    // Gengar
    ghost,
    poison,
    60,
    65,
    60,
    130,
    75,
    110,
    // shadow_ball, dark_pulse, sludge_bomb, thunderbolt,
    // Mew
    psychic,
    none,
    100,
    100,
    100,
    100,
    100,
    100,
    // psychic_move, bug_buzz, flash_cannon, play_rough,
    // Weezing
    poison,
    none,
    65,
    90,
    120,
    85,
    70,
    60,
    // sludge_bomb, shadow_ball, fire_blast, thunder
    // Dragonite
    dragon,
    flying,
    91,
    134,
    95,
    100,
    100,
    80,
    // dragon_pulse, rock_slide, blizzard, thunder_punch
  };

  assign pokemon_data = Pokemon[pokemon_addr];

  parameter [][] Move = {
    // Hydro pump
    water,
    special,
    110, // Power
    0.8, // Accuracy
    5, // PP
    // Ice beam
    ice,
    special,
    90,
    1,
    10,
    // Crunch
    dark,
    physical,
    80,
    1,
    15,
    // Aura sphere
    fighting,
    special,
    80,
    1.1,
    20,
    // Flamethrower
    fire,
    special,
    90,
    1,
    15,
    // Thunder punch
    electric,
    physical,
    75,
    1,
    15,
    // Air slash
    flying,
    special,
    75,
    0.95,
    15,
    // Dragon claw
    dragon,
    physical,
    80,
    1,
    15,
    // Energy ball
    grass,
    physical,
    90,
    1,
    10,
    // Sludge bomb
    poison,
    special,
    90,
    1,
    10,
    // Earthquake
    ground,
    physical,
    100,
    1,
    10,
    // Petal dance
    grass,
    special,
    120,
    1,
    10,
    // Thunderbolt
    electric,
    special,
    90,
    1,
    15,
    // Slam
    normal,
    physical,
    80,
    0.75,
    20,
    // Surf
    water,
    special,
    90,
    1,
    15,
    // Thunder
    electric,
    special,
    110,
    0.7,
    10,
    // Dark pulse
    dark,
    special,
    80,
    1,
    15,
    // Shadow ball
    ghost,
    special,
    80,
    1,
    15,
    // Psychic
    psychic,
    special,
    90,
    1,
    10,
    // Play rough
    fairy,
    physical,
    90,
    0.9,
    10,
    // Flash cannon
    steel,
    special,
    80,
    1,
    10,
    // Bug buzz
    bug,
    special,
    90,
    1,
    10,
    // Fire Blast
    fire,
    special,
    110,
    0.85,
    5,
    // Rock slide
    rock,
    physical,
    75,
    0.9,
    10,
    // Dragon pulse
    dragon,
    special,
    85,
    1,
    10,
    // Blizzard
    ice,
    special,
    110,
    0.7,
    5
  };

  assign move_data = Move[move_addr];

endmodule
