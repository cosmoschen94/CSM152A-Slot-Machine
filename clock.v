`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    10:42:00 10/25/2016
// Design Name:
// Module Name:    clock
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

module clock(
	input wire clk,
	input wire rst,
	output wire hzSegClk,
	output wire gameClk,
	output wire clk1hz,
	output wire pix_en,
	output wire changeClk
    );
	 
	reg hzSegClkReg;
	reg gameClkReg;
	reg clk1hzReg;
	reg changeClkReg;

	reg [31:0] cnt_seg;
	reg [31:0] cnt_game;
	reg [31:0] cnt_1hz;
	reg [31:0] cnt_change;
	reg [1:0] q;
	
	//Divider for 1hz clock

	always @ (posedge clk)
	begin
		if(cnt_1hz == 5000000)
		begin
			cnt_1hz <= 32'b0;
			clk1hzReg <= ~clk1hz;
		end
		else
		begin
			cnt_1hz <= cnt_1hz + 32'b1;
			clk1hzReg <= clk1hz;
		end
	end
	
	//Divider for gameClk clock

	always @ (posedge clk)
	begin
		if(cnt_game == 50000)
		begin
			cnt_game <= 32'b0;
			gameClkReg <= ~gameClk;
		end
		else
		begin
			cnt_game <= cnt_game + 32'b1;
			gameClkReg <= gameClk;
		end
	end


	//Divider for change clock

	always @ (posedge clk)
	begin
		if(cnt_change == 100000)
		begin
			cnt_change <= 32'b0;
			changeClkReg <= ~changeClk;
		end
		else
		begin
			cnt_change <= cnt_change + 32'b1;
			changeClkReg <= changeClk;
		end
	end
	
	//Divider for segment clock

	always @ (posedge clk)
	begin
		if(cnt_seg == 50000)
		begin
			cnt_seg <= 32'b0;
			hzSegClkReg <= ~hzSegClk;
		end
		else
		begin
			cnt_seg <= cnt_seg + 32'b1;
			hzSegClkReg <= hzSegClk;
		end
	end


	// Clock divider
	always @(posedge clk)
	begin
		// reset condition
		if (rst == 1)
			q <= 0;
		// increment counter by one
		else
			q <= q+1;
	end

	assign changeClk = changeClkReg;
	assign clk1hz = clk1hzReg;
	assign gameClk = gameClkReg;
	assign hzSegClk = hzSegClkReg;
	assign pix_en = ~q[1] & ~q[0];

endmodule
