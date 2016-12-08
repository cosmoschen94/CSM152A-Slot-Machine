`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:41:01 11/10/2016 
// Design Name: 
// Module Name:    segSignDisplay 
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
module segSignDisplay(
    input sign,
    output reg [7:0] segment
    );
	 
	 always @(*) begin
		if(sign) // negative
		begin
			segment <= 8'b10111111;
		end
		else
		begin
			segment <= 8'b11111111;
		end
	 end
endmodule
