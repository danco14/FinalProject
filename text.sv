module poke_names(input logic [9:0] DrawX, DrawY,
                  input logic [9:0] start_x, input logic [9:0] start_y,
                  input logic [2:0] poke_id,
                  output logic [2:0] bit_num,
                  output logic [7:0] sname_hex,
                  output logic is_sname);

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
  logic [2:0] letter_num;
  always_comb begin
    if(DrawY>= start_y && DrawY < (start_y + height))begin
        if(DrawX>=start_x && DrawX < (start_x + width))begin
          is_sname = 1'b1;
          bit_num = DrawX - start_x;
          sname_hex = pokemon_names[poke_id][0];
        end
        else if(DrawX>=start_x && DrawX < start_x + (width*(2)))begin
          is_sname = 1'b1;
          bit_num = DrawX - (start_x + (width*(1)));
          sname_hex = pokemon_names[poke_id][1];
        end
        else if(DrawX>=start_x && DrawX < start_x + (width*(3)))begin
          is_sname = 1'b1;
          bit_num = DrawX - (start_x + (width*(2)));
          sname_hex = pokemon_names[poke_id][2];
        end
        else if(DrawX>=start_x && DrawX < start_x + (width*(4)))begin
          is_sname = 1'b1;
          bit_num = DrawX - (start_x + (width*(3)));
          sname_hex = pokemon_names[poke_id][3];
        end
        else if(DrawX>=start_x && DrawX < start_x + (width*(5)))begin
          is_sname = 1'b1;
          bit_num = DrawX - (start_x + (width*(4)));
          sname_hex = pokemon_names[poke_id][4];
        end
        else if(DrawX>=start_x && DrawX < start_x + (width*(6)))begin
          is_sname = 1'b1;
          bit_num = DrawX - (start_x + (width*(5)));
          sname_hex = pokemon_names[poke_id][5];
        end
        else if(DrawX>=start_x && DrawX < start_x + (width*(7)))begin
          is_sname = 1'b1;
          bit_num = DrawX - (start_x + (width*(6)));
          sname_hex = pokemon_names[poke_id][6];
        end
        else if(DrawX>=start_x && DrawX < start_x + (width*(8)))begin
          is_sname = 1'b1;
          bit_num = DrawX - (start_x + (width*(7)));
          sname_hex = pokemon_names[poke_id][7];
        end
        else if(DrawX>=start_x && DrawX < start_x + (width*(9)))begin
          is_sname = 1'b1;
          bit_num = DrawX - (start_x + (width*(8)));
          sname_hex = pokemon_names[poke_id][8];
        end
   else begin
      is_sname = 1'b0;
      bit_num = 3'b0;
      sname_hex = 8'h20;
   end

    end
  else begin
      is_sname = 1'b0;
      bit_num = 3'b0;
      sname_hex = 8'h20;
  end
  end

endmodule
