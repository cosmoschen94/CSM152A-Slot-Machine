`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:42:03 10/25/2016 
// Design Name: 
// Module Name:    segDisplay 
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


module segDisplay(
	input wire [3:0] number,
	output wire [7:0] segment
    );

reg[7:0] segment_reg;

always @ (*) begin
	segment_reg[7] = 1'b1; 
	segment_reg[6] = (number[3] & number[2]) | 
						  (number[3] & number[1]) | 
						  (number[2] & number[1] & number[0]) |
						  (~number[3] & (~number[2]) & (~number[1]));
	segment_reg[5] = (number[3] & number[2]) | 
						  (number[1] & number[0]) |
						  (~number[2] & number[1]) |
						  (~number[3] & (~number[2]) & number[0]);
	segment_reg[4] = number[0] |
						 (number[3] & number[1]) |
						 (number[2] & ~number[1]);
	segment_reg[3] = (number[3] & number[2]) | 
						  (number[3] & number[1]) | 
						  (number[2] & number[1] & number[0]) |
						  (number[2] & (~number[1]) & (~number[0])) |
						  (~number[3] & (~number[2]) & (~number[1]) & number[0]);
	segment_reg[2] = (number[3] & number[2]) | 
						  (number[3] & number[1]) | 
						  (~number[2] & number[1] & ~number[0]);
	segment_reg[1] = (number[3] & number[2]) | 
						  (number[3] & number[1]) |
						  (number[2] & number[1] & ~number[0]) |
						  (number[2] & (~number[1]) & number[0]);
	segment_reg[0] = (number[3] & number[2]) | 
						  (number[3] & number[1]) |
						  (number[2] & (~number[1]) & ~number[0]) |
						  (~number[3] & (~number[2]) & (~number[1]) & number[0]);

end
assign segment = segment_reg;

endmodule