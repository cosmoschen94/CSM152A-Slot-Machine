`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:22:23 11/22/2016 
// Design Name: 
// Module Name:    calculate_result 
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
module calculate_result(
    input [2:0] card_1,
    input [2:0] card_2,
    input [2:0] card_3,
    output reg [2:0] multiplier
    );
	 
	 always@(*)
	 begin
		// if there is no same cards
		if((card_1 != card_2) && (card_1 != card_3) && (card_2 != card_3))
		begin
			multiplier <= 0;
		end
		
		// if we have two same cards
		if((card_1 == card_2) ||
			(card_2 == card_3) ||
			(card_3 == card_1))
		begin
			multiplier <= 1;
		end
		
		// if we have three same cards
		if((card_1 == card_2) && (card_2 == card_3))
		begin
			multiplier <= 2;
			// if cards are 7 then it is a jackpot
			if (card_1 == 3'b111)
			begin
				multiplier <= 3;
			end
		end
	 end

endmodule
