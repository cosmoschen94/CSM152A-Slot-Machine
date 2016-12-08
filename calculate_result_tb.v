`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:35:40 11/23/2016
// Design Name:   calculate_result
// Module Name:   C:/Users/152/Desktop/lab4_session3/calculate_result_tb.v
// Project Name:  lab4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: calculate_result
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module calculate_result_tb;

	// Inputs
	reg [2:0] card_1;
	reg [2:0] card_2;
	reg [2:0] card_3;

	// Outputs
	wire [2:0] multiplier;

	// Instantiate the Unit Under Test (UUT)
	calculate_result uut (
		.card_1(card_1), 
		.card_2(card_2), 
		.card_3(card_3), 
		.multiplier(multiplier)
	);

	initial begin
		// Initialize Inputs
		card_1 = 0;
		card_2 = 0;
		card_3 = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

