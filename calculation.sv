module calculation(input logic [11:0][7:0] player_mon,
                   input logic [11:0][7:0] enemy_mon,
                   input logic [4:0][7:0] player_move,
                   input logic [4:0][7:0] enemy_move,
                   input logic is_player,
                   output logic [7:0] damage
                   );

  parameter [0:18][0:18][3:0] type_chart = {
    {4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd2,   4'd4,   4'd0,   4'd2,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4},
    {4'd8,   4'd4,   4'd2,   4'd2,   4'd4,   4'd8,   4'd2,   4'd0,   4'd8,   4'd4,   4'd4,   4'd4,   4'd4,   4'd2,   4'd8,   4'd4,   4'd4,   4'd2,   4'd4},
    {4'd4,   4'd8,   4'd4,   4'd4,   4'd4,   4'd2,   4'd8,   4'd4,   4'd2,   4'd4,   4'd4,   4'd8,   4'd2,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4},
    {4'd4,   4'd4,   4'd4,   4'd2,   4'd2,   4'd2,   4'd4,   4'd2,   4'd0,   4'd4,   4'd4,   4'd8,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd8,   4'd4},
    {4'd4,   4'd4,   4'd0,   4'd8,   4'd4,   4'd8,   4'd2,   4'd4,   4'd8,   4'd8,   4'd4,   4'd2,   4'd8,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4},
    {4'd4,   4'd2,   4'd8,   4'd4,   4'd2,   4'd4,   4'd8,   4'd4,   4'd2,   4'd8,   4'd4,   4'd4,   4'd4,   4'd4,   4'd8,   4'd4,   4'd4,   4'd4,   4'd4},
    {4'd4,   4'd2,   4'd2,   4'd2,   4'd4,   4'd4,   4'd4,   4'd2,   4'd2,   4'd2,   4'd4,   4'd8,   4'd4,   4'd8,   4'd4,   4'd4,   4'd8,   4'd2,   4'd4},
    {4'd0,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd8,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd8,   4'd4,   4'd4,   4'd2,   4'd4,   4'd4},
    {4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd8,   4'd4,   4'd4,   4'd2,   4'd2,   4'd2,   4'd4,   4'd2,   4'd4,   4'd8,   4'd4,   4'd4,   4'd8,   4'd4},
    {4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd2,   4'd8,   4'd4,   4'd8,   4'd2,   4'd2,   4'd8,   4'd4,   4'd4,   4'd8,   4'd2,   4'd4,   4'd4,   4'd4},
    {4'd4,   4'd4,   4'd4,   4'd4,   4'd8,   4'd8,   4'd4,   4'd4,   4'd4,   4'd8,   4'd2,   4'd2,   4'd4,   4'd4,   4'd4,   4'd2,   4'd4,   4'd4,   4'd4},
    {4'd4,   4'd4,   4'd2,   4'd2,   4'd8,   4'd8,   4'd2,   4'd4,   4'd2,   4'd2,   4'd8,   4'd2,   4'd4,   4'd4,   4'd4,   4'd2,   4'd4,   4'd4,   4'd4},
    {4'd4,   4'd4,   4'd8,   4'd4,   4'd0,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd8,   4'd2,   4'd2,   4'd4,   4'd4,   4'd2,   4'd4,   4'd4,   4'd4},
    {4'd4,   4'd8,   4'd4,   4'd8,   4'd4,   4'd4,   4'd4,   4'd4,   4'd2,   4'd4,   4'd4,   4'd4,   4'd4,   4'd2,   4'd4,   4'd4,   4'd0,   4'd4,   4'd4},
    {4'd4,   4'd4,   4'd8,   4'd4,   4'd8,   4'd4,   4'd4,   4'd4,   4'd2,   4'd2,   4'd2,   4'd8,   4'd4,   4'd4,   4'd2,   4'd8,   4'd4,   4'd4,   4'd4},
    {4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd2,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd8,   4'd4,   4'd0,   4'd4},
    {4'd4,   4'd2,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd8,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd8,   4'd4,   4'd4,   4'd2,   4'd2,   4'd4},
    {4'd4,   4'd8,   4'd4,   4'd2,   4'd4,   4'd4,   4'd4,   4'd4,   4'd2,   4'd2,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd8,   4'd8,   4'd4},
    {4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4,   4'd4}
  };

  logic [7:0] modifier;

  always_comb
  begin
    if(is_player)
    begin
      if(player_move[0] == player_mon[1] || player_move[0] == player_mon[1])
        modifier = (type_chart[player_move[0]][enemy_mon[0]] / 4) * (type_chart[player_move[0]][enemy_mon[1]] / 4) * (3/2);
      else
        modifier = (type_chart[player_move[0]][enemy_mon[0]] / 4) * (type_chart[player_move[0]][enemy_mon[1]] / 4);

      if(player_move[1])
        damage = ((22 * player_move[2] * player_mon[3] / enemy_mon[4]) / 50 + 2) * modifier;
      else
        damage = ((22 * player_move[2] * player_mon[5] / enemy_mon[6]) / 50 + 2) * modifier;
	 end
    else
    begin
      if(enemy_move[0] == enemy_mon[1] || enemy_move[0] == enemy_mon[1])
        modifier = (type_chart[enemy_move[0]][player_mon[0]] / 4) * (type_chart[enemy_move[0]][player_mon[1]] / 4) * (3/2);
      else
        modifier = (type_chart[enemy_move[0]][player_mon[0]] / 4) * (type_chart[enemy_move[0]][player_mon[1]] / 4);

      if(enemy_move[1])
        damage = ((22 * enemy_move[2] * enemy_mon[3] / player_mon[4]) / 50 + 2) * modifier;
      else
        damage = ((22 * enemy_move[2] * enemy_mon[5] / player_mon[6]) / 50 + 2) * modifier;
    end
  end

endmodule
