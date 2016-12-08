`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:54:04 11/17/2016 
// Design Name: 
// Module Name:    controller 
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
module controller(
    input clk,
    input cash_out_btn,
    input add_btn,
    input gamble_btn,
    input status_btn,
    input buffer_5,
    input buffer_10,
    input buffer_20,
	 output wire [3:0] n_cnt,
    output wire [7:0] seg,
	 output wire [2:0] red,	//red vga output - 3 bits
	 output wire [2:0] green,//green vga output - 3 bits
	 output wire [1:0] blue,	//blue vga output - 2 bits
	 output wire hsync,		//horizontal sync out
	 output wire vsync			//vertical sync out
    );
	 
	 // Wires
	 wire [10:0] current_money_wire;
	 wire [10:0] current_balance_wire;
	 wire [10:0] number_to_display_wire;
	 wire run_game_wire;
	 wire hzSegClk_wire;
	 wire gameClk_wire;
	 wire clk1hz_wire;
	 wire pix_en_wire;
	 wire changeClk_wire;
	 
	 wire add_state_wire;
	 wire gamble_state_wire;
	 wire status_state_wire;
	 
	 wire add_signal_on;
	 wire add_signal_off;
	 wire gamble_signal_on;
	 wire gamble_signal_off;
	 wire reset_signal_on;
	 wire reset_signal_off;
	 
	 wire compute_wire;
	 wire hold_wire;
	 wire [2:0] out1_wire;
	 wire [2:0] out2_wire;
	 wire [2:0] out3_wire;
	 wire [63:0] array_1_wire;
	 wire [63:0] array_2_wire;
	 wire [63:0] array_3_wire;
	 
	 
	 debouncer add_deb(
		.clk(clk),
		.btn(add_btn),
		.btnState(add_state_wire)
    );
	 
	 debouncer gamble_deb(
		.clk(clk),
		.btn(gamble_btn),
		.btnState(gamble_state_wire)
    );
	 
	 debouncer status_deb(
		.clk(clk),
		.btn(status_btn),
		.btnState(status_state_wire)
    );

    debouncer reset_deb(
		.clk(clk),
		.btn(cash_out_btn),
		.btnState(reset_state_wire)
    );
    
    edge_detect ed_add(
        .async_sig(add_state_wire),
        .clk(clk),
        .rise(add_signal_on),
        .fall(add_signal_off)
        );
	 
	 edge_detect ed_gamble(
        .async_sig(gamble_state_wire),
        .clk(clk),
        .rise(gamble_signal_on),
        .fall(gamble_signal_off)
        );
	 
	 edge_detect ed_reset(
        .async_sig(reset_state_wire),
        .clk(clk),
        .rise(reset_signal_on),
        .fall(reset_signal_off)
        );
	 
	  clock m_clk(
		.clk(clk),
		.clk1hz(clk1hz_wire),
		.hzSegClk(hzSegClk_wire),
		.gameClk(gameClk_wire),
		.pix_en(pix_en_wire),
		.changeClk(changeClk_wire)
		);
		
	 counter count (
		.clk(clk1hz_wire),
		.run_game(run_game_wire),
		.compute(compute_wire),
		.hold(hold_wire)
	 );
	 
	 balance_buttons brain (
		.gameClk(clk),
		.changeClk(changeClk_wire),
		.hold(hold_wire),
		.compute(compute_wire),
		.cash_out_btn(reset_signal_on), 
		.add_btn(add_signal_on), 
		.gamble_btn(gamble_signal_on), 
		.buffer_5(buffer_5), 
		.buffer_10(buffer_10), 
		.buffer_20(buffer_20), 
		.current_money_invested(current_money_wire), 
		.current_balance(current_balance_wire), 
		.run_game(run_game_wire),
		.digit_1(out1_wire),
		.digit_2(out2_wire),
		.digit_3(out3_wire)
	 );
	 
	 choose_display choose_disp (
		.gameClk(clk),
		.status_btn(status_state_wire),
		.current_money_invested(current_money_wire),
		.current_balance(current_balance_wire),
		.number_to_display(number_to_display_wire)
	 );
	 
	 display_number display (
		.hzSegClk(hzSegClk_wire),
		.number(number_to_display_wire), 
		.n_cnt(n_cnt), 
		.seg(seg)
	 );
	 
	 // convert from random number to digit matrix
	displayNum (
		.num(out1_wire),
		.array(array_1_wire)
	);
	
	// convert from random number to digit matrix
	displayNum (
		.num(out2_wire),
		.array(array_2_wire)
	);
	
	// convert from random number to digit matrix
	displayNum (
		.num(out3_wire),
		.array(array_3_wire)
	);


	// VGA controller
	vga640x480 U3(
		.pix_en(pix_en_wire),
		.clk(clk),
		.rst(reset_signal_on),
		.hsync(hsync),
		.vsync(vsync),
		.red(red),
		.green(green),
		.blue(blue),
		.array1(array_1_wire),
		.array2(array_2_wire),
		.array3(array_3_wire)
	);
	 
endmodule
