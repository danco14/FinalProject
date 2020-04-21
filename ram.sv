/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */

module pokemonRAM
(		input Clk,
		input [18:0] read_address,
		output logic [4:0] palette_idx
);

// mem has width of 5 bits and a total of 50176 addresses
// pokemon sprite sheet is 224 x 224, each pokemon is 56 x 56 (front and back sprites) = 8 pokemon
logic [4:0] mem [0:50175];

initial
begin
	 $readmemh("pokemon.txt", mem);
end


always_ff @ (posedge Clk) begin
	palette_idx<= mem[read_address];
end

endmodule
