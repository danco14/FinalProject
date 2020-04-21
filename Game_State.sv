module game_state(input logic Clk, input logic Reset,
                  input logic [9:0] DrawX, input logic [9:0] DrawY,
                  input logic [7:0] keycode,
                  output logic [4:0] palette_idx,
                  output logic is_background);

  enum logic [20:0] {Start, Roam, Player_1, Player_2, End} State, Next_state;

  logic [18:0] poke_sprite_addr;
  pokemonRAM pokeSprites(.Clk(Clk),.palette_idx(palette_idx),.read_address(poke_sprite_addr));

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

  logic done_select;
//logic is_background_t;

  always_ff @ (posedge Clk)
  begin
    if(Reset)
      State <= Start;
    else
      State <= Next_state;
  end

  always_comb
  begin
    Next_state = State;
	 is_background = 1'b1;
	 poke_sprite_addr = 19'b0;
    done_select = 1'b0; //TEMPORARY

    unique case(State)
      Start:
        //and with 0 to stay in start for now...
        if(keycode && done_select && 1'b0) // Press any key to continue after selecting team
          Next_state = Roam;
      Roam:
        //if()
          Next_state = Player_1;
      Player_1:
        //if()
          Next_state = Player_2;
//        else
//          Next_state = End;
      Player_2:
//        if()
          Next_state = Player_1;
//        else
//          Next_state = Roam;
      End:
        if(keycode)
          Next_state = Start;
    endcase

    case(State)
      Start: begin
if(DrawX >= poke0_x && DrawX < (poke0_x + width) && DrawY >= poke0_y && DrawY < (poke0_y + height))begin
poke_sprite_addr =(width) + (DrawX - poke0_x) + (total_width* (DrawY - poke0_y));
          is_background = 1'b0;
        end
        else if(DrawX >= poke1_x && DrawX < (poke1_x + width) && DrawY >= poke1_y && DrawY < (poke1_y + height))begin
          poke_sprite_addr = (3*width) + (DrawX - poke1_x) + (total_width* (DrawY - poke1_y));
          is_background = 1'b0;
        end
        else if(DrawX >= poke2_x && DrawX < (poke2_x + width) && DrawY >= poke2_y && DrawY < (poke2_y + height))begin
          poke_sprite_addr = (width) + (DrawX - poke2_x) + (total_width*height) + (total_width* (DrawY - poke2_y));
          is_background = 1'b0;
        end
        else if(DrawX >= poke3_x && DrawX < (poke3_x + width) && DrawY >= poke3_y && DrawY < (poke3_y + height))begin
          poke_sprite_addr = (3*width) + (DrawX - poke3_x) + (total_width*height) + (total_width* (DrawY - poke3_y));
          is_background = 1'b0;
        end
        else if(DrawX >= poke4_x && DrawX < (poke4_x + width) && DrawY >= poke4_y && DrawY < (poke4_y + height))begin
          poke_sprite_addr = (width) + (DrawX - poke4_x) + (total_width*height*2) + (total_width* (DrawY - poke4_y));
          is_background = 1'b0;
        end
        else if(DrawX >= poke5_x && DrawX < (poke5_x + width) && DrawY >= poke5_y && DrawY < (poke5_y + height))begin
          poke_sprite_addr = (3*width) + (DrawX - poke5_x) + (total_width*height*2) + (total_width* (DrawY - poke5_y));
          is_background = 1'b0;
        end
        else if(DrawX >= poke6_x && DrawX < (poke6_x + width) && DrawY >= poke6_y && DrawY < (poke6_y + height))begin
          poke_sprite_addr = (width) + (DrawX - poke6_x) + (total_width*height*3) + (total_width* (DrawY - poke6_y));
          is_background = 1'b0;
        end
        else if(DrawX >= poke7_x && DrawX < (poke7_x + width) && DrawY >= poke7_y && DrawY < (poke7_y + height))begin
          poke_sprite_addr = (3*width) + (DrawX - poke7_x) + (total_width*height*3) + (total_width* (DrawY - poke7_y));
          is_background = 1'b0;
        end
      end
      Roam: ;
      Player_1: ;
      Player_2: ;
      End: ;
    endcase
  end

endmodule
