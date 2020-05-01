module calculation(input logic [11:0][7:0] player_mon,
                   input logic [11:0][7:0] enemy_mon,
                   input logic [4:0][7:0] player_move,
                   input logic [4:0][7:0] enemy_move,
                   input logic is_player,
                   output logic signed [7:0] damage
//						 output logic [7:0] EXPORT
                   );

  parameter signed [0:18][0:18][3:0] type_chart = '{
    '{4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd2,   4'sd4,   4'sd0,   4'sd2,   4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd4},
    '{4'sd8,   4'sd4,   4'sd2,   4'sd2,   4'sd4,   4'sd8,   4'sd2,   4'sd0,   4'sd8,   4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd2,   4'sd8,   4'sd4,   4'sd4,   4'sd2,   4'sd4},
    '{4'sd4,   4'sd8,   4'sd4,   4'sd4,   4'sd4,   4'sd2,   4'sd8,   4'sd4,   4'sd2,   4'sd4,   4'sd4,   4'sd8,   4'sd2,   4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd4},
    '{4'sd4,   4'sd4,   4'sd4,   4'sd2,   4'sd2,   4'sd2,   4'sd4,   4'sd2,   4'sd0,   4'sd4,   4'sd4,   4'sd8,   4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd8,   4'sd4},
    '{4'sd4,   4'sd4,   4'sd0,   4'sd8,   4'sd4,   4'sd8,   4'sd2,   4'sd4,   4'sd8,   4'sd8,   4'sd4,   4'sd2,   4'sd8,   4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd4},
    '{4'sd4,   4'sd2,   4'sd8,   4'sd4,   4'sd2,   4'sd4,   4'sd8,   4'sd4,   4'sd2,   4'sd8,   4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd8,   4'sd4,   4'sd4,   4'sd4,   4'sd4},
    '{4'sd4,   4'sd2,   4'sd2,   4'sd2,   4'sd4,   4'sd4,   4'sd4,   4'sd2,   4'sd2,   4'sd2,   4'sd4,   4'sd8,   4'sd4,   4'sd8,   4'sd4,   4'sd4,   4'sd8,   4'sd2,   4'sd4},
    '{4'sd0,   4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd8,   4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd8,   4'sd4,   4'sd4,   4'sd2,   4'sd4,   4'sd4},
    '{4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd8,   4'sd4,   4'sd4,   4'sd2,   4'sd2,   4'sd2,   4'sd4,   4'sd2,   4'sd4,   4'sd8,   4'sd4,   4'sd4,   4'sd8,   4'sd4},
    '{4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd2,   4'sd8,   4'sd4,   4'sd8,   4'sd2,   4'sd2,   4'sd8,   4'sd4,   4'sd4,   4'sd8,   4'sd2,   4'sd4,   4'sd4,   4'sd4},
    '{4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd8,   4'sd8,   4'sd4,   4'sd4,   4'sd4,   4'sd8,   4'sd2,   4'sd2,   4'sd4,   4'sd4,   4'sd4,   4'sd2,   4'sd4,   4'sd4,   4'sd4},
    '{4'sd4,   4'sd4,   4'sd2,   4'sd2,   4'sd8,   4'sd8,   4'sd2,   4'sd4,   4'sd2,   4'sd2,   4'sd8,   4'sd2,   4'sd4,   4'sd4,   4'sd4,   4'sd2,   4'sd4,   4'sd4,   4'sd4},
    '{4'sd4,   4'sd4,   4'sd8,   4'sd4,   4'sd0,   4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd8,   4'sd2,   4'sd2,   4'sd4,   4'sd4,   4'sd2,   4'sd4,   4'sd4,   4'sd4},
    '{4'sd4,   4'sd8,   4'sd4,   4'sd8,   4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd2,   4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd2,   4'sd4,   4'sd4,   4'sd0,   4'sd4,   4'sd4},
    '{4'sd4,   4'sd4,   4'sd8,   4'sd4,   4'sd8,   4'sd4,   4'sd4,   4'sd4,   4'sd2,   4'sd2,   4'sd2,   4'sd8,   4'sd4,   4'sd4,   4'sd2,   4'sd8,   4'sd4,   4'sd4,   4'sd4},
    '{4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd2,   4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd8,   4'sd4,   4'sd0,   4'sd4},
    '{4'sd4,   4'sd2,   4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd8,   4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd8,   4'sd4,   4'sd4,   4'sd2,   4'sd2,   4'sd4},
    '{4'sd4,   4'sd8,   4'sd4,   4'sd2,   4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd2,   4'sd2,   4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd8,   4'sd8,   4'sd4},
    '{4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd4,   4'sd4}
  };

  int modifier;

  always_comb
  begin
    if(is_player)
    begin
      if(player_move[4] == player_mon[11] || player_move[4] == player_mon[10])
      begin
        if(enemy_move[3])
				damage = ((((22 * player_move[2] * player_mon[8]) / (enemy_mon[7] * 50)) + 2) * type_chart[player_move[4]][enemy_mon[11]] * type_chart[player_move[4]][enemy_mon[10]] * 3) / (32);
			else
				damage = ((((22 * player_move[2] * player_mon[6]) / (enemy_mon[5] * 50)) + 2) * type_chart[player_move[4]][enemy_mon[11]] * type_chart[player_move[4]][enemy_mon[10]] * 3) / (32);
		end
		else
		begin
			if(enemy_move[3])
			  damage = ((((22 * player_move[2] * player_mon[8]) / (enemy_mon[7] * 50)) + 2) * type_chart[player_move[4]][enemy_mon[11]] * type_chart[player_move[4]][enemy_mon[10]]) / (16);
			else
			  damage = ((((22 * player_move[2] * player_mon[6]) / (enemy_mon[5] * 50)) + 2) * type_chart[player_move[4]][enemy_mon[11]] * type_chart[player_move[4]][enemy_mon[10]]) / (16);
		end
	 end
    else
    begin
      if(enemy_move[4] == enemy_mon[11] || enemy_move[4] == enemy_mon[10])
		begin
        if(enemy_move[3])
				damage = ((((22 * enemy_move[2] * enemy_mon[8]) / (player_mon[7] * 50)) + 2) * type_chart[enemy_move[4]][player_mon[11]] * type_chart[enemy_move[4]][player_mon[10]] * 3) / (32);
		  else
				damage = ((((22 * enemy_move[2] * enemy_mon[6]) / (player_mon[5] * 50)) + 2) * type_chart[enemy_move[4]][player_mon[11]] * type_chart[enemy_move[4]][player_mon[10]] * 3) / (32);
		end
		else
		begin
			if(enemy_move[3])
			  damage = ((((22 * enemy_move[2] * enemy_mon[8]) / (player_mon[7] * 50)) + 2) * type_chart[enemy_move[4]][player_mon[11]] * type_chart[enemy_move[4]][player_mon[10]]) / (16);
			else
			  damage = ((((22 * enemy_move[2] * enemy_mon[6]) / (player_mon[5] * 50)) + 2) * type_chart[enemy_move[4]][player_mon[11]] * type_chart[enemy_move[4]][player_mon[10]]) / (16);
		end
    end
//	 EXPORT = damage;
//	 EXPORT = (type_chart[player_move[4]][enemy_mon[11]] / 4) * (type_chart[player_move[4]][enemy_mon[10]] / 4);
//	 EXPORT = player_mon[0];
  end

endmodule
