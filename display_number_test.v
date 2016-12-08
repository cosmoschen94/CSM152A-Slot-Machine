`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:14:10 11/15/2016 
// Design Name: 
// Module Name:    display_number_test 
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
module display_number_test(
    input clk,
	 input [7:0] sw
    );
	 
	 reg [10:0] number;
	 
	 display_number uut (
		.clk(clk),
		.number(number), 
		.n_cnt(n_cnt), 
		.seg(seg)
	);
	
	always@(*) begin
		if(sw[5])
		begin
			number = 11'b01111100111;
		end
		if(sw[6])
		begin
			number = 11'b00111100111;
		end
		if(sw[7])
		begin
		   number = 11'b01011100111;
		end
		number = 0;
	end
	


endmodule
