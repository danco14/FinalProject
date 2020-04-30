module stats(input logic [2:0] pokemon_addr1,
             input logic [2:0] pokemon_addr2,
             input logic [4:0] move_addr1,
             input logic [4:0] move_addr2,
             output logic [11:0][7:0] pokemon_data1,
             output logic [11:0][7:0] pokemon_data2,
             output logic [4:0][7:0] move_data1,
             output logic [4:0][7:0] move_data2
             );

  parameter bit [7:0] normal = 8'd0;
  parameter bit [7:0] fighting = 8'd1;
  parameter bit [7:0] flying = 8'd2;
  parameter bit [7:0] poison = 8'd3;
  parameter bit [7:0] ground = 8'd4;
  parameter bit [7:0] rock = 8'd5;
  parameter bit [7:0] bug = 8'd6;
  parameter bit [7:0] ghost = 8'd7;
  parameter bit [7:0] steel = 8'd8;
  parameter bit [7:0] fire = 8'd9;
  parameter bit [7:0] water = 8'd10;
  parameter bit [7:0] grass = 8'd11;
  parameter bit [7:0] electric = 8'd12;
  parameter bit [7:0] psychic = 8'd13;
  parameter bit [7:0] ice = 8'd14;
  parameter bit [7:0] dragon = 8'd15;
  parameter bit [7:0] dark = 8'd16;
  parameter bit [7:0] fairy = 8'd17;
  parameter bit [7:0] none = 8'd18;

  parameter bit [7:0] physical = 8'd1;
  parameter bit [7:0] special = 8'd0;

  parameter bit [0:11][7:0] Pokemon [0:7] = '{
    // Blastoise
    '{water,
    none,
    8'd154,  // HP
    8'd103,  // Attack
    8'd120, // Defense
    8'd105,  // Sp. Atk
    8'd125, // Sp. Def
    8'd98,  // Speed
    8'd0, 8'd1, 8'd2, 8'd3}, // Move addresses
    // hydro_pump, crunch, ice_beam, aura_sphere,
    // Charizard
    '{fire,
    flying,
    8'd153,
    8'd104,
    8'd98,
    8'd129,
    8'd105,
    8'd120,
    8'd4, 8'd5, 8'd6, 8'd7},
    // flamethrower, thunder_punch, air_slash, dragon_claw,
    // Dragonite
    '{dragon,
    flying,
    8'd166,
    8'd154,
    8'd115,
    8'd120,
    8'd120,
    8'd100,
    8'd24, 8'd23, 8'd25, 8'd5},
    // dragon_pulse, rock_slide, blizzard, thunder_punch
    // Gengar
    '{ghost,
    poison,
    8'd135,
    8'd85,
    8'd80,
    8'd150,
    8'd95,
    8'd130,
    8'd17, 8'd16, 8'd9, 8'd12},
    // shadow_ball, dark_pulse, sludge_bomb, thunderbolt,
    // Mew
    '{psychic,
    none,
    8'd175,
    8'd120,
    8'd120,
    8'd120,
    8'd120,
    8'd120,
    8'd18, 8'd21, 8'd20, 8'd19},
    // psychic_move, bug_buzz, flash_cannon, play_rough,
    // Pikachu
    '{electric,
    none,
    8'd110,
    8'd75,
    8'd60,
    8'd70,
    8'd70,
    8'd110,
    8'd12, 8'd13, 8'd14, 8'd15},
    // thunderbolt, slam, surf, thunder,
    // Venusaur
    '{grass,
    poison,
    8'd155,
    8'd102,
    8'd103,
    8'd120,
    8'd120,
    8'd100,
    8'd8, 8'd9, 8'd10, 8'd11},
    // energy_ball, sludge_bomb, earthquake, petal_dance,
    // Weezing
    '{poison,
    none,
    8'd140,
    8'd110,
    8'd140,
    8'd105,
    8'd90,
    8'd80,
    8'd9, 8'd17, 8'd22, 8'd15}
    // sludge_bomb, shadow_ball, fire_blast, thunder
  };

  assign pokemon_data1 = Pokemon[pokemon_addr1];
  assign pokemon_data2 = Pokemon[pokemon_addr2];

  parameter bit [0:4][7:0] Move [0:25] = '{
    // Struggle
    // {none,
    // physical,
    // 50,
    // 110,
    // 100},
    // Hydro pump
    '{water,
    special,
    8'd110, // Power
    8'd80, // Accuracy
    8'd5}, // PP
    // Ice beam
    {ice,
    special,
    8'd90,
    8'd100,
    8'd10},
    // Crunch
    '{dark,
    physical,
    8'd80,
    8'd100,
    8'd15},
    // Aura sphere
    '{fighting,
    special,
    8'd80,
    8'd110,
    8'd20},
    // Flamethrower
    '{fire,
    special,
    8'd90,
    8'd100,
    8'd15},
    // Thunder punch
    '{electric,
    physical,
    8'd75,
    8'd100,
    8'd15},
    // Air slash
    '{flying,
    special,
    8'd75,
    8'd95,
    8'd15},
    // Dragon claw
    '{dragon,
    physical,
    8'd80,
    8'd100,
    8'd15},
    // Energy ball
    '{grass,
    physical,
    8'd90,
    8'd100,
    8'd10},
    // Sludge bomb
    '{poison,
    special,
    8'd90,
    8'd100,
    8'd10},
    // Earthquake
    '{ground,
    physical,
    8'd100,
    8'd100,
    8'd10},
    // Petal dance
    '{grass,
    special,
    8'd120,
    8'd100,
    8'd10},
    // Thunderbolt
    '{electric,
    special,
    8'd90,
    8'd100,
    8'd15},
    // Slam
    '{normal,
    physical,
    8'd80,
    8'd75,
    8'd20},
    // Surf
    '{water,
    special,
    8'd90,
    8'd100,
    8'd15},
    // Thunder
    {electric,
    special,
    8'd110,
    8'd70,
    8'd10},
    // Dark pulse
    '{dark,
    special,
    8'd80,
    8'd100,
    8'd15},
    // Shadow ball
    '{ghost,
    special,
    8'd80,
    8'd100,
    8'd15},
    // Psychic
    '{psychic,
    special,
    8'd90,
    8'd100,
    8'd10},
    // Play rough
    '{fairy,
    physical,
    8'd90,
    8'd90,
    8'd10},
    // Flash cannon
    '{steel,
    special,
    8'd80,
    8'd100,
    8'd10},
    // Bug buzz
    '{bug,
    special,
    8'd90,
    8'd100,
    8'd10},
    // Fire Blast
    '{fire,
    special,
    8'd110,
    8'd85,
    8'd5},
    // Rock slide
    '{rock,
    physical,
    8'd75,
    8'd90,
    8'd10},
    // Dragon pulse
    '{dragon,
    special,
    8'd85,
    8'd1,
    8'd10},
    // Blizzard
    '{ice,
    special,
    8'd110,
    8'd70,
    8'd5}
  };

  assign move_data1 = Move[move_addr1];
  assign move_data2 = Move[move_addr2];

endmodule
