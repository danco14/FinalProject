module game_state(input logic Clk, input logic Reset,
                  input logic [9:0] DrawX, input logic [9:0] DrawY,
                  input logic [7:0] keycode,
                  input logic result,
                  input logic end_battle,
                  input logic [1:0] my_cur,
                  input logic [2:0] enemy_cur_id,
                  output logic [4:0] palette_idx,
                  output logic is_sprite,
                  output logic is_chooser,
                  output logic is_battle,
                  output logic is_start,
                  output logic [2:0] cur_choice,
                  output logic [2:0][2:0] my_team,
                  // output logic [1:0] direction,
                  output logic [7:0] EXPORT_DATA
						      );

  enum logic [20:0] {Start, Roam, Battle, End} State, Next_state;


  parameter [9:0] poke0_x = 10'd160;
  parameter [9:0] poke0_y = 10'd120;

  parameter [9:0] poke1_x = 10'd236;
  parameter [9:0] poke1_y = 10'd120;

  parameter [9:0] poke2_x = 10'd312;
  parameter [9:0] poke2_y = 10'd120;

  parameter [9:0] poke3_x = 10'd388;
  parameter [9:0] poke3_y = 10'd120;

  parameter [9:0] poke4_x = 10'd160;
  parameter [9:0] poke4_y = 10'd196;

  parameter [9:0] poke5_x = 10'd236;
  parameter [9:0] poke5_y = 10'd196;

  parameter [9:0] poke6_x = 10'd312;
  parameter [9:0] poke6_y = 10'd196;

  parameter [9:0] poke7_x = 10'd388;
  parameter [9:0] poke7_y = 10'd196;

  parameter [5:0] width = 6'd56;
  parameter [5:0] height = 6'd56;
  parameter [7:0] total_width = 8'd224;

  parameter [9:0] box_x = 10'd159;
  parameter [9:0] box_y = 10'd119;
  parameter [6:0] box_width = 7'd58;
  parameter [6:0] box_height = 7'd58;

  parameter [7:0] W = 8'h1A;
  parameter [7:0] A = 8'h04;
  parameter [7:0] S = 8'h16;
  parameter [7:0] D = 8'h07;
  parameter [7:0] ENTER = 8'h28;

  logic done_select;
  logic done_select_in = 1'b0;
  logic [2:0][2:0] my_team_in;
  logic [1:0] num_chosen;
  logic [1:0] num_chosen_in = 2'b0;
  logic [2:0] cur_choice_in = 3'b0;

  logic [18:0] poke_sprite_addr;
  logic [18:0] psprite_startscreen;
  logic [18:0] psprite_myteam;
  logic [18:0] psprite_enemy;

  pokemonRAM pokeSprites(.Clk(Clk),.palette_idx(palette_idx),.read_address(poke_sprite_addr));

