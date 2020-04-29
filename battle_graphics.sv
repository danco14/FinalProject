//back facing team sprites
module my_sprites (input logic [9:0] DrawX, input logic [9:0] DrawY,
                   input logic [2:0] poke_id,
                   output logic [18:0] sprite_addr,
                   output logic is_myteam);

   parameter [9:0] team_x = 10'd250;
   parameter [9:0] team_y = 10'd290;
   parameter [5:0] width = 6'd56;
   parameter [5:0] height = 6'd56;
   parameter [7:0] total_width = 8'd224;

   always_comb begin
   if(DrawX >= team_x && DrawX < (team_x + width) && DrawY >= team_y && DrawY < (team_y + height) )begin
     is_myteam = 1'b1;
     case(poke_id)
       3'd0: begin
         sprite_addr = (DrawX - team_x) + (total_width* (DrawY - team_y));
       end
       3'd1:begin
         sprite_addr = (2*width) + (DrawX - team_x) + (total_width* (DrawY - team_y));
       end
       3'd2:begin
         sprite_addr = (DrawX - team_x) + (total_width*height) + (total_width* (DrawY - team_y));
       end
       3'd3:begin
         sprite_addr = (2*width) + (DrawX - team_x) + (total_width*height) + (total_width* (DrawY - team_y));
       end
       3'd4:begin
         sprite_addr = (DrawX - team_x) + (total_width*height*2) + (total_width* (DrawY - team_y));
       end
       3'd5:begin
         sprite_addr = (2*width) + (DrawX - team_x) + (total_width*height*2) + (total_width* (DrawY - team_y));
       end
       3'd6:begin
         sprite_addr = (DrawX - team_x) + (total_width*height*3) + (total_width* (DrawY - team_y));
       end
       default: begin //id=7
         sprite_addr = (2*width) + (DrawX - team_x) + (total_width*height*3) + (total_width* (DrawY - team_y));
       end

     endcase
	end
   else begin
     is_myteam = 1'b0;
   end
 end
endmodule


//front facing enemy sprites
module enemy_sprites (input logic [9:0] DrawX, input logic [9:0] DrawY,
						          input logic [2:0] poke_id,
                      output logic [18:0] sprite_addr,
                      output logic is_enemyteam);

   parameter [9:0] enemy_x = 10'd410;
   parameter [9:0] enemy_y = 10'd160;
   parameter [5:0] width = 6'd56;
   parameter [5:0] height = 6'd56;
   parameter [7:0] total_width = 8'd224;

   always_comb begin
   if(DrawX >= enemy_x && DrawX < (enemy_x + width) && DrawY >= enemy_y && DrawY < (enemy_y + height) )begin
     is_enemyteam = 1'b1;
     case(poke_id)
       3'd0: begin
         sprite_addr = (width) + (DrawX - enemy_x) + (total_width* (DrawY - enemy_y));
       end
       3'd1:begin
         sprite_addr = (3*width) + (DrawX - enemy_x) + (total_width* (DrawY - enemy_y));
       end
       3'd2:begin
         sprite_addr = (width) + (DrawX - enemy_x) + (total_width*height) + (total_width* (DrawY - enemy_y));
       end
       3'd3:begin
         sprite_addr = (3*width) + (DrawX - enemy_x) + (total_width*height) + (total_width* (DrawY - enemy_y));
       end
       3'd4:begin
         sprite_addr = (width) + (DrawX - enemy_x) + (total_width*height*2) + (total_width* (DrawY - enemy_y));
       end
       3'd5:begin
         sprite_addr = (3*width) + (DrawX - enemy_x) + (total_width*height*2) + (total_width* (DrawY - enemy_y));
       end
       3'd6:begin
         sprite_addr = (width) + (DrawX - enemy_x) + (total_width*height*3) + (total_width* (DrawY - enemy_y));
       end
       default: begin //id=7
         sprite_addr = (3*width) + (DrawX - enemy_x) + (total_width*height*3) + (total_width* (DrawY - enemy_y));
       end

     endcase
	end
   else begin
     is_enemyteam = 1'b0;
   end
 end
