`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:24:25 11/10/2016 
// Design Name: 
// Module Name:    display_number 
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
module display_number(
	 input hzSegClk,
    input [10:0] number,
	 input [7:0] sw, //for testing
    output reg [3:0] n_cnt,
    output reg [7:0] seg
    );
	 
	 // Wires
	 wire [10:0] sm_wire;
	 wire sign_wire;
	 
	 wire [3:0] digit_1_wire, digit_2_wire, digit_3_wire;
	 
	 wire [7:0] seg_sign, seg_digit1, seg_digit2, seg_digit3;
	 
	 twoc_to_sm task1 (
		.T(number), 
		.SM(sm_wire),
		.signbit(sign_wire)
	);
	
	extract_digits task2(
		.number(sm_wire),
		.digit_1(digit_1_wire),
		.digit_2(digit_2_wire),
		.digit_3(digit_3_wire)
	);
	
	segDisplay digit_1(
		.number(digit_1_wire),
		.segment(seg_digit1)
		);

	segDisplay digit_2 (
		.number(digit_2_wire),
		.segment(seg_digit2)
		);

	segDisplay digit_3 (
		.number(digit_3_wire),
		.segment(seg_digit3)
		);
	

	segSignDisplay digit_sign (
		.sign(sign_wire),
		.segment(seg_sign)
	);
		
	// Registers
	reg [1:0] count;
	
	always @ (posedge hzSegClk) begin
		if (count == 0) begin // left most digit (sign)
		  n_cnt <= 4'b0111;
		  seg <= seg_sign;
		  count <= count + 1;
		end
		if (count == 1) begin
		  n_cnt <= 4'b1011;
		  seg <= seg_digit3;
		  count <= count + 1;
		end
		if (count == 2) begin
		  n_cnt <= 4'b1101;
		  seg <= seg_digit2;
		  count <= count + 1;
		end
		if (count == 3) begin
		  n_cnt <= 4'b1110;
		  seg <= seg_digit1; // right most digit
		  count <= count + 1;
		end
	 end
endmodule
