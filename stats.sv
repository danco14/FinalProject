module stats(input logic [2:0] pokemon_addr1,
             input logic [2:0] pokemon_addr2,
             input logic [2:0] move_addr1,
             input logic [2:0] move_addr2,
             output logic [11:0][7:0] pokemon_data1,
             output logic [11:0][7:0] pokemon_data2,
             output logic [4:0][7:0] move_data1,
             output logic [4:0][7:0] move_data2
             );

  parameter normal = 0;
  parameter fighting = 1;
  parameter flying = 2;
  parameter poison = 3;
  parameter ground = 4;
  parameter rock = 5;
  parameter bug = 6;
  parameter ghost = 7;
  parameter steel = 8;
  parameter fire = 9;
  parameter water = 10;
  parameter grass = 11;
  parameter electric = 12;
  parameter psychic = 13;
  parameter ice = 14;
  parameter dragon = 15;
  parameter dark = 16;
  parameter fairy = 17;
  parameter none = 18;

  parameter physical = 1;
  parameter special = 0;

  parameter [7:0][11:0][7:0] Pokemon = {
    // Blastoise
    {water,
    none,
    79,  // HP
    83,  // Attack
    100, // Defense
    85,  // Sp. Atk
    105, // Sp. Def
    78,  // Speed
    0, 1, 2, 3}, // Move addresses
    // hydro_pump, crunch, ice_beam, aura_sphere,
    // Charizard
    {fire,
    flying,
    78,
    84,
    78,
    109,
    85,
    100,
    4, 5, 6, 7},
    // flamethrower, thunder_punch, air_slash, dragon_claw,
    // Dragonite
    {dragon,
    flying,
    91,
    134,
    95,
    100,
    100,
    80,
    24, 23, 25, 5},
    // dragon_pulse, rock_slide, blizzard, thunder_punch
    // Gengar
    {ghost,
    poison,
    60,
    65,
    60,
    130,
    75,
    110,
    17, 16, 9, 12},
    // shadow_ball, dark_pulse, sludge_bomb, thunderbolt,
    // Mew
    {psychic,
    none,
    100,
    100,
    100,
    100,
    100,
    100,
    18, 21, 20, 19},
    // psychic_move, bug_buzz, flash_cannon, play_rough,
    // Pikachu
    {electric,
    none,
    35,
    55,
    40,
    50,
    50,
    90,
    12, 13, 14, 15},
    // thunderbolt, slam, surf, thunder,
    // Venusaur
    {grass,
    poison,
    80,
    82,
    83,
    100,
    100,
    80,
    8, 9, 10, 11},
    // energy_ball, sludge_bomb, earthquake, petal_dance,
    // Weezing
    {poison,
    none,
    65,
    90,
    120,
    85,
    70,
    60,
    9, 17, 22, 15}
    // sludge_bomb, shadow_ball, fire_blast, thunder
  };

  assign pokemon_data1 = Pokemon[pokemon_addr1];
  assign pokemon_data2 = Pokemon[pokemon_addr2];

  parameter [25:0][4:0][7:0] Move = {
    // Struggle
    // {none,
    // physical,
    // 50,
    // 110,
    // 100},
    // Hydro pump
    {water,
    special,
    110, // Power
    80, // Accuracy
    5}, // PP
    // Ice beam
    {ice,
    special,
    90,
    100,
    10},
    // Crunch
    dark,
    physical,
    80,
    100,
    15,
    // Aura sphere
    {fighting,
    special,
    80,
    110,
    20},
    // Flamethrower
    {fire,
    special,
    90,
    100,
    15},
    // Thunder punch
    {electric,
    physical,
    75,
    100,
    15},
    // Air slash
    {flying,
    special,
    75,
    95,
    15},
    // Dragon claw
    {dragon,
    physical,
    80,
    100,
    15},
    // Energy ball
    {grass,
    physical,
    90,
    100,
    10},
    // Sludge bomb
    {poison,
    special,
    90,
    100,
    10},
    // Earthquake
    {ground,
    physical,
    100,
    100,
    10},
    // Petal dance
    {grass,
    special,
    120,
    100,
    10},
    // Thunderbolt
    {electric,
    special,
    90,
    100,
    15},
    // Slam
    {normal,
    physical,
    80,
    75,
    20},
    // Surf
    {water,
    special,
    90,
    100,
    15},
    // Thunder
    {electric,
    special,
    110,
    70,
    10},
    // Dark pulse
    {dark,
    special,
    80,
    100,
    15},
    // Shadow ball
    {ghost,
    special,
    80,
    100,
    15},
    // Psychic
    {psychic,
    special,
    90,
    100,
    10},
    // Play rough
    {fairy,
    physical,
    90,
    90,
    10},
    // Flash cannon
    {steel,
    special,
    80,
    100,
    10},
    // Bug buzz
    {bug,
    special,
    90,
    100,
    10},
    // Fire Blast
    {fire,
    special,
    110,
    85,
    5},
    // Rock slide
    {rock,
    physical,
    75,
    90,
    10},
    // Dragon pulse
    {dragon,
    special,
    85,
    1,
    10},
    // Blizzard
    {ice,
    special,
    110,
    70,
    5}
  };

  assign move_data1 = Move[move_addr1];
  assign move_data2 = Move[move_addr2];

endmodule
