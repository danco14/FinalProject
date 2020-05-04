module poke_names(input logic [9:0] DrawX, DrawY,
                  input logic [9:0] start_x, input logic [9:0] start_y,
                  input logic [2:0] poke_id,
                  output logic [2:0] bit_num,
                  output logic [7:0] pname_hex,
                  output logic is_pname,
                  output logic [9:0] y_diff);

  //hex codes of the pokemon names
//  parameter bit blastoise = {8'h42, 8'h4c, 8'h41, 8'h53, 8'h54, 8'h4f, 8'h49, 8'h53, 8'h45};
//  parameter bit charizard  = {8'h43, 8'h48, 8'h41, 8'h52, 8'h49, 8'h5a, 8'h41, 8'h52, 8'h44};
//  parameter bit dragonite  = {8'h44, 8'h52, 8'h41, 8'h47, 8'h4f, 8'h4e, 8'h49, 8'h54, 8'h45};
//  parameter bit gengar  =    {8'h47, 8'h45, 8'h4e, 8'h47, 8'h41, 8'h52};
//  parameter bit mew  =       {8'h4d, 8'h45, 8'h57};
//  parameter bit pikachu  =   {8'h50, 8'h49, 8'h4b, 8'h41, 8'h43, 8'h48, 8'h55};
//  parameter bit venusaur  =  {8'h56, 8'h45, 8'h4e, 8'h55, 8'h53, 8'h41, 8'h55, 8'h52};
//  parameter bit weezing  =   {8'h57, 8'h45, 8'h45, 8'h5a, 8'h49, 8'h4e, 8'h47};
  parameter bit [0:8][7:0] pokemon_names [0:7] = '{'{8'h42, 8'h4c, 8'h41, 8'h53, 8'h54, 8'h4f, 8'h49, 8'h53, 8'h45},
  '{8'h43, 8'h48, 8'h41, 8'h52, 8'h49, 8'h5a, 8'h41, 8'h52, 8'h44},
  '{8'h44, 8'h52, 8'h41, 8'h47, 8'h4f, 8'h4e, 8'h49, 8'h54, 8'h45},
  '{8'h47, 8'h45, 8'h4e, 8'h47, 8'h41, 8'h52, 8'h20, 8'h20, 8'h20},
  '{8'h4d, 8'h45, 8'h57, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20},
  '{8'h50, 8'h49, 8'h4b, 8'h41, 8'h43, 8'h48, 8'h55, 8'h20, 8'h20},
  '{8'h56, 8'h45, 8'h4e, 8'h55, 8'h53, 8'h41, 8'h55, 8'h52, 8'h20},
  '{8'h57, 8'h45, 8'h45, 8'h5a, 8'h49, 8'h4e, 8'h47, 8'h20, 8'h20}};


  parameter width = 8;
  parameter height = 16;
  parameter length=9;
  assign y_diff = (DrawY - start_y);
  always_comb begin
    if(DrawY>= start_y && DrawY < (start_y + height) && DrawX>=start_x && DrawX < start_x+width*length)begin
					is_pname = 1'b1;
					bit_num = DrawX - ((((DrawX-start_x)/width)*width)+start_x);
					pname_hex = pokemon_names[poke_id][((DrawX-start_x)/width)];
	end
  else begin
      is_pname = 1'b0;
      bit_num = 3'b0;
      pname_hex = 8'h20;
  end
  end

endmodule

