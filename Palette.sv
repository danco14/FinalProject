module color_palette(        // Whether current pixel belongs to background (computed in game_state.sv)
                     input is_chooser,
                     input is_start,
							       input is_sprite,
                     input is_battle,
                     input [9:0] DrawX,
                     input [9:0] DrawY,
                     input [2:0] cur_choice_id,
                     input [4:0] palette_idx,
                     input logic [2:0] bit_num_batinfo,
                     input logic [7:0] info_hex,
                     input logic [9:0] y_diff_batinfo,
                     input logic is_battleinfo_font,
                     input logic [7:0] hp_r,
                     input logic [7:0] hp_g,
                     input logic [7:0] hp_b,
                     input logic is_battleinfo_bar;
                     output logic [7:0] VGA_R, VGA_G, VGA_B);

   logic [7:0] Red, Green, Blue;

   // Output colors to VGA
   assign VGA_R = Red;
   assign VGA_G = Green;
   assign VGA_B = Blue;

   logic is_pname;
   logic [2:0] bit_num;
   logic [7:0] pname_hex;
   logic [10:0] font_addr;
   logic [7:0] font_data;
   logic [9:0] ydiff_start;
   poke_names startscreen_names(.DrawX(DrawX), .DrawY(DrawY), .start_x(250), .start_y(275),
                    .is_pname(is_pname), .poke_id(cur_choice_id), .bit_num(bit_num), .pname_hex(pname_hex), .y_diff(ydiff_start));
   font_rom f_rom(.addr(font_addr),.data(font_data));

   always_comb
   begin
	     font_addr = 11'b0;
       if (is_start && is_chooser == 1'b1)
       begin
           // black box for choosing pokemon
           Red = 8'h00;
           Green = 8'h00;
           Blue = 8'h00;
       end
       else if (is_start && is_pname == 1'b1)
       begin
         font_addr = (ydiff_start) + 16*pname_hex;
         if(font_data[7-bit_num]==1'b1) begin
           Red = 8'h00;
           Green = 8'h00;
           Blue = 8'h00;
         end
  			else begin
  				Red = 8'hff;
          Green = 8'hff;
          Blue = 8'hff;
  			end
       end
       else if(is_battleinfo_font && is_battle)begin
         font_addr = (y_diff_batinfo) + 16*info_hex;
         if(font_data[7-bit_num_batinfo]==1'b1) begin
           Red = 8'h00;
           Green = 8'h00;
           Blue = 8'h00;
         end
  			 else begin
  				Red = 8'hff;
          Green = 8'hff;
          Blue = 8'hff;
  			end
       end
       else if(is_battleinfo_bar && is_battle)begin
         Red = hp_r;
         Green = hp_g;
         Blue = hp_b;
       end
       else if (is_sprite == 1'b1 && (is_start || is_battle))
       begin
         case(palette_idx)
            5'd1: begin
              Red = 8'h00;
              Green = 8'h00;
              Blue = 8'h00;
            end
            5'd2: begin
              Red = 8'hff;
              Green = 8'hff;
              Blue = 8'hff;
            end
            5'd3: begin
              Red = 8'hd6;
              Green = 8'h31;
              Blue = 8'h00;
            end
            5'd4: begin
              Red = 8'hff;
              Green = 8'h29;
              Blue = 8'h10;
            end
            5'd5: begin
              Red = 8'hff;
              Green = 8'h5a;
              Blue = 8'h00;
            end
            5'd6: begin
              Red = 8'hc5;
              Green = 8'h8c;
              Blue = 8'h21;
            end
            5'd7: begin
              Red = 8'hc5;
              Green = 8'ha5;
              Blue = 8'h19;
            end
            5'd8: begin
              Red = 8'hef;
              Green = 8'hd6;
              Blue = 8'h29;
            end
            5'd9: begin
              Red = 8'h42;
              Green = 8'hce;
              Blue = 8'h5a;
            end
            5'd10: begin
              Red = 8'h31;
              Green = 8'h4a;
              Blue = 8'h7b;
            end
            5'd11: begin
              Red = 8'h3a;
              Green = 8'h5a;
              Blue = 8'hd6;
            end
            5'd12: begin
              Red = 8'h42;
              Green = 8'h5a;
              Blue = 8'hff;
            end
            5'd13: begin
              Red = 8'h5a;
              Green = 8'h52;
              Blue = 8'h8c;
            end
            5'd14: begin
              Red = 8'h5a;
              Green = 8'h29;
              Blue = 8'h73;
            end
            5'd15: begin
              Red = 8'h4a;
              Green = 8'h00;
              Blue = 8'h84;
            end
            5'd16: begin
              Red = 8'hce;
              Green = 8'h52;
              Blue = 8'hce;
            end
            5'd17: begin
              Red = 8'hff;
              Green = 8'h7b;
              Blue = 8'hff;
            end
            5'd18: begin
              Red = 8'hef;
              Green = 8'h3a;
              Blue = 8'h73;
            end
          default:
            begin
              Red = 8'hff;
              Green = 8'hff;
              Blue = 8'hff;
            end
          endcase
       end
       else  //draw white background
       begin
        Red = 8'hff;
        Green = 8'hff;
        Blue = 8'hff;
       end
   end
endmodule