//  my_sprites me_pokemon(.DrawX(DrawX), .DrawY(DrawY),
//                 .poke_id(my_team[my_cur]),
//                 .sprite_addr(psprite_myteam),
//                 .is_myteam(is_myteam));
//  enemy_sprites ene_pokemon(.DrawX(DrawX), .DrawY(DrawY),
//              .poke_id(enemy_cur_id),
//              .sprite_addr(psprite_enemy),
//              .is_enemyteam(is_enemyteam));

  always_ff @ (posedge Clk)
  begin
    if(Reset)
    begin
      State <= Start;
      num_chosen <= 2'b0;
      done_select <= 1'b0;
      cur_choice <= 3'b0;
    end
    else
    begin
      State <= Next_state;
      cur_choice <= cur_choice_in;
      num_chosen <= num_chosen_in;
      my_team <= my_team_in;
      done_select <= done_select_in;
    end
  end

  always_comb
  begin
    EXPORT_DATA = keycode;
    Next_state = State;

    is_sprite = 1'b0;
    poke_sprite_addr = psprite_startscreen;
	 psprite_startscreen = 19'b0;
    is_chooser = 1'b0;
    is_battle = 1'b0;
    is_start = 1'b0;
    cur_choice_in = cur_choice;
    num_chosen_in = num_chosen;
    my_team_in = my_team;
    done_select_in = done_select;

    unique case(State)
      Start:
        if(keycode && done_select) // Press any key to continue after selecting team
          Next_state = Roam;
      Roam:
        //if()
        Next_state = Battle;
      Battle:
      begin
        if(end_battle)
        begin
          if(result == 1'b1)
            Next_state = Roam;
          else
            Next_state = End;
        end
      end
      End:
        if(keycode == W)
          Next_state = Start;
    endcase

    case(State)
      Start:
      begin
			  is_start = 1'b1;
        if(num_chosen == 2'b11)
          done_select_in = 1'b1;
        if(keycode == ENTER)begin
          my_team_in[num_chosen] = cur_choice;
          num_chosen_in = num_chosen + 1'b1;
        end
        if(keycode == W)
        begin
          if(cur_choice <= 3'b011)
            cur_choice_in = cur_choice + 3'b100;
          else
            cur_choice_in = cur_choice - 3'b100;
        end
        else if(keycode == A)
        begin
          if(cur_choice == 3'b000 || cur_choice == 3'b100)
            cur_choice_in = cur_choice + 3'b011;
          else
            cur_choice_in = cur_choice - 3'b001;
        end
        else if(keycode == S)
        begin
          if(cur_choice >= 3'b100)
            cur_choice_in = cur_choice - 3'b100;
          else
            cur_choice_in = cur_choice + 3'b100;
        end
        else if(keycode == D)
        begin
          if(cur_choice == 3'b111 || cur_choice == 3'b011)
            cur_choice_in = cur_choice - 3'b011;
          else
            cur_choice_in = cur_choice + 3'b001;
        end

        if (cur_choice<=3'b011)begin
          if( ( (DrawX >= (box_x + int'(cur_choice)*7'd76)) && (DrawX < (box_width + box_x + int'(cur_choice)*7'd76)) && (DrawY == box_y || (DrawY == (box_y + box_height))))||
             ( (DrawY>=box_y) && (DrawY<(box_y+box_height)) && ((DrawX == (box_x + int'(cur_choice)*7'd76)) || (DrawX == (box_width + box_x + int'(cur_choice)*7'd76))))
           ) begin
             is_chooser = 1'b1;
          end
        end
        else begin
          if( ( (DrawX >= (box_x + (int'(cur_choice)-3'd4)*7'd76)) && (DrawX < (box_width + box_x + (int'(cur_choice)-3'd4)*7'd76)) && (DrawY == (box_y+7'd76) || (DrawY == (7'd76 + box_y + box_height))))||
             ( (DrawY>=(box_y+7'd76)) && (DrawY<(box_y+box_height+7'd76)) && ((DrawX == (box_x + (int'(cur_choice)-3'd4)*7'd76)) || (DrawX == (box_width + box_x + (int'(cur_choice)-3'd4)*7'd76))))
           ) begin
           is_chooser = 1'b1;
         end
        end
        if(DrawX >= poke0_x && DrawX < (poke0_x + width) && DrawY >= poke0_y && DrawY < (poke0_y + height))begin
          psprite_startscreen =(width) + (DrawX - poke0_x) + (total_width* (DrawY - poke0_y));
          is_sprite = 1'b1;
        end
        else if(DrawX >= poke1_x && DrawX < (poke1_x + width) && DrawY >= poke1_y && DrawY < (poke1_y + height))begin
          psprite_startscreen = (3*width) + (DrawX - poke1_x) + (total_width* (DrawY - poke1_y));
          is_sprite = 1'b1;
        end
        else if(DrawX >= poke2_x && DrawX < (poke2_x + width) && DrawY >= poke2_y && DrawY < (poke2_y + height))begin
          psprite_startscreen = (width) + (DrawX - poke2_x) + (total_width*height) + (total_width* (DrawY - poke2_y));
          is_sprite = 1'b1;
        end
        else if(DrawX >= poke3_x && DrawX < (poke3_x + width) && DrawY >= poke3_y && DrawY < (poke3_y + height))begin
          psprite_startscreen = (3*width) + (DrawX - poke3_x) + (total_width*height) + (total_width* (DrawY - poke3_y));
          is_sprite = 1'b1;
        end
        else if(DrawX >= poke4_x && DrawX < (poke4_x + width) && DrawY >= poke4_y && DrawY < (poke4_y + height))begin
          psprite_startscreen = (width) + (DrawX - poke4_x) + (total_width*height*2) + (total_width* (DrawY - poke4_y));
          is_sprite = 1'b1;
        end
        else if(DrawX >= poke5_x && DrawX < (poke5_x + width) && DrawY >= poke5_y && DrawY < (poke5_y + height))begin
          psprite_startscreen = (3*width) + (DrawX - poke5_x) + (total_width*height*2) + (total_width* (DrawY - poke5_y));
          is_sprite = 1'b1;
        end
        else if(DrawX >= poke6_x && DrawX < (poke6_x + width) && DrawY >= poke6_y && DrawY < (poke6_y + height))begin
          psprite_startscreen = (width) + (DrawX - poke6_x) + (total_width*height*3) + (total_width* (DrawY - poke6_y));
          is_sprite = 1'b1;
        end
        else if(DrawX >= poke7_x && DrawX < (poke7_x + width) && DrawY >= poke7_y && DrawY < (poke7_y + height))begin
          psprite_startscreen = (3*width) + (DrawX - poke7_x) + (total_width*height*3) + (total_width* (DrawY - poke7_y));
          is_sprite = 1'b1;
        end
      end

      Roam: ;
        // if(keycode == W)
        //   direction = 2'b00;
        // else if(keycode == A)
        //   direction == 2'b01;
        // else if(keycode == S)
        //   direction == 2'b10;
        // else if(keycode == D)
        //   direction == 2'b11;
      Battle:
		begin
        is_battle = 1'b1;
//        if(is_enemyteam)begin
//          poke_sprite_addr = psprite_enemy;
//          is_sprite = 1'b1;
//        end
//        else if(is_myteam)begin
//          poke_sprite_addr = psprite_myteam;
//          is_sprite = 1'b1;
//        end
		end
      End:
      begin
        num_chosen_in = 2'b0;
        done_select_in = 1'b0;
      end
    endcase
  end

endmodule