module moves_names(input logic [9:0] DrawX, DrawY,
                 input logic [9:0] start_x, input logic [9:0] start_y,
                 input logic [4:0] move_id,
                 output logic [2:0] bit_num,
                 output logic [7:0] move_hex,
                 output logic is_movename,
                 output logic [9:0] y_diff);

 //hex codes of the move names
 parameter bit [0:11][7:0] move_names [0:25] ='{'{8'h48, 8'h59, 8'h44, 8'h52, 8'h4f, 8'h20, 8'h50, 8'h55, 8'h4d, 8'h50, 8'h20, 8'h20},
 '{8'h49, 8'h43, 8'h45, 8'h20, 8'h42, 8'h45, 8'h41, 8'h4d, 8'h20, 8'h20, 8'h20, 8'h20},
 '{8'h43, 8'h52, 8'h55, 8'h4e, 8'h43, 8'h48, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20},
 '{8'h41, 8'h55, 8'h52, 8'h41, 8'h20, 8'h53, 8'h50, 8'h48, 8'h45, 8'h52, 8'h45, 8'h20},
 '{8'h46, 8'h4c, 8'h41, 8'h4d, 8'h45, 8'h54, 8'h48, 8'h52, 8'h4f, 8'h57, 8'h45, 8'h52},
 '{8'h54, 8'h48, 8'h55, 8'h4e, 8'h44, 8'h45, 8'h52, 8'h50, 8'h55, 8'h4e, 8'h43, 8'h48},
 '{8'h41, 8'h49, 8'h52, 8'h20, 8'h53, 8'h4c, 8'h41, 8'h53, 8'h48, 8'h20, 8'h20, 8'h20},
 '{8'h44, 8'h52, 8'h41, 8'h47, 8'h4f, 8'h4e, 8'h20, 8'h43, 8'h4c, 8'h41, 8'h57, 8'h20},
 '{8'h45, 8'h4e, 8'h45, 8'h52, 8'h47, 8'h59, 8'h20, 8'h42, 8'h41, 8'h4c, 8'h4c, 8'h20},
 '{8'h53, 8'h4c, 8'h55, 8'h44, 8'h47, 8'h45, 8'h20, 8'h42, 8'h4f, 8'h4d, 8'h42, 8'h20},
 '{8'h45, 8'h41, 8'h52, 8'h54, 8'h48, 8'h51, 8'h55, 8'h41, 8'h4b, 8'h45, 8'h20, 8'h20},
 '{8'h50, 8'h45, 8'h54, 8'h41, 8'h4c, 8'h20, 8'h44, 8'h41, 8'h4e, 8'h43, 8'h45, 8'h20},
 '{8'h54, 8'h48, 8'h55, 8'h4e, 8'h44, 8'h45, 8'h52, 8'h42, 8'h4f, 8'h4c, 8'h54, 8'h20},
 '{8'h53, 8'h4c, 8'h41, 8'h4d, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20},
 '{8'h53, 8'h55, 8'h52, 8'h46, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20},
 '{8'h54, 8'h48, 8'h55, 8'h4e, 8'h44, 8'h45, 8'h52, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20},
 '{8'h44, 8'h41, 8'h52, 8'h4b, 8'h20, 8'h50, 8'h55, 8'h4c, 8'h53, 8'h45, 8'h20, 8'h20},
 '{8'h53, 8'h48, 8'h41, 8'h44, 8'h4f, 8'h57, 8'h20, 8'h42, 8'h41, 8'h4c, 8'h4c, 8'h20},
 '{8'h50, 8'h53, 8'h59, 8'h43, 8'h48, 8'h49, 8'h43, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20},
 '{8'h50, 8'h4c, 8'h41, 8'h59, 8'h20, 8'h52, 8'h4f, 8'h55, 8'h47, 8'h48, 8'h20, 8'h20},
 '{8'h46, 8'h4c, 8'h41, 8'h53, 8'h48, 8'h20, 8'h43, 8'h41, 8'h4e, 8'h4e, 8'h4f, 8'h4e},
 '{8'h42, 8'h55, 8'h47, 8'h20, 8'h42, 8'h55, 8'h5a, 8'h5a, 8'h20, 8'h20, 8'h20, 8'h20},
 '{8'h46, 8'h49, 8'h52, 8'h45, 8'h20, 8'h42, 8'h4c, 8'h41, 8'h53, 8'h54, 8'h20, 8'h20},
 '{8'h52, 8'h4f, 8'h43, 8'h4b, 8'h20, 8'h53, 8'h4c, 8'h49, 8'h44, 8'h45, 8'h20, 8'h20},
 '{8'h44, 8'h52, 8'h41, 8'h47, 8'h4f, 8'h4e, 8'h20, 8'h50, 8'h55, 8'h4c, 8'h53, 8'h45},
 '{8'h42, 8'h4c, 8'h49, 8'h5a, 8'h5a, 8'h41, 8'h52, 8'h44, 8'h20, 8'h20, 8'h20, 8'h20}};

 parameter width = 8;
 parameter height = 16;
 parameter length = 12;
 assign y_diff = DrawY - start_y;

 always_comb begin
   if(DrawY>= start_y && DrawY < (start_y + height) && DrawX>=start_x && DrawX < start_x+width*length)begin
      is_movename = 1'b1;
      bit_num = DrawX - ((((DrawX-start_x)/width)*width)+start_x);
      move_hex = move_names[move_id][((DrawX-start_x)/width)];
   end
  else begin
     is_movename = 1'b0;
     bit_num = 3'b0;
     move_hex = 8'h20;
 end
 end

