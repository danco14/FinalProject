module key_press(input logic Clk, input logic Reset, input logic hold, input logic [7:0] keycode, output logic [7:0] key);

	enum logic [5:0] {Unpressed, Pressed, Hold_Down} Next_state, State;
	
	always_ff @ (posedge Clk)
	begin
		if(Reset)
			State <= Unpressed;
		else
			State <= Next_state;
	end
	
	always_comb
	begin
		Next_state = State;
		
		unique case(State)
			Unpressed:
				if(hold)
					Next_state = Hold_Down;
				else if(keycode)
					Next_state = Pressed;
			Pressed:
				if(hold)
					Next_state = Hold_Down;
				else if(keycode == 8'b0)
					Next_state = Unpressed;
			Hold_Down:
				if(hold == 1'b0)
					Next_state = Pressed;
		endcase
					
		case(State)
			Unpressed:
				key = keycode;
			Pressed:
				key = 8'b0;
			Hold_Down:
				key = keycode;
		endcase
	end

endmodule