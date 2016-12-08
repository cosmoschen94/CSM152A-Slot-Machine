`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:59:18 11/22/2016 
// Design Name: 
// Module Name:    random 
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

module random    (
	output [2:0] out             ,  // Output of the counter
	input enable          ,  // Enable  for counter
	input clk             ,  // clock input
	input reset,            // reset input
	input [2:0] seed
);
 
reg [2:0] out_reg;
wire linear_feedback;

assign linear_feedback = !(out[2] ^ out[0] ^ seed[2] ^ seed[1] ^ seed[0]);

always @(posedge clk)
if (reset) begin // active high reset
  out_reg = 3'b0 ;
end else if (enable) begin
  out_reg = {out[2] ^ seed[1], out[1] ^ seed[0], out[0], linear_feedback};
end

assign out = out_reg;

endmodule // End Of Module counter
