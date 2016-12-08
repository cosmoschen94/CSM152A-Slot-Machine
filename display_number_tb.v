`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:37:22 11/15/2016
// Design Name:   display_number
// Module Name:   C:/Users/152/Desktop/lab4_session2/display_number_tb.v
// Project Name:  lab4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: display_number
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module display_number_tb;

	// Inputs
	//reg clk;
	reg [10:0] number;

	// Outputs
	wire [3:0] n_cnt;
	wire [7:0] seg;

	// Instantiate the Unit Under Test (UUT)
	display_number uut (
		.number(number), 
		.n_cnt(n_cnt), 
		.seg(seg)
	);

	initial begin
		// Initialize Inputs
		number = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		
	end
      
endmodule

