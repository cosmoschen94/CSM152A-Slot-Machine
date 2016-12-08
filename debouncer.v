`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    10:43:27 10/27/2016
// Design Name:
// Module Name:    debouncer
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
module debouncer(
    input clk,
    input btn,
    output btnState
    );

		reg button_reg = 0;
		reg [15:0] count;

		always @ (posedge clk)
		begin
			if(btn > 0 || btn < 0)
			begin
				count <= count +1;
				if(count == 16'b1111111111111111)
				begin
					button_reg <= 1;
					count <= 0;
				end
			end
			else
			begin
				count <= 0;
				button_reg <= 0;
			end
		end

		assign btnState = button_reg;

endmodule
