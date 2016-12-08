`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:25:20 11/23/2016
// Design Name:   choose_display
// Module Name:   C:/Users/152/Desktop/lab4_session3/choose_display_tb.v
// Project Name:  lab4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: choose_display
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module choose_display_tb;

	// Inputs
	reg gameClk;
	reg status_btn;
	reg [10:0] current_money_invested;
	reg [10:0] current_balance;

	// Outputs
	wire [10:0] number_to_display;

	// Instantiate the Unit Under Test (UUT)
	choose_display uut (
		.gameClk(gameClk), 
		.status_btn(status_btn), 
		.current_money_invested(current_money_invested), 
		.current_balance(current_balance), 
		.number_to_display(number_to_display)
	);

	initial begin
		// Initialize Inputs
		gameClk = 0;
		status_btn = 0;
		current_money_invested = 0;
		current_balance = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		gameClk = 1;
		status_btn = 1;
		current_money_invested = 20;
		current_balance = -25;
	end
      
endmodule