endmodule

module enemy_text(input logic [9:0] DrawX, DrawY,
                 input logic [9:0] start_x, input logic [9:0] start_y,
                 output logic [2:0] bit_num,
                 output logic [7:0] enemy_hex,
                 output logic is_enemytext,
                 output logic [9:0] y_diff);
 // 'E' 'N' 'E' 'M' 'Y' ' ' = 6 chars
 parameter width = 8;
 parameter height = 16;
 parameter length = 6;
 assign y_diff = DrawY - start_y;
 parameter [0:5][7:0] enemy_hexcodes = '{8'h45,8'h4e,8'h45,8'h4d,8'h59,8'h20};
 always_comb begin
 if(DrawY>=start_y && DrawY < (start_y+height) && DrawX>=start_x && DrawX<start_x+width*length)begin
   is_enemytext=1'b1;
   bit_num = DrawX - ((((DrawX-start_x)/width)*width)+start_x);
   enemy_hex= enemy_hexcodes[((DrawX-start_x)/width)];
 end
 else begin
   bit_num = 3'b0;
   enemy_hex = 8'h20;
   is_enemytext = 1'b0;
 end
 end
endmodule

module used_text(input logic [9:0] DrawX, DrawY,
                 input logic [9:0] start_x, input logic [9:0] start_y,
                 output logic [2:0] bit_num,
                 output logic [7:0] used_hex,
                 output logic is_usedtext,
                 output logic [9:0] y_diff);
 // 'U' 'S' 'E' 'D' ' ' = 5 chars
 parameter width = 8;
 parameter height = 16;
 parameter length = 5;
 parameter [0:4][7:0]used_hexcodes = '{8'h55,8'h53,8'h45,8'h44,8'h20};

 assign y_diff = DrawY - start_y;

 always_comb begin
 if(DrawY>=start_y && DrawY < (start_y+height) && DrawX>=start_x && DrawX<start_x+width*length)begin
	  is_usedtext=1'b1;
	  bit_num = DrawX - ((((DrawX-start_x)/width)*width)+start_x);
	  used_hex= used_hexcodes[((DrawX-start_x)/width)];
 end
 else begin
   is_usedtext = 1'b0;
   bit_num = 3'b0;
   used_hex = 8'h20;
 end
end
endmodule


module hp_text(input logic [9:0] DrawX, DrawY,
                 input logic [9:0] start_x, input logic [9:0] start_y,
                 output logic [2:0] bit_num,
                 output logic [7:0] hp_hex,
                 output logic is_hptext,
                 output logic [9:0] y_diff);
 // 'H' 'P' = 2 chars
 parameter width = 8;
 parameter height = 16;
 parameter length = 2;
 parameter [0:1][7:0] hp_hexcodes = '{8'h48,8'h50};
 assign y_diff = DrawY - start_y;

 always_comb begin
 if(DrawY>=start_y && DrawY < (start_y+height) && DrawX>=start_x && DrawX<start_x+width*length)begin
   is_hptext = 1'b1;
   bit_num = DrawX - ((((DrawX-start_x)/width)*width)+start_x);
   hp_hex = hp_hexcodes[((DrawX-start_x)/width)];
 end
 else begin
   is_hptext = 1'b0;
   bit_num = 3'b0;
   hp_hex = 8'h20;
 end
end
endmodule

