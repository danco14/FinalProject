module color_palette(input  is_background,            // Whether current pixel belongs to background (computed in game_state.sv)
                     input is_chooser,
                     input [4:0] palette_idx,
                     output logic [7:0] VGA_R, VGA_G, VGA_B);

   logic [7:0] Red, Green, Blue;

   // Output colors to VGA
   assign VGA_R = Red;
   assign VGA_G = Green;
   assign VGA_B = Blue;
   always_comb
   begin
       if (is_choose == 1'b1)
       begin
           // black box for choosing
           Red = 8'h00;
           Green = 8'h00;
           Blue = 8'h00;
       end
       else if (is_background == 1'b1)
       begin
           // White background
           Red = 8'hff;
           Green = 8'hff;
           Blue = 8'hff;
       end
       else
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
   end
endmodule
