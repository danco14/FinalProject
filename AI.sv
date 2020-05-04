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

  enum logic [3:0] {Begin, Move_1, Move_2, Move_3, Move_4} Next_state, State;

  logic [7:0] CPU_hp_per, player_hp_per;

  logic [1:0] best_move;
  logic [7:0] best_damage;
  logic [7:0] best_accuracy;

  logic [1:0] move_in;

  always_ff @ (posedge Clk)
  begin
    if(Reset)
      State <= Begin;
      move <= 2'b0;
    else
      State <= Next_state;
      move <= move_in;
  end

  always_comb
  begin
    Next_state = State;
    CPU_done = 1'b0;

    CPU_hp_per = (CPU_hp * 100) / CPU_max_hp;
    player_hp_per = (player_hp * 100) / player_max_hp;

    move_in = move;

    unique case(State)
      Begin:
        if(CPU_turn)
          Next_state = Move_1;
      Move_1:
        Next_state = Move_2;
      Move_2:
        Next_state = Move_3;
      Move_3:
        Next_state = Move_4;
      Move_4:
        Next_state = Done;
      Done:
        Next_state = Begin;
    endcase

    if(player_hp_per < 20 || CPU_hp_per < 20)
    begin
      if(damage != 0 && move_data[1] > best_accuracy)
      begin
        best_move = move;
        best_damage = damage;
        best_accuracy = move_data[1];
      end
    end
    else if(CPU_hp_per >= 90)
    begin
      if(damage > best_damage)
      begin
        best_move = move;
        best_damage = damage;
        best_accuracy = move_data[1];
      end
    end
    else
    begin
      if((damage*move_data[1]) > (best_damage*best_accuracy))
      begin
        best_move = move;
        best_damage = damage;
        best_accuracy = move_data[1];
      end
    end

    case(State)
      Begin:
      begin
        best_move = 2'b0;
        best_damage = 8'b0;
        best_accuracy = 8'b0;
      end
      Move_1:
        move_in = 2'b0;
      Move_2:
        move_in = 2'b01;
      Move_3:
        move_in = 2'b10;
      Move_4:
        move_in = 2'b11;
      Done:
        move_in = best_move;
        CPU_done = 1'b1;
    endcase
  end

endmodule
