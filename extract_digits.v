`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:38:40 11/10/2016 
// Design Name: 
// Module Name:    extract_digits 
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
module extract_digits(
    input [10:0] number, // signed magnitude
    output [3:0] digit_1,
    output [3:0] digit_2,
    output [3:0] digit_3
    );
	 
	 // Registers
	 reg [10:0] temp;
	 reg [3:0] digit_1_reg;
	 reg [3:0] digit_2_reg;
	 reg [3:0] digit_3_reg;
	 
	 always @(*)
	 begin
		temp = number;
		
		digit_1_reg = temp % 10;
		temp = temp / 10;
		digit_2_reg = temp % 10;
		temp = temp / 10;
		digit_3_reg = temp % 10;
	 end
	 
	 assign digit_1 = digit_1_reg;
	 assign digit_2 = digit_2_reg;
	 assign digit_3 = digit_3_reg;

endmodule
