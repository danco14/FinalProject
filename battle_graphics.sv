//back facing team sprites
module my_sprites (input logic [9:0] DrawX, input logic [9:0] DrawY,
                   input logic [2:0] poke_id,
                   output logic [18:0] sprite_addr,
                   output logic is_myteam);
   parameter [9:0] team_x = 10'd370;
   parameter [9:0] team_y = 10'd140;
   parameter [5:0] width = 6'd56;
   parameter [5:0] height = 6'd56;
   parameter [7:0] total_width = 8'd224;
   always_comb begin
   if(DrawX >= team_x && DrawX < (team_x + width) && DrawY >= team_y && DrawY < (team_y + height) )begin
     is_myteam = 1'b1;
     case(poke_id) begin
       3'd0: begin
         sprite_addr = (DrawX - team_x) + (total_width* (DrawY - team_y));
       end
       3'd1:begin
         sprite_addr = (2*width) + (DrawX - team_x) + (total_width* (DrawY - team_y))
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
                   output logic [18:0] sprite_addr,
                   output logic is_enemyteam);
   parameter [9:0] enemy_x = 10'd370;
   parameter [9:0] enemy_y = 10'd140;
   parameter [5:0] width = 6'd56;
   parameter [5:0] height = 6'd56;
   parameter [7:0] total_width = 8'd224;
   always_comb begin
   if(DrawX >= enemy_x && DrawX < (enemy_x + width) && DrawY >= enemy_y && DrawY < (enemy_y + height) )begin
     is_enemyteam = 1'b1;
     case(poke_id) begin
       3'd0: begin
         sprite_addr = (width) + (DrawX - enemy_x) + (total_width* (DrawY - enemy_y));
       end
       3'd1:begin
         sprite_addr = (3*width) + (DrawX - enemy_x) + (total_width* (DrawY - enemy_y))
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
  parameter border_x = start_x - 1;
  parameter border_y = start_y + 1;
  parameter border_width = width + 2;
  parameter border_height = height + 2;
  parameter [5:0] fill_width = ((width*curHP)/maxHP);
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
