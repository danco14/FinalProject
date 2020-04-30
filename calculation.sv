module calculation(input logic [11:0][7:0] player_mon,
                   input logic [11:0][7:0] enemy_mon,
                   input logic [4:0][7:0] player_move,
                   input logic [4:0][7:0] enemy_move,
                   input logic is_player,
                   output logic [7:0] damage,
						 output logic [7:0] EXPORT
                   );

  parameter [0:18][0:18][3:0] type_chart = '{
    '{4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd2,   4'd4,   4'd0,   4'd2,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4},
    '{4'd8,   4'd4,   4'd2,   4'd2,   4'd4,   4'd8,   4'd2,   4'd0,   4'd8,   4'd4,   4'd4,   4'd4,   4'd4,   4'd2,   4'd8,   4'd4,   4'd4,   4'd2,   4'd4},
    '{4'd4,   4'd8,   4'd4,   4'd4,   4'd4,   4'd2,   4'd8,   4'd4,   4'd2,   4'd4,   4'd4,   4'd8,   4'd2,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4},
    '{4'd4,   4'd4,   4'd4,   4'd2,   4'd2,   4'd2,   4'd4,   4'd2,   4'd0,   4'd4,   4'd4,   4'd8,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd8,   4'd4},
    '{4'd4,   4'd4,   4'd0,   4'd8,   4'd4,   4'd8,   4'd2,   4'd4,   4'd8,   4'd8,   4'd4,   4'd2,   4'd8,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4},
    '{4'd4,   4'd2,   4'd8,   4'd4,   4'd2,   4'd4,   4'd8,   4'd4,   4'd2,   4'd8,   4'd4,   4'd4,   4'd4,   4'd4,   4'd8,   4'd4,   4'd4,   4'd4,   4'd4},
    '{4'd4,   4'd2,   4'd2,   4'd2,   4'd4,   4'd4,   4'd4,   4'd2,   4'd2,   4'd2,   4'd4,   4'd8,   4'd4,   4'd8,   4'd4,   4'd4,   4'd8,   4'd2,   4'd4},
    '{4'd0,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd8,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd8,   4'd4,   4'd4,   4'd2,   4'd4,   4'd4},
    '{4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd8,   4'd4,   4'd4,   4'd2,   4'd2,   4'd2,   4'd4,   4'd2,   4'd4,   4'd8,   4'd4,   4'd4,   4'd8,   4'd4},
    '{4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd2,   4'd8,   4'd4,   4'd8,   4'd2,   4'd2,   4'd8,   4'd4,   4'd4,   4'd8,   4'd2,   4'd4,   4'd4,   4'd4},
    '{4'd4,   4'd4,   4'd4,   4'd4,   4'd8,   4'd8,   4'd4,   4'd4,   4'd4,   4'd8,   4'd2,   4'd2,   4'd4,   4'd4,   4'd4,   4'd2,   4'd4,   4'd4,   4'd4},
    '{4'd4,   4'd4,   4'd2,   4'd2,   4'd8,   4'd8,   4'd2,   4'd4,   4'd2,   4'd2,   4'd8,   4'd2,   4'd4,   4'd4,   4'd4,   4'd2,   4'd4,   4'd4,   4'd4},
    '{4'd4,   4'd4,   4'd8,   4'd4,   4'd0,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd8,   4'd2,   4'd2,   4'd4,   4'd4,   4'd2,   4'd4,   4'd4,   4'd4},
    '{4'd4,   4'd8,   4'd4,   4'd8,   4'd4,   4'd4,   4'd4,   4'd4,   4'd2,   4'd4,   4'd4,   4'd4,   4'd4,   4'd2,   4'd4,   4'd4,   4'd0,   4'd4,   4'd4},
    '{4'd4,   4'd4,   4'd8,   4'd4,   4'd8,   4'd4,   4'd4,   4'd4,   4'd2,   4'd2,   4'd2,   4'd8,   4'd4,   4'd4,   4'd2,   4'd8,   4'd4,   4'd4,   4'd4},
    '{4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd2,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd8,   4'd4,   4'd0,   4'd4},
    '{4'd4,   4'd2,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd8,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd8,   4'd4,   4'd4,   4'd2,   4'd2,   4'd4},
    '{4'd4,   4'd8,   4'd4,   4'd2,   4'd4,   4'd4,   4'd4,   4'd4,   4'd2,   4'd2,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd8,   4'd8,   4'd4},
    '{4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4}
  };

  logic [7:0] modifier;

  always_comb
  begin
    if(is_player)
    begin
      if(player_move[4] == player_mon[11] || player_move[4] == player_mon[10])
        modifier = (type_chart[player_move[4]][18-enemy_mon[11]] / 4) * (type_chart[player_move[4]][18-enemy_mon[10]] / 4) * (3/2);
      else
        modifier = (type_chart[player_move[4]][18-enemy_mon[11]] / 4) * (type_chart[player_move[4]][18-enemy_mon[10]] / 4);

      if(player_move[3])
        damage = ((22 * player_move[2] * (player_mon[8] / enemy_mon[7])) / 50 + 2) * modifier;
      else
        damage = ((22 * player_move[2] * (player_mon[6] / enemy_mon[5])) / 50 + 2) * modifier;
	 end
    else
    begin
      if(enemy_move[4] == enemy_mon[11] || enemy_move[4] == enemy_mon[10])
        modifier = (type_chart[enemy_move[4]][18-player_mon[0]] / 4) * (type_chart[enemy_move[4]][18-player_mon[1]] / 4) * (3/2);
      else
        modifier = (type_chart[enemy_move[4]][18-player_mon[0]] / 4) * (type_chart[enemy_move[4]][18-player_mon[1]] / 4);

      if(enemy_move[3])
        damage = ((22 * enemy_move[2] * (enemy_mon[8] / player_mon[7])) / 50 + 2) * modifier;
      else
        damage = ((22 * enemy_move[2] * (enemy_mon[6] / player_mon[5])) / 50 + 2) * modifier;
    end
	 EXPORT = modifier;
  end

endmodule
