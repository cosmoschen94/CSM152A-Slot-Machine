`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    00:30:38 03/19/2013
// Design Name:
// Module Name:    vga640x480
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
module vga640x480(
	input wire pix_en,		//pixel clock: 25MHz
	input wire clk,			//100MHz
	input wire rst,			//asynchronous reset
	input wire [63:0]array1, //random digit 1
	input wire [63:0]array2, //random digit 2
	input wire [63:0]array3, //random digit 3
	output wire hsync,		//horizontal sync out
	output wire vsync,		//vertical sync out
	output reg [2:0] red,	//red vga output
	output reg [2:0] green, //green vga output
	output reg [1:0] blue	//blue vga output
	);

// video structure constants
parameter hpixels = 800;// horizontal pixels per line
parameter vlines = 521; // vertical lines per frame
parameter hpulse = 96; 	// hsync pulse length
parameter vpulse = 2; 	// vsync pulse length
parameter hbp = 144; 	// end of horizontal back porch
parameter hfp = 784; 	// beginning of horizontal front porch
parameter vbp = 31; 		// end of vertical back porch
parameter vfp = 511; 	// beginning of vertical front porch
// active horizontal video is therefore: 784 - 144 = 640
// active vertical video is therefore: 511 - 31 = 480

// registers for storing the horizontal & vertical counters
reg [9:0] hc;
reg [9:0] vc;

/*
//initialize digit array
reg [63:0]array1;

initial begin
	array1 = 64'b0000000010000000100000001000000010000000100000001000000011111111;
end
*/

// Horizontal & vertical counters --
// this is how we keep track of where we are on the screen.
// ------------------------
// Sequential "always block", which is a block that is
// only triggered on signal transitions or "edges".
// posedge = rising edge  &  negedge = falling edge
// Assignment statements can only be used on type "reg" and need to be of the "non-blocking" type: <=
always @(posedge clk)
begin
	// reset condition
	if (rst == 1)
	begin
		hc <= 0;
		vc <= 0;
	end
	else if (pix_en == 1)
	begin
		// keep counting until the end of the line
		if (hc < hpixels - 1)
			hc <= hc + 1;
		else
		// When we hit the end of the line, reset the horizontal
		// counter and increment the vertical counter.
		// If vertical counter is at the end of the frame, then
		// reset that one too.
		begin
			hc <= 0;
			if (vc < vlines - 1)
				vc <= vc + 1;
			else
				vc <= 0;
		end
		
	end
end


// generate sync pulses (active low)
// ----------------
// "assign" statements are a quick way to
// give values to variables of type: wire
assign hsync = (hc < hpulse) ? 0:1;
assign vsync = (vc < vpulse) ? 0:1;

// display 100% saturation colorbars
// ------------------------
// Combinational "always block", which is a block that is
// triggered when anything in the "sensitivity list" changes.
// The asterisk implies that everything that is capable of triggering the block
// is automatically included in the sensitivty list.  In this case, it would be
// equivalent to the following: always @(hc, vc)
// Assignment statements can only be used on type "reg" and should be of the "blocking" type: =
always @(*)
begin
	// first check if we're within vertical active video range
	if (vc >= vbp && vc < vfp)
	begin
		// now display different colors every 80 pixels
		// while we're within the active horizontal range
		// -----------------
		// display white bar at the top section
		if (hc >= hbp && hc < (hbp+640) && vc >= vbp && vc < (vbp+160))
		begin
			red = 3'b111;
			green = 3'b111;
			blue = 2'b11;
		end

		// display white bar at the bottom section
		else if (hc >= hbp && hc < (hbp+640) && vc >= (vbp+320) && vc < (vbp+480))
		begin
			red = 3'b111;
			green = 3'b111;
			blue = 2'b11;
		end

		// display white bar at the left section
		else if (hc >= hbp && hc < (hbp+40) && vc >= (vbp+160) && vc < (vbp+320))
		begin
			red = 3'b111;
			green = 3'b111;
			blue = 2'b11;
		end

		// display left yellow box
		else if (hc >= (hbp+40) && hc < (hbp+200) && vc >= (vbp+160) && vc < (vbp+320))
		begin
			// display digit
			if(array1[(hc - (hbp+40))/20 + 8*((vc - (vbp+160))/20)] == 1 && hc >= (hbp+50) && hc < (hbp+190) && vc >= (vbp+170) && vc < (vbp+310))
			begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b11;
			end
			else begin
				red = 3'b111;
				green = 3'b111;
				blue = 2'b00;
			end
		end

		// display white bar at the left middle section
		else if (hc >= (hbp+200) && hc < (hbp+240) && vc >= (vbp+160) && vc < (vbp+320))
		begin
			red = 3'b111;
			green = 3'b111;
			blue = 2'b11;
		end

		// display middle yellow box
		else if (hc >= (hbp+240) && hc < (hbp+400) && vc >= (vbp+160) && vc < (vbp+320))
		begin
			// display digit
			if(array2[(hc - (hbp+240))/20 + 8*((vc - (vbp+160))/20)] == 1 && hc >= (hbp+250) && hc < (hbp+390) && vc >= (vbp+170) && vc < (vbp+310))
			begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b11;
			end
			else begin
				red = 3'b111;
				green = 3'b111;
				blue = 2'b00;
			end
		end

		// display white bar at the right middle section
		else if (hc >= (hbp+400) && hc < (hbp+440) && vc >= (vbp+160) && vc < (vbp+320))
		begin
			red = 3'b111;
			green = 3'b111;
			blue = 2'b11;
		end

		// display right yellow box
		else if (hc >= (hbp+440) && hc < (hbp+600) && vc >= (vbp+160) && vc < (vbp+320))
		begin
			// display digit
			if(array3[(hc - (hbp+440))/20 + 8*((vc - (vbp+160))/20)] == 1 && hc >= (hbp+450) && hc < (hbp+590) && vc >= (vbp+170) && vc < (vbp+310))
			begin
				red = 3'b000;
				green = 3'b000;
				blue = 2'b11;
			end
			else begin
				red = 3'b111;
				green = 3'b111;
				blue = 2'b00;
			end
		end

		// display white bar at the right section
		else if (hc >= (hbp+600) && hc < (hbp+640) && vc >= (vbp+160) && vc < (vbp+320))
		begin
			red = 3'b111;
			green = 3'b111;
			blue = 2'b11;
		end






		// // display yellow bar
		// else if (hc >= (hbp+80) && hc < (hbp+160))
		// begin
		// 	red = 3'b111;
		// 	green = 3'b111;
		// 	blue = 2'b00;
		// end
		// // display cyan bar
		// else if (hc >= (hbp+160) && hc < (hbp+240))
		// begin
		// 	red = 3'b000;
		// 	green = 3'b111;
		// 	blue = 2'b11;
		// end
		// // display green bar
		// else if (hc >= (hbp+240) && hc < (hbp+320))
		// begin
		// 	red = 3'b000;
		// 	green = 3'b111;
		// 	blue = 2'b00;
		// end
		// // display magenta bar
		// else if (hc >= (hbp+320) && hc < (hbp+400))
		// begin
		// 	red = 3'b111;
		// 	green = 3'b000;
		// 	blue = 2'b11;
		// end
		// // display red bar
		// else if (hc >= (hbp+400) && hc < (hbp+480))
		// begin
		// 	red = 3'b111;
		// 	green = 3'b000;
		// 	blue = 2'b00;
		// end
		// // display blue bar
		// else if (hc >= (hbp+480) && hc < (hbp+560))
		// begin
		// 	red = 3'b000;
		// 	green = 3'b000;
		// 	blue = 2'b11;
		// end
		// // display black bar
		// else if (hc >= (hbp+560) && hc < (hbp+640))
		// begin
		// 	red = 3'b000;
		// 	green = 3'b000;
		// 	blue = 2'b00;
		// end
		// we're outside active horizontal range so display black
		else
		begin
			red = 0;
			green = 0;
			blue = 0;
		end
	end
	// we're outside active vertical range so display black
	else
	begin
		red = 0;
		green = 0;
		blue = 0;
	end
end

endmodule
