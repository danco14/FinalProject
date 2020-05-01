module roam(input logic Clk,
            input logic [2:0] cur_battle, //0-4 , 5 total battles
            input logic is_roam,
            input logic [9:0] DrawX, input logic [9:0] DrawY,
            input logic [7:0] keycode,
            output logic is_sprite,
            output logic [5:0] roam_palette
            );
  parameter [9:0] map_x = 10'd280;
  parameter [9:0] map_y = 10'd150;
  parameter [7:0] map_width = 8'd96;
  parameter [7:0] map_height = 8'd143;
  parameter [9:0] enemy_x = 10'd321; //280 + 41
  parameter [9:0] enemy_y = 10'd220; //150 + 70
  parameter [7:0] enemy_width = 8'd14;
  parameter [7:0] enemy_height = 8'd16;
  logic [5:0] elite_palette;
  logic [5:0] map_palette;
  logic is_elite;
  logic is_map;
   // trainerRAM trainer(.Clk(Clk),.read_address(),.palette_idx());
  elite_sprites esprites(.DrawX(DrawX),.DrawY(DrawY),
                          .cur_battle(cur_battle),
                          .start_x(enemy_x),.start_y(enemy_y),
                          .width(enemy_width),.height(enemy_height),
                          .elite_palette(elite_palette),.is_elite(is_elite));
  map_background map0(.DrawX(DrawX),.DrawY(DrawY),
                       .start_x(map_x),.start_y(map_y),
                       .width(map_width),.height(map_height),
                       .map_palette(map_palette),.is_map(is_map));
  always_comb begin
    if(is_elite)begin
      is_sprite = 1'b1;
      if(elite_palette == 6'd0)begin
        roam_palette = map_palette;
      end
      else begin
        roam_palette = elite_palette;
      end
    end
    else if(is_map)begin
      roam_palette = map_palette;
      is_sprite = 1'b1;
    end
    else begin
		  roam_palette = 6'd1;
      is_sprite = 1'b0;
    end
  end
endmodule

module elite_sprites(input logic [9:0] DrawX, input logic [9:0] DrawY,
                     input logic [2:0] cur_battle,
                     input logic [9:0] start_x, input logic [9:0] start_y,
                     input logic [7:0] width, input logic [7:0] height,
                     output logic [5:0] elite_palette, output logic is_elite);
  logic [18:0] ram_addr;
  elitesRAM elites(.Clk(Clk),.read_address(ram_addr),.palette_idx(elite_palette));
  always_comb begin
    if(DrawX >= start_x && DrawX < (start_x + width) && DrawY >= start_y && DrawY < (start_y + height) )begin
      ram_addr = (cur_battle*width*height)+(DrawX-start_x)+(DrawY-start_y)*width;
      is_elite = 1'b1;
    end
    else begin
      ram_addr = 19'd0;
      is_elite = 1'b0;
    end
  end
endmodule

module map_background(input logic [9:0] DrawX, input logic [9:0] DrawY,
                     input logic [9:0] start_x, input logic [9:0] start_y,
                     input logic [7:0] width, input logic [7:0] height,
                     output logic [5:0] map_palette, output logic is_map);
  logic [18:0] ram_addr;
  mapRAM map(.Clk(Clk),.read_address(ram_addr),.palette_idx(map_palette));
  always_comb begin
    if(DrawX >= start_x && DrawX < (start_x + width) && DrawY >= start_y && DrawY < (start_y + height) )begin
      ram_addr = (DrawX-start_x)+(DrawY-start_y)*width;
      is_map = 1'b1;
    end
    else begin
      ram_addr = 19'd0;
      is_map = 1'b0;
    end
  end
endmodule