endmodule

module hp_bar(input logic [9:0] DrawX, input logic [9:0] DrawY,
              input logic [6:0] maxHP, input logic [6:0] curHP,
              input logic [9:0] start_x, input logic [9:0] start_y,
              output logic [7:0] hp_r,
              output logic [7:0] hp_g,
              output logic [7:0] hp_b,
              output logic is_hpbar);

  parameter [5:0] width = 6'd50;
  parameter [5:0] height = 6'd5;

  logic [9:0] border_x;
  assign border_x = start_x - 1;
  logic [9:0] border_y;
  assign border_y = start_y - 1;
  logic [5:0] border_width;
  assign border_width = width + 2;
  logic [5:0] border_height;
  assign border_height = height + 2;
  logic [15:0] fill_width;
  assign fill_width = ((width*curHP)/maxHP);

  //black hp bar border
  always_comb begin
  if( ((DrawX>=border_x)&&(DrawX<(border_x+border_width))&&(DrawY==border_y || DrawY==(border_y+border_height-1)) )
      || (((DrawX==border_x)||(DrawX==(border_x+border_width-1)))&&(DrawY>=border_y && DrawY<=(border_y+border_height)))) begin
        hp_r = 8'h00;
        hp_g = 8'h00;
        hp_b = 8'h00;
        is_hpbar = 1'b1;
      end
  //filled hp
  else if(DrawX>=start_x && DrawX<(start_x+fill_width) && DrawY>=start_y && DrawY<(start_y+height))begin
    is_hpbar = 1'b1;
    if(fill_width*2>width)begin //100% to 50% health
      hp_r = 8'h41;   //green
      hp_g = 8'hff;
      hp_b = 8'h74;
    end
    if(fill_width*5>width)begin //50% to 20% health
      hp_r = 8'h41;   //orange-yellow
      hp_g = 8'hcc;
      hp_b = 8'h00;
    end
    else begin //20% to 0% health
      hp_r = 8'hff;   //red
      hp_g = 8'h33;
      hp_b = 8'h00;
    end
  end
  //unfilled hp
  else if(DrawX>=(start_x+fill_width) && DrawX<(start_x+width) && DrawY>=start_y && DrawY<(start_y+height))begin
    hp_r = 8'hff;
    hp_g = 8'hff;
    hp_b = 8'hff;
    is_hpbar = 1'b1;
  end
  else begin
    hp_r = 8'hff;
    hp_g = 8'hff;
    hp_b = 8'hff;
    is_hpbar = 1'b0;
  end
end
endmodule


