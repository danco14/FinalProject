module battle(input logic Clk,
              input logic Reset,
              input logic is_battle,
              input logic [9:0] DrawX, input logic [9:0] DrawY,
              input logic [7:0] keycode,
              input logic [2:0][2:0] team,
              output logic result,
              output logic end_battle,
              output logic [1:0] my_cur,
              output logic [2:0] enemy_cur_id,
				      output logic [7:0] EXPORT_DATA,
              output logic [2:0] bit_num_batinfo,
              output logic [7:0] info_hex,
              output logic [9:0] y_diff_batinfo,
              output logic is_battleinfo_font,
              output logic [7:0] hp_r,
              output logic [7:0] hp_g,
              output logic [7:0] hp_b,
              output logic is_battleinfo_bar
              );

  enum logic [20:0] {Wait, Battle_Start, Choose, End_Turn, Select_Move, Player, Player_text, CPU_Move, Enemy, Enemy_text, Win, Lose} Next_state, State;

  // Keycodes
  parameter [7:0] W = 8'h1A;
  parameter [7:0] A = 8'h04;
  parameter [7:0] S = 8'h16;
  parameter [7:0] D = 8'h07;
  parameter [7:0] ENTER = 8'h28;

  logic [2:0][2:0] enemy_team;

  // Registers to hold pokemon health status
  logic [7:0] player_hp[3];
  logic [7:0] opponent_hp[3];
  logic [7:0] player_hp_in[3], opponent_hp_in[3], my_maxhp_in[3], enemy_maxhp_in[3];
  logic [7:0] my_maxhp [3];
  logic [7:0] enemy_maxhp [3];

  logic [4:0] player_move, enemy_move;
  logic [1:0] cur_mon, opp_mon;
  logic [1:0] cur_mon_in = 2'b0;
  logic [1:0] opp_mon_in = 2'b0;
  logic [1:0] move_index, enemy_move_index;
  logic [1:0] move_index_in = 2'b0

  assign my_cur = cur_mon;
  assign enemy_cur_id = enemy_team[opp_mon];

  logic [2:0] player_addr;
  logic [2:0] enemy_addr;
  logic [11:0][7:0] player_data;
  logic [11:0][7:0] enemy_data;
  logic [4:0][7:0] player_move_data;
  logic [4:0][7:0] enemy_move_data;

  // Stats reference sheet
  stats data(.pokemon_addr1(player_addr),
             .pokemon_addr2(enemy_addr),
             .pokemon_data1(player_data),
             .pokemon_data2(enemy_data),
             .move_addr1(player_move),
             .move_addr2(enemy_move),
             .move_data1(player_move_data),
             .move_data2(enemy_move_data)
             );

  logic [2:0] bit_num_user;
  logic [7:0] info_hex_user;
  logic [9:0] y_diff_user;
  logic is_battleinfo_font_user;
  logic [7:0] hp_r_user;
  logic [7:0] hp_g_user;
  logic [7:0] hp_b_user;
  logic is_battleinfo_bar_user;

  logic [2:0] bit_num_enemy;
  logic [7:0] info_hex_enemy;
  logic [9:0] y_diff_enemy;
  logic is_battleinfo_font_enemy;
  logic [7:0] hp_r_enemy;
  logic [7:0] hp_g_enemy;
  logic [7:0] hp_b_enemy;
  logic is_battleinfo_bar_enemy;

  logic [3:0][4:0] cur_user_moves;

  always_comb begin
    cur_user_moves[0] = player_data[0];
    cur_user_moves[1] = player_data[1];
    cur_user_moves[2] = player_data[2];
    cur_user_moves[3] = player_data[3];
  end

  logic [2:0] move_bit_num;
  logic [7:0] move_hex;
  logic [9:0] y_diff_move;
  logic is_movesel;

  move_select move_menu(.DrawX(DrawX), .DrawY(DrawY),
                        .start_x(200), .start_y(370),
                        .user_moves(cur_user_moves),
                        .hovered_move(move_index),
                        .bit_num(move_bit_num),
                        .move_hex(move_hex),
                        .y_diff(y_diff_move),
                        .is_movesel(is_movesel)
                        );

  //hp bar, move selector and battle text modules go here eventually...
  battle_info user_batinfo(.DrawX(DrawX), .DrawY(DrawY),
                           .maxHP(my_maxhp[cur_mon]),
                           .curHP(player_hp[cur_mon]),
                           .start_x(380), .start_y(300),
                           .poke_id(player_addr),
                           .is_user_info(1'b1),
                           .bit_num(bit_num_user),
                           .info_hex(info_hex_user),
                           .y_diff(y_diff_user),
                           .is_battleinfo_font(is_battleinfo_font_user),
                           .hp_r(hp_r_user),
                           .hp_g(hp_g_user),
                           .hp_b(hp_b_user),
                           .is_battleinfo_bar(is_battleinfo_bar_user)
                           );

   battle_info enemy_batinfo(.DrawX(DrawX), .DrawY(DrawY),
                             .maxHP(enemy_maxhp[opp_mon]),
                             .curHP(opponent_hp[opp_mon]),
                             .start_x(280), .start_y(150),
                             .poke_id(enemy_addr),
                             .is_user_info(1'b0),
                             .bit_num(bit_num_enemy),
                             .info_hex(info_hex_enemy),
                             .y_diff(y_diff_enemy),
                             .is_battleinfo_font(is_battleinfo_font_enemy),
                             .hp_r(hp_r_enemy),
                             .hp_g(hp_g_enemy),
                             .hp_b(hp_b_enemy),
                             .is_battleinfo_bar(is_battleinfo_bar_enemy)
                             );

  logic [2:0] uatk_bnum;
  logic [7:0] useratk_hex;
  logic [9:0] uatk_ydiff;
  logic is_useratk;

  user_attack uatk(.DrawX(DrawX), .DrawY(DrawY),
                   .start_x(180), .start_y(370),
                   .move_id(player_move),
                   .poke_id(player_addr),
                   .bit_num(uatk_bnum),
                   .useratk_hex(useratk_hex),
                   .y_diff(uatk_ydiff),
                   .is_useratk(is_useratk));

 logic [2:0] en_bnum;
 logic [7:0] enemyatk_hex;
 logic [9:0] en_ydiff;
 logic is_enemyatk;

 enemy_attack enatk(.DrawX(DrawX), .DrawY(DrawY),
                    .start_x(180), .start_y(370),
                    .move_id(enemy_move),
                    .poke_id(enemy_addr),
                    .bit_num(en_bnum),
                    .enemyatk_hex(enemyatk_hex),
                    .y_diff(en_ydiff),
                    .is_enemyatk(is_enemyatk));

  always_comb begin
    if(is_battleinfo_font_user)
    begin
      bit_num_batinfo = bit_num_user;
      y_diff_batinfo = y_diff_user;
      info_hex = info_hex_user;
      is_battleinfo_font = 1'b1;
    end
    else if(is_battleinfo_font_enemy)
    begin
      bit_num_batinfo = bit_num_enemy;
      y_diff_batinfo = y_diff_enemy;
      info_hex = info_hex_enemy;
      is_battleinfo_font = 1'b1;
    end
    else if(is_movesel && State==Select_Move)
    begin
      bit_num_batinfo = move_bit_num;
      y_diff_batinfo = y_diff_move;
      info_hex = move_hex;
      is_battleinfo_font = 1'b1;
    end
    else if(is_useratk && State==Player_text)
    begin
      bit_num_batinfo = uatk_bnum;
      y_diff_batinfo = uatk_ydiff;
      info_hex = useratk_hex;
      is_battleinfo_font = 1'b1;
    end
    else if(is_enemyatk && State==Enemy_text)
    begin
      bit_num_batinfo = en_bnum;
      y_diff_batinfo = en_ydiff;
      info_hex = enemyatk_hex;
      is_battleinfo_font = 1'b1;
    end
    else
    begin
      bit_num_batinfo = 3'b0;
      y_diff_batinfo = 10'd0;
      info_hex = 8'h20;
      is_battleinfo_font = 1'b0;
    end
    if(is_battleinfo_bar_user)
    begin
      hp_r = hp_r_user;
      hp_g = hp_g_user;
      hp_b = hp_b_user;
      is_battleinfo_bar = 1'b1;
    end
    else if(is_battleinfo_bar_enemy)
    begin
      hp_r = hp_r_enemy;
      hp_g = hp_g_enemy;
      hp_b = hp_b_enemy;
      is_battleinfo_bar = 1'b1;
    end
    else
    begin
      hp_r = 8'hff;
      hp_g = 8'hff;
      hp_b = 8'hff;
      is_battleinfo_bar = 1'b0;
    end
  end

  logic [7:0] damage;
  logic is_player;

  // Damage calculation
  calculation calc(.player_mon(player_data),
                   .enemy_mon(enemy_data),
                   .player_move(player_move_data),
                   .enemy_move(enemy_move_data),
                   .is_player(is_player),
                   .damage(damage)
                   // .EXPORT(EXPORT_DATA)
                   );

  logic CPU_turn, CPU_done;

  // AI for enemy player
  AI CPU(.Clk(Clk),
         .Reset(Reset),
         .CPU_turn(CPU_turn),
         .player(player_data),
         .player_hp(player_hp[cur_mon]),
         .player_max_hp(my_maxhp[cur_mon])
         .CPU(enemy_data),
         .CPU_hp(enemy_hp[opp_mon]),
         .CPU_max_hp(enemy_maxhp[opp_mon]),
         .move_data(enemy_move_data),
         .damage(damage),
         .move(enemy_move_index),
         .CPU_done(CPU_done)
         );

  assign enemy_move = enemy_data[enemy_move_index];

  // Generate random numbers
  logic [7:0] num;

  random r(.Clk(Clk), .Reset(Reset), .num(num));

  always_ff @ (posedge Clk)
  begin
    if(Reset)
    begin
      State <= Wait;
      move_index <= 2'b0;
      cur_mon <= 2'b0;
      opp_mon <= 2'b0;
    end
    else
    begin
      State <= Next_state;
      move_index <= move_index_in;
      cur_mon <= cur_mon_in;
      opp_mon <= opp_mon_in;
  		player_hp <= player_hp_in;
  		opponent_hp <= opponent_hp_in;
  		my_maxhp <= my_maxhp_in;
  		enemy_maxhp <= enemy_maxhp_in;
    end
  end

  always_comb
  begin
    Next_state = State;

    end_battle = 1'b0;
    is_player = 1'b0;
	  result = 1'b0;
    CPU_turn = 1'b0;
    cur_mon_in = cur_mon;
    opp_mon_in = opp_mon;
    player_addr = team[cur_mon];
    enemy_addr = enemy_team[opp_mon];
	  player_hp_in = player_hp;
	  opponent_hp_in = opponent_hp;
	  my_maxhp_in = my_maxhp;
	  enemy_maxhp_in = enemy_maxhp;
    move_index_in = move_index;
    player_move = player_data[move_index];
	  EXPORT_DATA = player_move_data[1];

    unique case(State)
      Wait:
        if(is_battle)
          Next_state = Battle_Start;

      Battle_Start:
        Next_state = Choose;

  		Choose:
  		  Next_state = Select_Move;

      End_Turn:
        Next_state = Select_Move;

      Select_Move: //show moves
        if(keycode == ENTER)
          Next_state = CPU_Move;

      CPU_Move:
      begin
        if(CPU_done)
          if(player_data[4] > enemy_data[4])
            Next_state = Player;
          else
            Next_state = Enemy;
      end

      Player: //show player 1 move used: <poke name> used <move name>
			  Next_state = Player_text;

  		Player_text:
  		begin
        if(keycode == ENTER)
        begin
  		    if(opponent_hp[opp_mon] == 8'b0 && opp_mon == 2)
  				  Next_state = Win;
  			  else if(opponent_hp[opp_mon] == 8'b0 || player_data[4] <= enemy_data[4])
  				  Next_state = End_Turn;
          else
            Next_state = Enemy;
        end
      end

      Enemy: //show player 2 move used: Enemy <poke name> used <move name>
			  Next_state = Enemy_text;

		  Enemy_text:
		  begin
        if(keycode == ENTER)
        begin
  			  if(player_hp[cur_mon] == 8'b0 && cur_mon == 2)
  				  Next_state = Lose;
  			  else if(player_hp[cur_mon] == 8'b0 || player_data[4] > enemy_data[4])
  				  Next_state = End_Turn;
          else
  				  Next_state = Player;
        end
      end

      Win:
        Next_state = Wait;
      Lose:
        Next_state = Wait;
    endcase


    case(State)
      Wait:
		    enemy_team[0] = num % 8;

      Battle_Start:
      begin
  		  enemy_team[1] = num % 8;
  		  cur_mon_in = 2'b0;
  		  opp_mon_in = 2'b0;
  		  player_hp_in[0] = player_data[9];
        opponent_hp_in[0] = enemy_data[9];
  		  enemy_maxhp_in[0] = enemy_data[9];
  		  my_maxhp_in[0] = player_data[9];
      end

  		Choose:
  			enemy_team[2] = num % 8;

      End_Turn:
      begin
        if(player_hp[cur_mon] == 8'b0)
        begin
          cur_mon_in = cur_mon + 2'b01;
          player_addr = team[cur_mon_in];
          player_hp_in[cur_mon_in] = player_data[9];
          my_maxhp_in[cur_mon_in] = player_data[9];
        end
        if(opponent_hp[opp_mon] == 8'b0)
        begin
          opp_mon_in = opp_mon + 2'b01;
          enemy_addr = enemy_team[opp_mon_in];
          opponent_hp_in[opp_mon_in] = enemy_data[9];
          enemy_maxhp_in[opp_mon_in] = enemy_data[9];
        end
      end

      Select_Move:
		  begin
        case(keycode)
          W:
          begin
            if(move_index != 2'b00 && move_index != 2'b01)
              move_index_in = move_index - 2'b10;
          end
          A:
          begin
            if(move_index != 2'b00 && move_index != 2'b10)
              move_index_in = move_index - 2'b01;
          end
          S:
          begin
            if(move_index != 2'b10 && move_index != 2'b11)
              move_index_in = move_index + 2'b10;
          end
          D:
          begin
            if(move_index != 2'b01 && move_index != 2'b11)
              move_index_in = move_index + 2'b01;
          end
        endcase
      end

      CPU_Move:
        CPU_turn = 1'b1;

      Player:
      begin
        is_player = 1'b1;
        if((num % 100) + 1 <= player_move_data[1])
        begin
          if(opponent_hp[opp_mon] - damage > opponent_hp[opp_mon])
            opponent_hp_in[opp_mon] = 8'b0;
          else
            opponent_hp_in[opp_mon] = opponent_hp[opp_mon] - damage;
        end
      end

		  Player_text: ;

      Enemy:
      begin
			if((num % 100) + 1 <= enemy_move_data[1])
			begin
			  if(player_hp[cur_mon] - damage > player_hp[cur_mon])
				  player_hp_in[cur_mon] = 8'b0;
			  else
				  player_hp_in[cur_mon] = player_hp[cur_mon] - damage;
			end
      end

		  Enemy_text: ;

      Win:
      begin
        end_battle = 1'b1;
        result = 1'b1;
      end
      Lose:
      begin
        end_battle = 1'b1;
        result = 1'b0;
      end
    endcase
  end

endmodule
