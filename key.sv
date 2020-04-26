module key_press(input logic Clk, input logic Reset, input logic [7:0] keycode, output logic [7:0] key);

	enum logic [5:0] {Unpressed, Pressed} Next_state, State;
	
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
				if(keycode)
					Next_state = Pressed;
			Pressed:
				if(keycode == 8'b0)
					Next_state = Unpressed;
		endcase
					
		case(State)
			Unpressed:
				key = keycode;
			Pressed:
				key = 8'b0;
		endcase
	end

endmodule