//top level module of hp bar, hp indicator and pokemon name
module battle_info(input logic [9:0] DrawX, input logic [9:0] DrawY,
              input logic [6:0] maxHP, input logic [6:0] curHP,
              input logic [9:0] start_x, input logic [9:0] start_y, //indicates the start of pokemon name
              input logic [2:0] poke_id,
              input logic is_user_info, //only show user hp (curHP/maxHP), not enemy hp
              output logic [2:0] bit_num,
              output logic [7:0] info_hex,
              output logic [9:0] y_diff,
              output logic is_battleinfo_font,
              output logic [7:0] hp_r,
              output logic [7:0] hp_g,
              output logic [7:0] hp_b,
              output logic is_battleinfo_bar);
  logic [7:0] pname_hex;
  logic [2:0] pname_bitnum;
  logic is_pname;
  logic [9:0] name_ydiff;

  logic [7:0] hp_hex;
  logic [2:0] hp_bitnum;
  logic is_hptext;
  logic [9:0] hp_ydiff;

  logic [7:0] hp2_hex;
  logic [2:0] hp2_bitnum;
  logic is_hp2text;
  logic [9:0] hp2_ydiff;

  poke_names pnb(.DrawX(DrawX),.DrawY(DrawY),.start_x(start_x),.start_y(start_y),.poke_id(poke_id),
                 .bit_num(pname_bitnum),.pname_hex(pname_hex),.is_pname(is_pname), .y_diff(name_ydiff));
  //HP bar
  hp_bar bar_bar_jinks(.DrawX(DrawX), .DrawY(DrawY),
               .start_x(start_x+30), .start_y(start_y + 20),
               .maxHP(maxHP), .curHP(curHP),
               .hp_r(hp_r), .hp_g(hp_g), .hp_b(hp_b),
               .is_hpbar(is_battleinfo_bar));
  //Just the word: HP
  hp_text HP_HP(.DrawX(DrawX), .DrawY(DrawY),
                .start_x(start_x+3), .start_y(start_y + 22),
                .bit_num(hp_bitnum),
                .hp_hex(hp_hex),
                .is_hptext(is_hptext),
                .y_diff(hp_ydiff));
  hp_text2 HP2_HP2(.DrawX(DrawX), .DrawY(DrawY),
                  .start_x(start_x+7), .start_y(start_y+40),
                  .maxHP(maxHP),.curHP(curHP),
                  .bit_num(hp2_bitnum),
                  .hp2_hex(hp2_hex),
                  .is_hp2text(is_hp2text),
                  .y_diff(hp2_ydiff));
  always_comb begin
    if(is_pname)begin
      info_hex = pname_hex;
      y_diff = name_ydiff;
      bit_num = pname_bitnum;
      is_battleinfo_font = 1'b1;
    end
    else if(is_hptext) begin
      info_hex = hp_hex;
      y_diff = hp_ydiff;
      bit_num = hp_bitnum;
      is_battleinfo_font = 1'b1;
    end
    else if(is_hp2text && is_user_info)begin
      info_hex = hp2_hex;
      y_diff = hp2_ydiff;
      bit_num = hp2_bitnum;
      is_battleinfo_font = 1'b1;
    end
    else begin
      info_hex = 8'h20;
      y_diff = 10'd0;
      bit_num = 3'b0;
      is_battleinfo_font = 1'b0;
    end
  end
endmodule

