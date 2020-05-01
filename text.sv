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

//        if(DrawX>=start_x && DrawX < (start_x + width))begin
//          is_pname = 1'b1;
//          bit_num = DrawX - start_x;
//          pname_hex = pokemon_names[poke_id][0];
//        end
//        else if(DrawX>=start_x && DrawX < start_x + (width*(2)))begin
//          is_pname = 1'b1;
//          bit_num = DrawX - (start_x + (width*(1)));
//          pname_hex = pokemon_names[poke_id][1];
//        end
//        else if(DrawX>=start_x && DrawX < start_x + (width*(3)))begin
//          is_pname = 1'b1;
//          bit_num = DrawX - (start_x + (width*(2)));
//          pname_hex = pokemon_names[poke_id][2];
//        end
//        else if(DrawX>=start_x && DrawX < start_x + (width*(4)))begin
//          is_pname = 1'b1;
//          bit_num = DrawX - (start_x + (width*(3)));
//          pname_hex = pokemon_names[poke_id][3];
//        end
//        else if(DrawX>=start_x && DrawX < start_x + (width*(5)))begin
//          is_pname = 1'b1;
//          bit_num = DrawX - (start_x + (width*(4)));
//          pname_hex = pokemon_names[poke_id][4];
//        end
//        else if(DrawX>=start_x && DrawX < start_x + (width*(6)))begin
//          is_pname = 1'b1;
//          bit_num = DrawX - (start_x + (width*(5)));
//          pname_hex = pokemon_names[poke_id][5];
//        end
//        else if(DrawX>=start_x && DrawX < start_x + (width*(7)))begin
//          is_pname = 1'b1;
//          bit_num = DrawX - (start_x + (width*(6)));
//          pname_hex = pokemon_names[poke_id][6];
//        end
//        else if(DrawX>=start_x && DrawX < start_x + (width*(8)))begin
//          is_pname = 1'b1;
//          bit_num = DrawX - (start_x + (width*(7)));
//          pname_hex = pokemon_names[poke_id][7];
//        end
//        else if(DrawX>=start_x && DrawX < start_x + (width*(9)))begin
//          is_pname = 1'b1;
//          bit_num = DrawX - (start_x + (width*(8)));
//          pname_hex = pokemon_names[poke_id][8];
//        end
//   else begin
//      is_pname = 1'b0;
//      bit_num = 3'b0;
//      pname_hex = 8'h20;
//   end
//   end
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

 assign y_diff = DrawY - start_y;

 always_comb begin
   if(DrawY>= start_y && DrawY < (start_y + height))begin
       if(DrawX>=start_x && DrawX < (start_x + width))begin
         is_movename = 1'b1;
         bit_num = DrawX - start_x;
         move_hex = move_names[move_id][0];
       end
       else if(DrawX>=start_x && DrawX < start_x + (width*(2)))begin
         is_movename = 1'b1;
         bit_num = DrawX - (start_x + (width*(1)));
         move_hex = move_names[move_id][1];
       end
       else if(DrawX>=start_x && DrawX < start_x + (width*(3)))begin
         is_movename = 1'b1;
         bit_num = DrawX - (start_x + (width*(2)));
         move_hex = move_names[move_id][2];
       end
       else if(DrawX>=start_x && DrawX < start_x + (width*(4)))begin
         is_movename = 1'b1;
         bit_num = DrawX - (start_x + (width*(3)));
         move_hex = move_names[move_id][3];
       end
       else if(DrawX>=start_x && DrawX < start_x + (width*(5)))begin
         is_movename = 1'b1;
         bit_num = DrawX - (start_x + (width*(4)));
         move_hex = move_names[move_id][4];
       end
       else if(DrawX>=start_x && DrawX < start_x + (width*(6)))begin
         is_movename = 1'b1;
         bit_num = DrawX - (start_x + (width*(5)));
         move_hex = move_names[move_id][5];
       end
       else if(DrawX>=start_x && DrawX < start_x + (width*(7)))begin
         is_movename = 1'b1;
         bit_num = DrawX - (start_x + (width*(6)));
         move_hex = move_names[move_id][6];
       end
       else if(DrawX>=start_x && DrawX < start_x + (width*(8)))begin
         is_movename = 1'b1;
         bit_num = DrawX - (start_x + (width*(7)));
         move_hex = move_names[move_id][7];
       end
       else if(DrawX>=start_x && DrawX < start_x + (width*(9)))begin
         is_movename = 1'b1;
         bit_num = DrawX - (start_x + (width*(8)));
         move_hex = move_names[move_id][8];
       end
       else if(DrawX>=start_x && DrawX < start_x + (width*(10)))begin
         is_movename = 1'b1;
         bit_num = DrawX - (start_x + (width*(9)));
         move_hex = move_names[move_id][9];
       end
       else if(DrawX>=start_x && DrawX < start_x + (width*(11)))begin
         is_movename = 1'b1;
         bit_num = DrawX - (start_x + (width*(10)));
         move_hex = move_names[move_id][10];
       end
       else if(DrawX>=start_x && DrawX < start_x + (width*(12)))begin
         is_movename = 1'b1;
         bit_num = DrawX - (start_x + (width*(11)));
         move_hex = move_names[move_id][11];
       end
  else begin
     is_movename = 1'b0;
     bit_num = 3'b0;
     move_hex = 8'h20;
  end

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

 assign y_diff = DrawY - start_y;

 always_comb begin
 if(DrawY>=start_y && DrawY < (start_y+height))begin
   if(DrawX>=start_x && DrawX<start_x+width)begin
     is_enemytext=1'b1;
     bit_num = DrawX - start_x;
     enemy_hex = 8'h45;
   end
   else if(DrawX>=start_x && DrawX<start_x+(2*width))begin
     is_enemytext=1'b1;
     bit_num = DrawX - (start_x+width);
     enemy_hex = 8'h4e;
   end
   else if(DrawX>=start_x && DrawX<start_x+(3*width))begin
     is_enemytext=1'b1;
     bit_num = DrawX - (start_x+(width*2));
     enemy_hex = 8'h45;
   end
   else if(DrawX>=start_x && DrawX<start_x+(4*width))begin
     is_enemytext=1'b1;
     bit_num = DrawX - (start_x+(width*3));
     enemy_hex = 8'h4d;
   end
   else if(DrawX>=start_x && DrawX<start_x+(5*width))begin
     is_enemytext=1'b1;
     bit_num = DrawX - (start_x+(width*4));
     enemy_hex = 8'h59;
   end
   else if(DrawX>=start_x && DrawX<start_x+(6*width))begin
     is_enemytext=1'b1;
     bit_num = DrawX - (start_x+(width*5));
     enemy_hex = 8'h20;
   end
   else begin
     bit_num = 3'b0;
     enemy_hex = 8'h20;
     is_enemytext=1'b0;
   end
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
 parameter [2:0][7:0]used_hexcodes = '{8'h55,8'h53,8'h45,8'h44,8'h20};

 assign y_diff = DrawY - start_y;

 always_comb begin
 if(DrawY>=start_y && DrawY < (start_y+height) && DrawX>=start_x && DrawX<start_x+width*length)begin
	  is_usedtext=1'b1;
	  bit_num = DrawX - ((((DrawX-start_x)/width)*width)+start_x);
	  used_hex= used_hexcodes[((DrawX-start_x)/width)];
