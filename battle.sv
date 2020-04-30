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

  enum logic [20:0] {Wait, Battle_Start, End_Turn, Select_Move, Player, CPU_Move, Enemy, Win, Lose} Next_state, State;

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
  logic [7:0] player_hp_in[3], opponent_hp_in[3];
  logic [7:0] my_maxhp [3];
  logic [7:0] enemy_maxhp [3];

  // logic [3:0][7:0] moves;

  logic [4:0] player_move, enemy_move;
  logic [1:0] cur_mon, opp_mon;
  logic [1:0] cur_mon_in = 2'b0;
  logic [1:0] opp_mon_in = 2'b0;
  logic [1:0] move_index;
  logic [1:0] move_index_in = 2'b0;

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

  logic [1:0][4:0] cur_user_moves;
  always_comb begin
    cur_user_moves[0]=player_data[0];
    cur_user_moves[1]=player_data[1];
    cur_user_moves[2]=player_data[2];
    cur_user_moves[3]=player_data[3];
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
               .is_movesel(is_movesel));

  //hp bar, move selector and battle text modules go here eventually...
  battle_info user_batinfo(.DrawX(DrawX), .DrawY(DrawY),
               .maxHP(my_maxhp[cur_mon]), .curHP(player_hp[cur_mon]),
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
               .is_battleinfo_bar(is_battleinfo_bar_user));
   battle_info enemy_batinfo(.DrawX(DrawX), .DrawY(DrawY),
                .maxHP(enemy_maxhp[opp_mon]), .curHP(opponent_hp[opp_mon]),
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
                .is_battleinfo_bar(is_battleinfo_bar_enemy));
  always_comb begin
    if(is_battleinfo_font_user)begin
      bit_num_batinfo = bit_num_user;
      y_diff_batinfo = y_diff_user;
      info_hex = info_hex_user;
      is_battleinfo_font = 1'b1;
    end
    else if(is_battleinfo_font_enemy)begin
      bit_num_batinfo = bit_num_enemy;
      y_diff_batinfo = y_diff_enemy;
      info_hex = info_hex_enemy;
      is_battleinfo_font = 1'b1;
    end
    else if(is_movesel)begin
      bit_num_batinfo = move_bit_num;
      y_diff_batinfo = y_diff_move;
      info_hex = move_hex;
      is_battleinfo_font = 1'b1;
    end
    else begin
      bit_num_batinfo = 3'b0;
      y_diff_batinfo = 10'd0;
      info_hex = 8'h20;
      is_battleinfo_font = 1'b0;
    end
    if(is_battleinfo_bar_user)begin
      hp_r = hp_r_user;
      hp_g = hp_g_user;
      hp_b = hp_b_user;
      is_battleinfo_bar = 1'b1;
    end
    else if(is_battleinfo_bar_enemy) begin
      hp_r = hp_r_enemy;
      hp_g = hp_g_enemy;
      hp_b = hp_b_enemy;
      is_battleinfo_bar = 1'b1;
    end
    else begin
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
                   .damage(damage),
						 .EXPORT(EXPORT_DATA)
                   );

  // AI for enemy player
  // AI CPU();

  // Generate random numbers
  // logic [7:0] num;
  //
  // random rand(.Clk(Clk), .Reset(Reset), .num());

  always_ff @ (posedge Clk)
  begin
    if(Reset)
      State <= Wait;
    else
      State <= Next_state;
      move_index <= move_index_in;
      cur_mon <= cur_mon_in;
      opp_mon <= opp_mon_in;
		player_hp <= player_hp_in;
		opponent_hp <= opponent_hp_in;
  end

  always_comb
  begin
    Next_state = State;

    end_battle = 1'b0;
    is_player = 1'b0;
	 result = 1'b0;
    // my_hp = player_hp[cur_mon];
    // enemy_hp = opponent_hp[opp_mon];
    cur_mon_in = cur_mon;
    opp_mon_in = opp_mon;
    player_addr = team[cur_mon];
    enemy_addr = enemy_team[opp_mon];
	 player_hp_in = player_hp;
	 opponent_hp_in = opponent_hp;
    move_index_in = move_index;
    player_move = player_data[move_index];
    enemy_move = 2'b0; // change when AI is added
//	 EXPORT_DATA = player_move;
	 enemy_team[2'b0] = 0; // Change when random gen is implemented
        enemy_team[2'b01] = 1;
        enemy_team[2'b10] = 2;

    unique case(State)
      Wait:
        if(is_battle)
          Next_state = Battle_Start;

      Battle_Start:
        Next_state = Select_Move;

      End_Turn:
        Next_state = Select_Move;

      Select_Move: //show moves
        if(keycode == ENTER)
          Next_state = CPU_Move;

      CPU_Move:
      begin
        if(player_data[4] > enemy_data[4])
          Next_state = Player;
        else
          Next_state = Enemy;
      end

      Player: //show player 1 move used: <poke name> used <move name>
      begin
        if(keycode == ENTER)
        begin
          Next_state = Lose;
          for(int i = 0; i < 3; i++)
            if(player_hp[i] > 7'b0)
              Next_state = Enemy;
          if(player_data[4] <= enemy_data[4])
            Next_state = End_Turn;
        end
      end

      Enemy: //show player 2 move used: Enemy <poke name> used <move name>
      begin
        if(keycode == ENTER)
        begin
          Next_state = Win;
          for(int i = 0; i < 3; i++)
            if(opponent_hp[i] > 7'b0)
              Next_state = Player;
          if(player_data[4] > enemy_data[4])
            Next_state = End_Turn;
        end
      end

      Win:
        Next_state = Wait;
      Lose:
        Next_state = Wait;
    endcase


    case(State)
      Wait: ;

      Battle_Start:
      begin
		  player_hp_in[0] = player_data[9];
        opponent_hp_in[0] = enemy_data[9];
		  enemy_maxhp[0] = player_data[9];
		  my_maxhp[0] = player_data[9];
      end

      End_Turn:
      begin
        if(player_hp[cur_mon] <= 8'b0)
        begin
          cur_mon_in += 2'b01;
        end
        if(opponent_hp[opp_mon] <= 8'b0)
        begin
          opp_mon_in += 2'b01;
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
        // for(int i = 0; i < 4; i++)
        //   moves[i] = player_data[8 + i];
      end

      CPU_Move:
      begin
        ; // AI shit here
      end

      Player:
      begin
//		EXPORT_DATA = 8'hFF;
        is_player = 1'b1;
        if(player_hp[cur_mon] > 8'b0)
          opponent_hp_in[opp_mon] = opponent_hp[opp_mon] - damage;
      end

      Enemy:
      begin
        if(opponent_hp[opp_mon] > 8'b0)
          player_hp_in[cur_mon] = player_hp[cur_mon] - damage;
      end

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