//show hp numbers: 37/50 , 100/100 etc.
module hp_text2(input logic [9:0] DrawX, DrawY,
                 input logic [9:0] start_x, input logic [9:0] start_y,
                 input logic [7:0] maxHP, input logic [7:0] curHP,
                 output logic [2:0] bit_num,
                 output logic [7:0] hp2_hex,
                 output logic is_hp2text,
                 output logic [9:0] y_diff);
 //max hp is currently <200 hp, => _ _ _ / _ _ _ = 7 characters
 parameter width = 8;
 parameter height = 16;
 parameter length = 7;
 assign y_diff = DrawY - start_y;

 logic [7:0] first_hp [0:2];
 logic [7:0] second_hp [0:2];
 logic [7:0] hp_hexcodes [0:6];
 assign hp_hexcodes[3] = 8'h2f;
 always_comb begin
   if(curHP>=100)begin
     hp_hexcodes[0] = 8'h31;
   end
   else begin
     hp_hexcodes[0] = 8'h20;
   end
   if(maxHP>=100)begin
     hp_hexcodes[4] = 8'h31;
   end
   else begin
     hp_hexcodes[4] = 8'h20;
   end
   hp_hexcodes[1] = ((curHP % 100) / 10) + 8'h30;
   hp_hexcodes[5] = ((maxHP % 100) / 10)+ 8'h30;
   hp_hexcodes[2] = (curHP % 10) + 8'h30;
   hp_hexcodes[6] = (maxHP % 10) + 8'h30;

	 if(hp_hexcodes[0]==8'h20 && hp_hexcodes[1]==8'h30)begin
		hp_hexcodes[1] = 8'h20;
	 end
	 else begin
		hp_hexcodes[1] = ((curHP % 100) / 10) + 8'h30;
	 end
   if(DrawY>=start_y && DrawY < (start_y+height) && DrawX>=start_x && DrawX<start_x+width*length)begin
     hp2_hex = hp_hexcodes[((DrawX-start_x)/width)];
     bit_num = DrawX - ((((DrawX-start_x)/width)*width)+start_x);
     is_hp2text=1'b1;
   end
   else begin
     hp2_hex = 8'h30;
     bit_num = 3'b0;
     is_hp2text = 1'b0;
   end
 end
endmodule

module win_text(input logic [9:0] DrawX, DrawY,
                 input logic [9:0] start_x, input logic [9:0] start_y,
                 output logic [2:0] bit_num,
                 output logic [7:0] win_hex,
                 output logic is_wintext,
                 output logic [9:0] y_diff);
 // 'C' 'O' 'N' 'G' 'R' 'A' 'T' 'U' 'L' 'A' 'T' 'I' 'O' 'N' 'S' ',' ' ' 'Y' 'O' 'U' ' ' 'W' 'I' 'N' '!!' = 25 chars
 parameter width = 8;
 parameter height = 16;
 parameter length = 25;
 assign y_diff = DrawY - start_y;
 parameter [0:24][7:0] win_hexcodes = '{8'h43, 8'h4f, 8'h4e, 8'h47, 8'h52, 8'h41, 8'h54, 8'h55, 8'h4c, 8'h41, 8'h54, 8'h49, 8'h4f, 8'h4e, 8'h53, 8'h2c, 8'h20, 8'h59, 8'h4f, 8'h55, 8'h20, 8'h57, 8'h49, 8'h4e, 8'h13};
 always_comb begin
 if(DrawY>=start_y && DrawY < (start_y+height) && DrawX>=start_x && DrawX<start_x+width*length)begin
   is_wintext=1'b1;
   bit_num = DrawX - ((((DrawX-start_x)/width)*width)+start_x);
   win_hex= win_hexcodes[((DrawX-start_x)/width)];
 end
 else begin
   bit_num = 3'b0;
   win_hex = 8'h20;
   is_wintext = 1'b0;
 end
 end
 endmodule
 
 module lose_text(input logic [9:0] DrawX, DrawY,
                 input logic [9:0] start_x, input logic [9:0] start_y,
                 output logic [2:0] bit_num,
                 output logic [7:0] lose_hex,
                 output logic is_losetext,
                 output logic [9:0] y_diff);
 // 'G' 'A' 'M' 'E' ' ' 'O' 'V' 'E' 'R' = 9 chars
 parameter width = 8;
 parameter height = 16;
 parameter length = 9;
 assign y_diff = DrawY - start_y;
 parameter [0:8][7:0] lose_hexcodes = '{8'h47, 8'h41, 8'h4d, 8'h45, 8'h20, 8'h4f, 8'h56, 8'h45, 8'h52};
 always_comb begin
 if(DrawY>=start_y && DrawY < (start_y+height) && DrawX>=start_x && DrawX<start_x+width*length)begin
   is_losetext=1'b1;
   bit_num = DrawX - ((((DrawX-start_x)/width)*width)+start_x);
   lose_hex= lose_hexcodes[((DrawX-start_x)/width)];
 end
 else begin
   bit_num = 3'b0;
   lose_hex = 8'h20;
   is_losetext = 1'b0;
 end
 end
 endmodule
 