`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:17:47 10/13/2016
// Design Name:   twoc_to_sm
// Module Name:   C:/Users/152/Desktop/lab2/twoc_to_sm_tb.v
// Project Name:  lab2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: twoc_to_sm
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module twoc_to_sm_tb;

	// Inputs
	reg [10:0] T;

	// Outputs
	wire [10:0] SM;
	wire signbit;

	// Instantiate the Unit Under Test (UUT)
	twoc_to_sm uut (
		.T(T), 
		.SM(SM),
		.signbit(signbit)
	);

	initial begin
		// Initialize Inputs
		T = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		T = 11'b00000000000;
		#100;
		$display ("S is %12b", SM);
		
		T = 11'b11111111111;
		#100;
		$display ("S is %12b", SM);
		
		T = 11'b10000000000;
		#100;
		$display ("S is %12b", SM);
	end
      
endmodule

