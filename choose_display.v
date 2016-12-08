`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:15:35 11/23/2016 
// Design Name: 
// Module Name:    choose_display 
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
module choose_display(
	 input gameClk,
    input status_btn,
    input [10:0] current_money_invested,
    input [10:0] current_balance,
    output reg [10:0] number_to_display
    );
	 
	 always @(posedge gameClk)
	 begin
		if(status_btn)
		begin
			number_to_display <= current_balance - current_money_invested;
		end
		else
		begin
			number_to_display <= current_balance;
		end
	 end
	 
endmodule
