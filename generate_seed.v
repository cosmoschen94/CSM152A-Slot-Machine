`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:36:49 11/28/2016 
// Design Name: 
// Module Name:    generate_seed 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module generate_seed(
    input clk,
	 input [2:0] initial_seed,
	 input run_game,
    output [2:0] seed
    );
	 
	 reg [2:0] counter;
	 reg [2:0] seed_reg;
	 
	 initial
	 begin
		counter <= initial_seed;
		seed_reg <= initial_seed;
	 end
	 
	 always @(posedge clk)
	 begin
		counter = counter + initial_seed;
		if(run_game == 1)
			seed_reg = counter;
	 end
	 assign seed = seed_reg;
	
endmodule