module move_select(input logic [9:0] DrawX, input logic [9:0] DrawY,
              input logic [9:0] start_x, input logic [9:0] start_y, //start of move 0 text
              input logic [1:0][4:0] user_moves, //4 moves of the 26 available
              input logic [1:0] hovered_move, //0-3
              output logic [2:0] bit_num,
              output logic [7:0] move_hex,
              output logic [9:0] y_diff,
              output logic is_movename, //text
              output logic is_movebox); //box for selecting moves
  logic [9:0] box_x;
  assign box_x = start_x-5; //start of box 0
  logic [9:0] box_y;
  assign box_y = start_y-5;
  parameter [6:0] box_width = 7'd106; // 2(5) + 12(8)
  parameter [6:0] box_height = 7'd26; // 2(5) + 16
  parameter [6:0] box_xdiff = ;
  parameter [6:0] box_ydiff = ;

  logic [7:0] move0_hex;
  logic [2:0] move0_bitnum;
  logic is_move0name;
  logic [9:0] move0_ydiff;

  logic [7:0] move1_hex;
  logic [2:0] move1_bitnum;
  logic is_move1name;
  logic [9:0] move1_ydiff;

  logic [7:0] move2_hex;
  logic [2:0] move2_bitnum;
  logic is_move2name;
  logic [9:0] move2_ydiff;

  logic [7:0] move3_hex;
  logic [2:0] move3_bitnum;
  logic is_move3name;
  logic [9:0] move3_ydiff;

  moves_names move_sel0(.DrawX(DrawX), .DrawY(DrawY),
                   .start_x(start_x), .start_y(start_y),
                   .move_id(user_moves[0]),
                   .bit_num(move0_bitnum),
                   .move_hex(move0_hex),
                   .is_movename(is_move0name),
                   .y_diff(move0_ydiff));
  moves_names move_sel1(.DrawX(DrawX), .DrawY(DrawY),
                  .start_x(start_x+150), .start_y(start_y),
                  .move_id(user_moves[1]),
                  .bit_num(move1_bitnum),
                  .move_hex(move1_hex),
                  .is_movename(is_move1name),
                  .y_diff(move1_ydiff));
  moves_names move_sel2(.DrawX(DrawX), .DrawY(DrawY),
                   .start_x(start_x), .start_y(start_y+40),
                   .move_id(user_moves[2]),
                   .bit_num(move2_bitnum),
                   .move_hex(move2_hex),
                   .is_movename(is_move2name),
                   .y_diff(move2_ydiff));
  moves_names move_sel3(.DrawX(DrawX), .DrawY(DrawY),
                  .start_x(start_x+150), .start_y(start_y+40),
                  .move_id(user_moves[3]),
                  .bit_num(move3_bitnum),
                  .move_hex(move3_hex),
                  .is_movename(is_move3name),
                  .y_diff(move3_ydiff));
  always_comb begin

    is_movebox = 1'b0; //TEMPORARY

    if(is_move0name) begin
      bit_num = move0_bitnum;
      move_hex = move0_hex;
      y_diff = move0_ydiff;
      is_movename=1'b1;
    end
    else if(is_move1name) begin
      bit_num = move1_bitnum;
      move_hex = move1_hex;
      y_diff = move1_ydiff;
      is_movename=1'b1;
    end
    else if(is_move2name) begin
      bit_num = move2_bitnum;
      move_hex = move2_hex;
      y_diff = move2_ydiff;
      is_movename=1'b1;
    end
    else if(is_move3name) begin
      bit_num = move3_bitnum;
      move_hex = move3_hex;
      y_diff = move3_ydiff;
      is_movename=1'b1;
    end
    else begin
      bit_num = 3'b0;
      useratk_hex = 8'h20;
      y_diff = 10'b0;
      is_movename=1'b0;
    end


  end

endmodule

module user_attack(input logic [9:0] DrawX, input logic [9:0] DrawY,
              input logic [9:0] start_x, input logic [9:0] start_y, //start of first row of text
              input logic [4:0] move_id, //current move id
              input logic [2:0] poke_id, //current pokemon id
              output logic [2:0] bit_num,
              output logic [7:0] useratk_hex,
              output logic [9:0] y_diff,
              output logic is_useratk);
  logic [7:0] pname_hex;
  logic [2:0] pname_bitnum;
  logic is_pname;
  logic [9:0] name_ydiff;

  logic [7:0] used_hex;
  logic [2:0] used_bitnum;
  logic is_usedtext;
  logic [9:0] used_ydiff;

  logic [7:0] move_hex;
  logic [2:0] move_bitnum;
  logic is_movename;
  logic [9:0] move_ydiff;

  poke_names pn_atk(.DrawX(DrawX),.DrawY(DrawY),.start_x(start_x),.start_y(start_y),.poke_id(poke_id),
                 .bit_num(pname_bitnum),.pname_hex(pname_hex),.is_pname(is_pname), .y_diff(name_ydiff));
  used_text uwu(.DrawX(DrawX),.DrawY(Drawy),.start_x(start_x),.start_y(start_y+20).
                 .bit_num(used_bitnum),.used_hex(used_hex),.is_usedtext(is_usedtext),.y_diff(used_ydiff));
  moves_names user_move(.DrawX(DrawX), .DrawY(DrawY),
                   .start_x(start_x+40), .start_y(start_y+20),
                   .move_id(move_id),
                   .bit_num(move_bitnum),
                   .move_hex(move_hex),
                   .is_movename(is_movename),
                   .y_diff(move_ydiff));
  always_comb begin
    if(is_pname) begin
      bit_num = pname_bitnum;
      useratk_hex = pname_hex;
      y_diff = name_ydiff;
      is_useratk=1'b1;
    end
    else if(is_usedtext) begin
      bit_num = used_bitnum;
      useratk_hex = used_hex;
      y_diff = used_ydiff;
      is_useratk=1'b1;
    end
    else if(is_movename) begin
      bit_num = move_bitnum;
      useratk_hex = move_hex;
      y_diff = move_ydiff;
      is_useratk=1'b1;
    end
    else begin
      bit_num = 3'b0;
      useratk_hex = 8'h20;
      y_diff = 10'b0;
      is_useratk=1'b0;
    end
  end
