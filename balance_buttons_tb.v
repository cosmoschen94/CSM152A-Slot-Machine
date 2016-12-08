`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:14:16 11/08/2016
// Design Name:   balance_buttons
// Module Name:   C:/Users/152/Desktop/lab4/balance_buttons_tb.v
// Project Name:  lab4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: balance_buttons
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module balance_buttons_tb;

	// Inputs
	reg cash_out_btn;
	reg add_btn;
	reg gamble_btn;
	reg status_btn;
	reg buffer_5;
	reg buffer_10;
	reg buffer_20;
	reg [10:0] initial_money_invested;
	reg [10:0] initial_balance;

	// Outputs
	wire [10:0] final_money_invested;
	wire [10:0] final_balance;
	wire run_game;

	// Instantiate the Unit Under Test (UUT)
	balance_buttons uut (
		.cash_out_btn(cash_out_btn), 
		.add_btn(add_btn), 
		.gamble_btn(gamble_btn), 
		.status_btn(status_btn), 
		.buffer_5(buffer_5), 
		.buffer_10(buffer_10), 
		.buffer_20(buffer_20), 
		.initial_money_invested(initial_money_invested), 
		.initial_balance(initial_balance), 
		.final_money_invested(final_money_invested), 
		.final_balance(final_balance), 
		.run_game(run_game)
	);

	initial begin
		// Initialize Inputs
		cash_out_btn = 0;
		add_btn = 0;
		gamble_btn = 0;
		status_btn = 0;
		buffer_5 = 0;
		buffer_10 = 0;
		buffer_20 = 0;
		initial_money_invested = 0;
		initial_balance = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		buffer_5 = 1;
		add_btn = 1;
		#100;
		
		buffer_10 = 1;
		gamble_btn = 1;
		#100;

	end
      
endmodule

