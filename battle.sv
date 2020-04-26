module battle(input logic Clk, input logic Reset, input logic is_battle, output logic result);

  enum [20:0] {Battle_Start, Select_Move, Player_1, Player_2, Win, Lose} Next_state, State;

  calculation calculation();

  logic [3:0] player_hp[3];
  logic [3:0] opponent_hp[3];

  always_ff @ (posedge Clk)
  begin
    if(Reset)
      State <= Battle_Start;
    else
      State <= Next_state;
  end

  always_comb
  begin
    Next_state = State;

    unique case(State)
      Battle_Start:
        if(is_battle)
          Next_state = Select_Move;
      Select_Move:
        if()
          Next_state = Player_1;
        else
          Next_state = Player_2;
      Player_1:
        Next_state = Player_2;
      Player_2:
        Next_state = Player_1;
      Win:
        Next_state = Battle_Start;
      Lose:
        Next_state = Battle_Start;
    endcase

    case(State)
      Battle_Start: ;
      Select_Move: ;

      Player_1: ;

      Player_2: ;

      Win:
      begin
        result = 1'b1;
        is_battle = 1'b0;
      end
      Lose:
      begin
        result = 1'b0;
        is_battle = 1'b0;
      end
    endcase
  end

endmodule
