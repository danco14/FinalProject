module stats(input logic [2:0] pokemon_addr1,
             input logic [2:0] pokemon_addr2,
             input logic [4:0] move_addr1,
             input logic [4:0] move_addr2,
             output logic signed [11:0][7:0] pokemon_data1,
             output logic signed [11:0][7:0] pokemon_data2,
             output logic signed [4:0][7:0] move_data1,
             output logic signed [4:0][7:0] move_data2
             );

  parameter bit signed [7:0] normal = 8'sd0;
  parameter bit signed [7:0] fighting = 8'sd1;
  parameter bit signed [7:0] flying = 8'sd2;
  parameter bit signed [7:0] poison = 8'sd3;
  parameter bit signed [7:0] ground = 8'sd4;
  parameter bit signed [7:0] rock = 8'sd5;
  parameter bit signed [7:0] bug = 8'sd6;
  parameter bit signed [7:0] ghost = 8'sd7;
  parameter bit signed [7:0] steel = 8'sd8;
  parameter bit signed [7:0] fire = 8'sd9;
  parameter bit signed [7:0] water = 8'sd10;
  parameter bit signed [7:0] grass = 8'sd11;
  parameter bit signed [7:0] electric = 8'sd12;
  parameter bit signed [7:0] psychic = 8'sd13;
  parameter bit signed [7:0] ice = 8'sd14;
  parameter bit signed [7:0] dragon = 8'sd15;
  parameter bit signed [7:0] dark = 8'sd16;
  parameter bit signed [7:0] fairy = 8'sd17;
  parameter bit signed [7:0] none = 8'sd18;

  parameter bit signed [7:0] physical = 8'sd1;
  parameter bit signed [7:0] special = 8'sd0;

  parameter bit signed [0:11][7:0] Pokemon [0:7] = '{
    // Blastoise
    '{water,
    none,
    8'sd154,  // HP
    8'sd103,  // Attack
    8'sd120, // Defense
    8'sd105,  // Sp. Atk
    8'sd125, // Sp. Def
    8'sd98,  // Speed
    8'sd0, 8'sd1, 8'sd2, 8'sd3}, // Move addresses
    // hydro_pump, crunch, ice_beam, aura_sphere,
    // Charizard
    '{fire,
    flying,
    8'sd153,
    8'sd104,
    8'sd98,
    8'sd129,
    8'sd105,
    8'sd120,
    8'sd4, 8'sd5, 8'sd6, 8'sd7},
    // flamethrower, thunder_punch, air_slash, dragon_claw,
    // Dragonite
    '{dragon,
    flying,
    8'sd166,
    8'sd154,
    8'sd115,
    8'sd120,
    8'sd120,
    8'sd100,
    8'sd24, 8'sd23, 8'sd25, 8'sd5},
    // dragon_pulse, rock_slide, blizzard, thunder_punch
    // Gengar
    '{ghost,
    poison,
    8'sd135,
    8'sd85,
    8'sd80,
    8'sd150,
    8'sd95,
    8'sd130,
    8'sd17, 8'sd16, 8'sd9, 8'sd12},
    // shadow_ball, dark_pulse, sludge_bomb, thunderbolt,
    // Mew
    '{psychic,
    none,
    8'sd175,
    8'sd120,
    8'sd120,
    8'sd120,
    8'sd120,
    8'sd120,
    8'sd18, 8'sd21, 8'sd20, 8'sd19},
    // psychic_move, bug_buzz, flash_cannon, play_rough,
    // Pikachu
    '{electric,
    none,
    8'sd110,
    8'sd75,
    8'sd60,
    8'sd70,
    8'sd70,
    8'sd110,
    8'sd12, 8'sd13, 8'sd14, 8'sd15},
    // thunderbolt, slam, surf, thunder,
    // Venusaur
    '{grass,
    poison,
    8'sd155,
    8'sd102,
    8'sd103,
    8'sd120,
    8'sd120,
    8'sd100,
    8'sd8, 8'sd9, 8'sd10, 8'sd11},
    // energy_ball, sludge_bomb, earthquake, petal_dance,
    // Weezing
    '{poison,
    none,
    8'sd140,
    8'sd110,
    8'sd140,
    8'sd105,
    8'sd90,
    8'sd80,
    8'sd9, 8'sd17, 8'sd22, 8'sd15}
    // sludge_bomb, shadow_ball, fire_blast, thunder
  };

  assign pokemon_data1 = Pokemon[pokemon_addr1];
  assign pokemon_data2 = Pokemon[pokemon_addr2];

  parameter bit signed [0:4][7:0] Move [0:25] = '{
    // Struggle
    // {none,
    // physical,
    // 50,
    // 110,
    // 100},
    // Hydro pump
    '{water,
    special,
    8'sd110, // Power
    8'sd80, // Accuracy
    8'sd5}, // PP
    // Ice beam
    {ice,
    special,
    8'sd90,
    8'sd100,
    8'sd10},
    // Crunch
    '{dark,
    physical,
    8'sd80,
    8'sd100,
    8'sd15},
    // Aura sphere
    '{fighting,
    special,
    8'sd80,
    8'sd110,
    8'sd20},
    // Flamethrower
    '{fire,
    special,
    8'sd90,
    8'sd100,
    8'sd15},
    // Thunder punch
    '{electric,
    physical,
    8'sd75,
    8'sd100,
    8'sd15},
    // Air slash
    '{flying,
    special,
    8'sd75,
    8'sd95,
    8'sd15},
    // Dragon claw
    '{dragon,
    physical,
    8'sd80,
    8'sd100,
    8'sd15},
    // Energy ball
    '{grass,
    physical,
    8'sd90,
    8'sd100,
    8'sd10},
    // Sludge bomb
    '{poison,
    special,
    8'sd90,
    8'sd100,
    8'sd10},
    // Earthquake
    '{ground,
    physical,
    8'sd100,
    8'sd100,
    8'sd10},
    // Petal dance
    '{grass,
    special,
    8'sd120,
    8'sd100,
    8'sd10},
    // Thunderbolt
    '{electric,
    special,
    8'sd90,
    8'sd100,
    8'sd15},
    // Slam
    '{normal,
    physical,
    8'sd80,
    8'sd75,
    8'sd20},
    // Surf
    '{water,
    special,
    8'sd90,
    8'sd100,
    8'sd15},
    // Thunder
    {electric,
    special,
    8'sd110,
    8'sd70,
    8'sd10},
    // Dark pulse
    '{dark,
    special,
    8'sd80,
    8'sd100,
    8'sd15},
    // Shadow ball
    '{ghost,
    special,
    8'sd80,
    8'sd100,
    8'sd15},
    // Psychic
    '{psychic,
    special,
    8'sd90,
    8'sd100,
    8'sd10},
    // Play rough
    '{fairy,
    physical,
    8'sd90,
    8'sd90,
    8'sd10},
    // Flash cannon
    '{steel,
    special,
    8'sd80,
    8'sd100,
    8'sd10},
    // Bug buzz
    '{bug,
    special,
    8'sd90,
    8'sd100,
    8'sd10},
    // Fire Blast
    '{fire,
    special,
    8'sd110,
    8'sd85,
    8'sd5},
    // Rock slide
    '{rock,
    physical,
    8'sd75,
    8'sd90,
    8'sd10},
    // Dragon pulse
    '{dragon,
    special,
    8'sd85,
    8'sd100,
    8'sd10},
    // Blizzard
    '{ice,
    special,
    8'sd110,
    8'sd70,
    8'sd5}
  };

  assign move_data1 = Move[move_addr1];
  assign move_data2 = Move[move_addr2];

endmodule