endmodule;

module enemy_attack(input logic [9:0] DrawX, input logic [9:0] DrawY,
              input logic [9:0] start_x, input logic [9:0] start_y, //start of first row of text
              input logic [4:0] move_id, //current move id
              input logic [2:0] poke_id, //current pokemon id
              output logic [2:0] bit_num,
              output logic [7:0] enemyatk_hex,
              output logic [9:0] y_diff,
              output logic is_enemyatk);
  logic [7:0] enemy_hex;
  logic [2:0] enemy_bitnum;
  logic is_enemytext;
  logic [9:0] enemy_ydiff;

  logic [7:0] pname_hex;
  logic [2:0] pname_bitnum;
  logic is_pname;
  logic [9:0] name_ydiff;

  logic [7:0] used_hex;
  logic [2:0] used_bitnum;
  logic is_usedtext;
  logic [9:0] used_ydiff;

  logic [7:0] move_hex;
  logic [2:0] move_bitnum;
  logic is_movename;
  logic [9:0] move_ydiff;
  enemy_text entext(.DrawX(DrawX), .DrawY(DrawY),
                    .start_x(start_x), .start_y(start_y),
                    .bit_num(enemy_bitnum),
                    .enemy_hex(enemy_hex),
                    .is_enemytext(is_enemytext),
                    .y_diff(enemy_ydiff));
  poke_names pn_atk_enem(.DrawX(DrawX),.DrawY(DrawY),.start_x(start_x+48),.start_y(start_y),.poke_id(poke_id),
                 .bit_num(pname_bitnum),.pname_hex(pname_hex),.is_pname(is_pname), .y_diff(name_ydiff));
  used_text owo(.DrawX(DrawX),.DrawY(Drawy),.start_x(start_x),.start_y(start_y+20).
                 .bit_num(used_bitnum),.used_hex(used_hex),.is_usedtext(is_usedtext),.y_diff(used_ydiff));
  moves_names enememe_move(.DrawX(DrawX), .DrawY(DrawY),
                   .start_x(start_x+40), .start_y(start_y+20),
                   .move_id(move_id),
                   .bit_num(move_bitnum),
                   .move_hex(move_hex),
                   .is_movename(is_movename),
                   .y_diff(move_ydiff));
  always_comb begin
    if(is_enemytext) begin
      bit_num = enemy_bitnum;
      enemyatk_hex = enemy_hex;
      y_diff = enemy_ydiff;
      is_enemyatk=1'b1;
    end
    else if(is_pname) begin
      bit_num = pname_bitnum;
      enemyatk_hex = pname_hex;
      y_diff = name_ydiff;
      is_enemyatk=1'b1;
    end
    else if(is_usedtext) begin
      bit_num = used_bitnum;
      enemyatk_hex = used_hex;
      y_diff = used_ydiff;
      is_enemyatk=1'b1;
    end
    else if(is_movename) begin
      bit_num = move_bitnum;
      enemyatk_hex = move_hex;
      y_diff = move_ydiff;
      is_enemyatk=1'b1;
    end
    else begin
      bit_num = 3'b0;
      enemyatk_hex = 8'h20;
      y_diff = 10'b0;
      is_enemyatk=1'b0;
    end
  end
endmodule;
