module roam(input logic Clk,
            input logic Reset,
            input logic frame_clk,
            input logic [2:0] cur_battle, //0-4 , 5 total battles
            input logic is_roam,
            input logic [9:0] DrawX, input logic [9:0] DrawY,
            input logic [7:0] keycode,
            output logic is_sprite,
            output logic [5:0] roam_palette
            );
  parameter [9:0] map_x = 10'd300;
  parameter [9:0] map_y = 10'd100;
  parameter [7:0] map_width = 8'd192;
  parameter [7:0] map_height = 8'd255;
  parameter [9:0] enemy_x = 10'd389; //300 + 89
  parameter [9:0] enemy_y = 10'd212; //100 + 112
  parameter [7:0] enemy_width = 8'd14;
  parameter [7:0] enemy_height = 8'd16;
  parameter [7:0] trainer_width = 8'd14;
  parameter [7:0] trainer_height = 8'd16;
  parameter [2:0] x_step = 3'd1;
  parameter [2:0] y_step = 3'd1;

  parameter [7:0] W = 8'h1A;
  parameter [7:0] A = 8'h04;
  parameter [7:0] S = 8'h16;
  parameter [7:0] D = 8'h07;

  logic [5:0] elite_palette;
  logic [5:0] map_palette;
  logic [5:0] trainer_palette;
  logic is_elite;
  logic is_map;
  logic is_trainer;

  logic [1:0] trainer_dir;  //trainer direction: 0 = back, 1=front, 2=left, 3=right
  logic [1:0] trainer_dir_in;
  logic [9:0] trainer_x;
  logic [9:0] trainer_y;
  logic [9:0] trainer_x_in;
  logic [9:0] trainer_y_in;
  logic [2:0] motion_x;
  logic [2:0] motion_y;
  logic [2:0] motion_x_in;
  logic [2:0] motion_y_in;


  logic frame_clk_delayed, frame_clk_rising_edge;
  always_ff @ (posedge Clk) begin
      frame_clk_delayed <= frame_clk;
      frame_clk_rising_edge <= (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
  end

  logic frame_clk_delayed, frame_clk_rising_edge;
  always_ff(@posedge Clk)begin
    if(Reset || !is_roam) begin
      trainer_x <= 10'd387;  //300+87
      trainer_y <= 10'd336; //100 + 236
      trainer_dir <= 2'b0; //show back of trainer
      motion_x <= 3'b0;
      motion_y <= 3'b0;
    end
    else begin
      trainer_x <= trainer_x_in;
      trainer_y <= trainer_y_in;
      trainer_dir <= trainer_dir_in;
      motion_x <= motion_x_in;
      motion_y <= motion_y_in;
    end
  end
  always_comb begin
    trainer_x_in <= trainer_x;
    trainer_y_in <= trainer_y;
    trainer_dir_in <= trainer_dir;
    motion_x_in <= motion_x;
    motion_y_in <= motion_y;

    if(frame_clk_rising_edge)begin
      if(keycode == W) begin
          if(trainer_dir!=2'd0) begin
            trainer_dir_in = 2'b0;
            motion_x_in = 3'd0;
  					motion_y_in = 3'd0;
          end
          else begin
            motion_x_in = 3'd0;
  					motion_y_in = (~y_step) + 1'b1;
          end
			end
      else if(keycode == S) begin
        if(trainer_dir!=2'd1) begin
          trainer_dir_in = 2'd1;
          motion_x_in = 3'd0;
          motion_y_in = 3'd0;
        end
        else begin
          motion_x_in = 3'd0;
          motion_y_in = y_step;
        end
      end
      else if(keycode == A) begin
        if(trainer_dir!=2'd2) begin
          trainer_dir_in = 2'd2;
          motion_x_in = 3'd0;
          motion_y_in = 3'd0;
        end
        else begin
          motion_x_in = (~x_step) + 1'b1;
          motion_y_in = 3'd0;
        end
      end
      else if(keycode == D) begin
        if(trainer_dir!=2'd3) begin
          trainer_dir_in = 2'd3;
          motion_x_in = 3'd0;
          motion_y_in = 3'd0;
        end
        else begin
          motion_x_in = x_step;
          motion_y_in = 3'd0;
        end
      end

      //boundary checking goes here ...
      
      trainer_x_in = trainer_x + motion_x;
      trainer_y_in = trainer_y + motion_y;
    end
  end
	elite_sprites esprites(.Clk(Clk),.DrawX(DrawX),.DrawY(DrawY),
                          .cur_battle(cur_battle),
                          .start_x(enemy_x),.start_y(enemy_y),
                          .width(enemy_width),.height(enemy_height),
                          .elite_palette(elite_palette),.is_elite(is_elite));

	map_background map0(.Clk(Clk),.DrawX(DrawX),.DrawY(DrawY),
                       .start_x(map_x),.start_y(map_y),
                       .width(map_width),.height(map_height),
                       .map_palette(map_palette),.is_map(is_map));

  trainer_sprite trainerspr(.Clk(Clk),.DrawX(DrawX),.DrawY(DrawY),
                      .direction(trainer_dir),
                      .start_x(trainer_x),.start_y(trainer_y),
                      .width(trainer_width),.height(trainer_height),
                      .trainer_palette(trainer_palette),.is_trainer(is_trainer));
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
    else if(is_trainer)begin
      is_sprite = 1'b1;
      if(trainer_palette == 6'd0)begin
        roam_palette = map_palette;
      end
      else begin
        roam_palette = trainer_palette;
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

module trainer_sprite(input logic Clk, input logic [9:0] DrawX, input logic [9:0] DrawY,
                     input logic [1:0] direction,
                     input logic [9:0] start_x, input logic [9:0] start_y,
                     input logic [7:0] width, input logic [7:0] height,
                     output logic [5:0] trainer_palette, output logic is_trainer);
   logic [18:0] ram_addr;
   trainerRAM trainerJam(.Clk(Clk),.read_address(ram_addr),.palette_idx(trainer_palette));
   always_comb begin
     if(DrawX >= start_x && DrawX < (start_x + width) && DrawY >= start_y && DrawY < (start_y + height) )begin
       ram_addr = (direction*width*height)+(DrawX-start_x)+(DrawY-start_y)*width;
       is_trainer = 1'b1;
     end
     else begin
       ram_addr = 19'd0;
       is_trainer = 1'b0;
     end
   end
endmodule

module elite_sprites(input logic Clk, input logic [9:0] DrawX, input logic [9:0] DrawY,
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

module map_background(input logic Clk, input logic [9:0] DrawX, input logic [9:0] DrawY,
                     input logic [9:0] start_x, input logic [9:0] start_y,
                     input logic [7:0] width, input logic [7:0] height,
                     output logic [5:0] map_palette, output logic is_map);
  logic [18:0] ram_addr;
  mapRAM mapmapmap(.Clk(Clk),.read_address(ram_addr),.palette_idx(map_palette));
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
