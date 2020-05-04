module AI(input logic Clk,
          input logic Reset,
          input logic CPU_turn,
          input logic [11:0][7:0] player,
          input logic [7:0] player_hp,
          input logic [7:0] player_max_hp,
          input logic [11:0][7:0] CPU,
          input logic [7:0] CPU_hp,
          input logic [7:0] CPU_max_hp,
          input logic [4:0][7:0] move_data,
          input logic [7:0] damage,
          output logic [1:0] move,
          output logic CPU_done
          );

  enum logic [5:0] {Begin, Load_1, Move_1, Load_2, Move_2, Load_3, Move_3, Load_4, Move_4, Done} Next_state, State;

  logic [7:0] CPU_hp_per, player_hp_per;

  logic [1:0] best_move, best_move_in;
  logic [7:0] best_damage, best_damage_in;
  logic [7:0] best_accuracy, best_accuracy_in;

  logic [1:0] move_in;

  logic done_1, done_2, done_3, done_4;
  logic done_1_in, done_2_in, done_3_in, done_4_in;

  always_ff @ (posedge Clk)
  begin
    if(Reset)
    begin
      State <= Begin;
      move <= 2'b0;
    end
    else
  	 begin
      State <= Next_state;
      move <= move_in;
  		best_move <= best_move_in;
  		best_damage <= best_damage_in;
  		best_accuracy <= best_accuracy_in;
  		done_1 <= done_1_in;
  		done_2 <= done_2_in;
  		done_3 <= done_3_in;
  		done_4 <= done_4_in;
  	end
  end

  always_comb
  begin
    Next_state = State;
    CPU_done = 1'b0;

    CPU_hp_per = (CPU_hp * 100) / CPU_max_hp;
    player_hp_per = (player_hp * 100) / player_max_hp;

    move_in = move;

	 best_move_in = best_move;
	 best_damage_in = best_damage;
	 best_accuracy_in = best_accuracy;

	 done_1_in = done_1;
	 done_2_in = done_2;
	 done_3_in = done_3;
	 done_4_in = done_4;

    unique case(State)
      Begin:
        if(CPU_turn)
          Next_state = Load_1;
		Load_1:
			Next_state = Move_1;
      Move_1:
			if(done_1)
			  Next_state = Load_2;
		Load_2:
			Next_state = Move_2;
      Move_2:
			if(done_2)
			  Next_state = Load_3;
		Load_3:
			Next_state = Move_3;
      Move_3:
			if(done_3)
			  Next_state = Load_4;
		Load_4:
			Next_state = Move_4;
      Move_4:
			if(done_4)
			  Next_state = Done;
      Done:
        Next_state = Begin;
    endcase

    case(State)
      Begin:
      begin
  		  done_1_in = 1'b0;
  		  done_2_in = 1'b0;
  		  done_3_in = 1'b0;
  		  done_4_in = 1'b0;
      end
      Load_1:
        move_in = 2'b0;
  		Move_1:
  		begin
  			 best_move_in = move;
  			 best_damage_in = damage;
  			 best_accuracy_in = move_data[1];
  			 done_1_in = 1'b1;
  		end
      Load_2:
        move_in = 2'b01;
  		Move_2:
  		begin
  			 if(player_hp_per < 20 || CPU_hp_per < 20)
  			 begin
  				if(move_data[1] >= best_accuracy && damage > best_damage)
  				begin
  				  best_move_in = move;
  				  best_damage_in = damage;
  				  best_accuracy_in = move_data[1];
  				end
  			 end
  			 else if(CPU_hp_per >= 90)
  			 begin
  				if(damage > best_damage)
  				begin
  				  best_move_in = move;
  				  best_damage_in = damage;
  				  best_accuracy_in = move_data[1];
  				end
  			 end
  			 else if(((damage*move_data[1]) / 100) > ((best_damage*best_accuracy) / 100))
  				begin
  				  best_move_in = move;
  				  best_damage_in = damage;
  				  best_accuracy_in = move_data[1];
  				end
  			 done_2_in = 1'b1;
  		end
      Load_3:
        move_in = 2'b10;
  		Move_3:
  		begin
  			 if(player_hp_per < 20 || CPU_hp_per < 20)
  			 begin
  				if(move_data[1] >= best_accuracy && damage > best_damage)
  				begin
  				  best_move_in = move;
  				  best_damage_in = damage;
  				  best_accuracy_in = move_data[1];
  				end
  			 end
  			 else if(CPU_hp_per >= 90)
  			 begin
  				if(damage > best_damage)
  				begin
  				  best_move_in = move;
  				  best_damage_in = damage;
  				  best_accuracy_in = move_data[1];
  				end
  			 end
  			 else if(((damage*move_data[1]) / 100) > ((best_damage*best_accuracy) / 100))
  				begin
  				  best_move_in = move;
  				  best_damage_in = damage;
  				  best_accuracy_in = move_data[1];
  				end
  			 done_3_in = 1'b1;
  		end
      Load_4:
        move_in = 2'b11;
  		Move_4:
  		begin
  			 if(player_hp_per < 20 || CPU_hp_per < 20)
  			 begin
  				if(move_data[1] >= best_accuracy && damage > best_damage)
  				begin
  				  best_move_in = move;
  				  best_damage_in = damage;
  				  best_accuracy_in = move_data[1];
  				end
  			 end
  			 else if(CPU_hp_per >= 90)
  			 begin
  				if(damage > best_damage)
  				begin
  				  best_move_in = move;
  				  best_damage_in = damage;
  				  best_accuracy_in = move_data[1];
  				end
  			 end
  			 else if(((damage*move_data[1]) / 100) > ((best_damage*best_accuracy) / 100))
  				begin
  				  best_move_in = move;
  				  best_damage_in = damage;
  				  best_accuracy_in = move_data[1];
  				end
  			 done_4_in = 1'b1;
  		end
      Done:
  		begin
        move_in = best_move;
        CPU_done = 1'b1;
  		end
    endcase
  end

endmodule
