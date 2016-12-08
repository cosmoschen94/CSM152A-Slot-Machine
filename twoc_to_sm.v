`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:34:44 10/13/2016 
// Design Name: 
// Module Name:    twoc_to_sm 
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
module twoc_to_sm(
    input [10:0] T,
    output [10:0] SM,
	 output signbit
    );
	 
	 // registers
	 reg [10:0] D;
	 reg sign;
	 
	 always @(*)
	 begin
		D = T;
		if (D == 11'b10000000000)
			begin
				D = 11'b01111111111;
			end
		sign = D[10];
		if (sign)
		begin
			D = ~D + 1;
		end
	end
	
	assign SM = D;
	assign signbit = sign;
	
endmodule
