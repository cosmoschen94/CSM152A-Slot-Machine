`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    23:37:13 11/14/2016
// Design Name:
// Module Name:    displayNum
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
module displayNum(
	num,
	array
    );
input wire [2:0]num;
output reg [63:0]array;

always @ num
	case(num)
		0:begin
				array = 64'b0000000001111110100000011000000110000001100000011000000101111110;
		  end
		
		1:begin
				array = 64'b0000000001111110000110000001100000011000000110110001111000011100;
			end
		2:begin
				array = 64'b0000000011111111000000010000000111111111100000001000000011111111;
			end
		3:begin
				array = 64'b0000000011111111100000001000000011111111100000001000000011111111;
			end
		4:begin
				array = 64'b0000000010000000100000001000000011111111100000011000000110000001;
			end
		5:begin
				array = 64'b0000000011111111100000001000000011111111000000010000000111111111;
			end
		6:begin
				array = 64'b0000000011111111100000011000000111111111000000010000000111111111;
			end
		7:begin
				array = 64'b0000000010000000100000001000000010000000100000001000000011111111;
			end
	endcase
	
endmodule