//   if(DrawX>=start_x && DrawX<start_x+width)begin
//     is_usedtext=1'b1;
//     bit_num = DrawX - start_x;
//     used_hex = 8'h55;
//   end
//   else if(DrawX>=start_x && DrawX<start_x+(2*width))begin
//     is_usedtext=1'b1;
//     bit_num = DrawX - (start_x+width);
//     used_hex = 8'h53;
//   end
//   else if(DrawX>=start_x && DrawX<start_x+(3*width))begin
//     is_usedtext=1'b1;
//     bit_num = DrawX - (start_x+(width*2));
//     used_hex = 8'h45;
//   end
//   else if(DrawX>=start_x && DrawX<start_x+(4*width))begin
//     is_usedtext=1'b1;
//     bit_num = DrawX - (start_x+(width*3));
//     used_hex = 8'h44;
//   end
//   else if(DrawX>=start_x && DrawX<start_x+(5*width))begin
//     is_usedtext=1'b1;
//     bit_num = DrawX - (start_x+(width*4));
//     used_hex = 8'h20;
//   end
//   else begin
//     is_usedtext=1'b0;
//     bit_num = 3'b0;
//     used_hex = 8'h20;
//   end
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

 assign y_diff = DrawY - start_y;

 always_comb begin
 if(DrawY>=start_y && DrawY < (start_y+height))begin
   if(DrawX>=start_x && DrawX<start_x+width)begin
     is_hptext=1'b1;
     bit_num = DrawX - start_x;
     hp_hex = 8'h48;
   end
   else if(DrawX>=start_x && DrawX<start_x+(2*width))begin
     is_hptext=1'b1;
     bit_num = DrawX - (start_x+width);
     hp_hex = 8'h50;
   end
   else begin
     is_hptext=1'b0;
     bit_num = 3'b0;
     hp_hex = 8'h20;
   end
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
 //ascii 0 = 0x30
 parameter width = 8;
 parameter height = 16;

 assign y_diff = DrawY - start_y;

 logic [7:0] first_hp [0:2];
 logic [7:0] second_hp [0:2];

 always_comb begin
   if(curHP>=100)begin
     first_hp[0] = 8'h31;
   end
   else begin
     first_hp[0] = 8'h20;
   end
   if(maxHP>=100)begin
     second_hp[0] = 8'h31;
   end
   else begin
     second_hp[0] = 8'h20;
   end
	 first_hp[1] = ((curHP % 100) / 10) + 8'h30;
   second_hp[1] = ((maxHP % 100) / 10)+ 8'h30;
   first_hp[2] = (curHP % 10) + 8'h30;
   second_hp[2] = (maxHP % 10) + 8'h30;
	 if(first_hp[0]==8'h20 && first_hp[1]==8'h30)begin
		first_hp[1] = 8'h20;
	 end
	 else begin
		first_hp[1] = ((curHP % 100) / 10) + 8'h30;
	 end
   if(DrawY>=start_y && DrawY < (start_y+height))begin
     if(DrawX>=start_x && DrawX<start_x+width)begin
       hp2_hex = first_hp[0];
       bit_num = DrawX - start_x;
       is_hp2text=1'b1;
     end
     else if(DrawX>=start_x && DrawX<start_x+(2*width))begin
       hp2_hex = first_hp[1];
       bit_num = DrawX - (start_x+width);
       is_hp2text=1'b1;
     end
     else if(DrawX>=start_x && DrawX<start_x+(3*width))begin
       hp2_hex = first_hp[2];
       bit_num = DrawX - (start_x+(width*2));
       is_hp2text=1'b1;
     end
     else if(DrawX>=start_x && DrawX<start_x+(4*width))begin
       hp2_hex = 8'h2f; // front slash /
       bit_num = DrawX - (start_x+(width*3));
       is_hp2text=1'b1;
     end
     else if(DrawX>=start_x && DrawX<start_x+(5*width))begin
       hp2_hex = second_hp[0];
       bit_num = DrawX - (start_x+(width*4));
       is_hp2text=1'b1;
     end
     else if(DrawX>=start_x && DrawX<start_x+(6*width))begin
       hp2_hex = second_hp[1];
       bit_num = DrawX - (start_x+(width*5));
       is_hp2text=1'b1;
     end
     else if(DrawX>=start_x && DrawX<start_x+(7*width))begin
       hp2_hex = second_hp[2];
       bit_num = DrawX - (start_x+(width*6));
       is_hp2text=1'b1;
     end
     else begin
       is_hp2text=1'b0;
		  hp2_hex = 8'h30;
		  bit_num = 3'b0;
     end
   end
   else begin
     hp2_hex = 8'h30;
     bit_num = 3'b0;
     is_hp2text = 1'b0;
   end
 end
endmodule
