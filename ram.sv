/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */

module pokemonRAM
(		input Clk,
		input [18:0] read_address,
		output logic [5:0] palette_idx
);

// mem has width of 6 bits and a total of 50176 addresses
// pokemon sprite sheet is 224 x 224, each pokemon is 56 x 56 (front and back sprites) = 8 pokemon
logic [5:0] mem [0:50175];

initial
begin
	 $readmemh("pokemon.txt", mem);
end


always_ff @ (posedge Clk) begin
	palette_idx<= mem[read_address];
end

endmodule

module elitesRAM
(		input Clk,
		input [18:0] read_address,
		output logic [5:0] palette_idx
);

logic [5:0] mem [0:1119];

initial
begin
	 $readmemh("elites.txt", mem);
end


always_ff @ (posedge Clk) begin
	palette_idx<= mem[read_address];
end

endmodule

module trainerRAM
(		input Clk,
		input [18:0] read_address,
		output logic [5:0] palette_idx
);

logic [5:0] mem [0:895];

initial
begin
	 $readmemh("trainer.txt", mem);
end


always_ff @ (posedge Clk) begin
	palette_idx<= mem[read_address];
end

endmodule

module mapRAM
(		input Clk,
		input [18:0] read_address,
		output logic [5:0] palette_idx
);

logic [5:0] mem [0:13727];

initial
begin
	 $readmemh("gym.txt", mem);
end


always_ff @ (posedge Clk) begin
	palette_idx<= mem[read_address];
end

endmodule
