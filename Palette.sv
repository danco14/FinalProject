module color_palette(        // Whether current pixel belongs to background (computed in game_state.sv)
                     input is_chooser,
                     input is_start,
							       input is_sprite,
                     input is_battle,
                     input is_roam,
                     input [9:0] DrawX,
                     input [9:0] DrawY,
                     input [2:0] cur_choice_id,
                     input [5:0] sb_palette,
                     input [5:0] roam_palette,
                     input logic [2:0] bit_num_batinfo,
                     input logic [7:0] info_hex,
                     input logic [9:0] y_diff_batinfo,
                     input logic is_battleinfo_font,
                     input logic [7:0] hp_r,
                     input logic [7:0] hp_g,
                     input logic [7:0] hp_b,
                     input logic is_battleinfo_bar,
                     output logic [7:0] VGA_R, VGA_G, VGA_B);

   logic [7:0] Red, Green, Blue;
   logic [5:0] palette_idx;
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
      if(is_roam)begin
        palette_idx = roam_palette;
      end
      else begin
        palette_idx = sb_palette;
      end
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
       else if (is_sprite == 1'b1 && (is_start || is_battle || is_roam))
       begin
         case(palette_idx)
            6'd1: begin
              Red = 8'h00;
              Green = 8'h00;
              Blue = 8'h00;
            end
            6'd2: begin
              Red = 8'hff;
              Green = 8'hff;
              Blue = 8'hff;
            end
            6'd3: begin
              Red = 8'hd6;
              Green = 8'h31;
              Blue = 8'h00;
            end
            6'd4: begin
              Red = 8'hff;
              Green = 8'h29;
              Blue = 8'h10;
            end
            6'd5: begin
              Red = 8'hff;
              Green = 8'h5a;
              Blue = 8'h00;
            end
            6'd6: begin
              Red = 8'hc5;
              Green = 8'h8c;
              Blue = 8'h21;
            end
            6'd7: begin
              Red = 8'hc5;
              Green = 8'ha5;
              Blue = 8'h19;
            end
            6'd8: begin
              Red = 8'hef;
              Green = 8'hd6;
              Blue = 8'h29;
            end
            6'd9: begin
              Red = 8'h42;
              Green = 8'hce;
              Blue = 8'h5a;
            end
            6'd10: begin
              Red = 8'h31;
              Green = 8'h4a;
              Blue = 8'h7b;
            end
            6'd11: begin
              Red = 8'h3a;
              Green = 8'h5a;
              Blue = 8'hd6;
            end
            6'd12: begin
              Red = 8'h42;
              Green = 8'h5a;
              Blue = 8'hff;
            end
            6'd13: begin
              Red = 8'h5a;
              Green = 8'h52;
              Blue = 8'h8c;
            end
            6'd14: begin
              Red = 8'h5a;
              Green = 8'h29;
              Blue = 8'h73;
            end
            6'd15: begin
              Red = 8'h4a;
              Green = 8'h00;
              Blue = 8'h84;
            end
            6'd16: begin
              Red = 8'hce;
              Green = 8'h52;
              Blue = 8'hce;
            end
            6'd17: begin
              Red = 8'hff;
              Green = 8'h7b;
              Blue = 8'hff;
            end
            6'd18: begin
              Red = 8'hef;
              Green = 8'h3a;
              Blue = 8'h73;
            end
            6'd19: begin
              Red = 8'h6c;
              Green = 8'h13;
              Blue = 8'h01;
            end
            6'd20: begin
              Red = 8'h7b;
              Green = 8'h17;
              Blue = 8'h02;
            end
            6'd21: begin
              Red = 8'ha3;
              Green = 8'h21;
              Blue = 8'h03;
            end
            6'd22: begin
              Red = 8'hd7;
              Green = 8'h2f;
              Blue = 8'h06;
            end
            6'd23: begin
              Red = 8'hdc;
              Green = 8'h31;
              Blue = 8'h06;
            end
            6'd24: begin
              Red = 8'hea;
              Green = 8'h34;
              Blue = 8'h07;
            end
            6'd25: begin
              Red = 8'hf8;
              Green = 8'h38;
              Blue = 8'h08;
            end
            6'd26: begin
              Red = 8'hf7;
              Green = 8'h97;
              Blue = 8'h50;
            end
            6'd27: begin
              Red = 8'hf8;
              Green = 8'h98;
              Blue = 8'h50;
            end
            6'd28: begin
              Red = 8'h38;
              Green = 8'hb8;
              Blue = 8'h18;
            end
            6'd29: begin
              Red = 8'h50;
              Green = 8'h48;
              Blue = 8'hf8;
            end
            6'd30: begin
              Red = 8'he9;
              Green = 8'he9;
              Blue = 8'hf0;
            end
            6'd31: begin
              Red = 8'h79;
              Green = 8'h79;
              Blue = 8'h79;
            end
            6'd32: begin
              Red = 8'hd9;
              Green = 8'hd9;
              Blue = 8'hd9;
            end
            6'd33: begin
              Red = 8'ha1;
              Green = 8'ha1;
              Blue = 8'haa;
            end
            6'd34: begin
              Red = 8'hc9;
              Green = 8'hc9;
              Blue = 8'hd1;
            end
            6'd35: begin
              Red = 8'ha1;
              Green = 8'h4f;
              Blue = 8'h3e;
            end
            6'd36: begin
              Red = 8'hc1;
              Green = 8'h71;
              Blue = 8'h46;
            end
            6'd37: begin
              Red = 8'hf8;
              Green = 8'h46;
              Blue = 8'h00;
            end
            6'd38: begin
              Red = 8'he1;
              Green = 8'ha1;
              Blue = 8'h60;
            end
            6'd39: begin
              Red = 8'he1;
              Green = 8'hb2;
              Blue = 8'h46;
            end
            6'd40: begin
              Red = 8'hf8;
              Green = 8'hd1;
              Blue = 8'h81;
            end
            6'd41: begin
              Red = 8'hb9;
              Green = 8'hb9;
              Blue = 8'h71;
            end
            6'd42: begin
              Red = 8'hf8;
              Green = 8'hf0;
              Blue = 8'h81;
            end
            6'd43: begin
              Red = 8'hf8;
              Green = 8'hf8;
              Blue = 8'hb2;
            end
            6'd44: begin
              Red = 8'h99;
              Green = 8'hc1;
              Blue = 8'hc9;
            end
            6'd45: begin
              Red = 8'ha9;
              Green = 8'hd1;
              Blue = 8'hd0;
            end
            6'd46: begin
              Red = 8'h60;
              Green = 8'h91;
              Blue = 8'hc1;
            end
            6'd47: begin
              Red = 8'h89;
              Green = 8'hc1;
              Blue = 8'he1;
            end
            6'd48: begin
              Red = 8'h81;
              Green = 8'haa;
              Blue = 8'hd9;
            end
            6'd49: begin
              Red = 8'h4f;
              Green = 8'h4f;
              Blue = 8'h68;
            end
            6'd50: begin
              Red = 8'h99;
              Green = 8'h81;
              Blue = 8'hc9;
            end
            6'd51: begin
              Red = 8'hb1;
              Green = 8'h99;
              Blue = 8'hd9;
            end
          default: //never reaches this.. (idx 0)
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
