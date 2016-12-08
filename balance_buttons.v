`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:14:14 11/08/2016 
// Design Name: 
// Module Name:    balance_buttons 
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
module balance_buttons(
	 input gameClk,
	 input changeClk,
	 input hold,
	 input compute,
    input cash_out_btn, // BTNU
    input add_btn, // BTNR
    input gamble_btn, // BTNL
	 input buffer_5, // SW0
	 input buffer_10, // SW1
	 input buffer_20, // SW2
	 output [10:0] current_money_invested, // money invested so far
    output [10:0] current_balance, // current balance
	 output run_game,
	 output [2:0] digit_1,
	 output [2:0] digit_2,
	 output [2:0] digit_3
    );
	 
	 // Registers
	 reg [10:0] total_buffer;
	 reg [10:0] buffer_5_reg;
	 reg [10:0] buffer_10_reg;
	 reg [10:0] buffer_20_reg;
	 reg [10:0] money_invested_reg;
	 reg [10:0] balance_reg;
	 reg run_game_reg;
	 //reg [2:0] data = 3'b011;
	 reg [2:0] multiplier_reg;
	 
	 
	 wire [2:0] out1;
	 wire [2:0] out2;
	 wire [2:0] out3;
	 wire [2:0] multiplier_wire;
	 
	 wire [2:0] seed1_wire;
	 wire [2:0] seed2_wire;
	 wire [2:0] seed3_wire;
	
	 
	 
	 // Initialize
	 initial begin
		buffer_5_reg = 0;
		buffer_10_reg = 0;
		buffer_20_reg = 0;
		money_invested_reg = 0;
		balance_reg = 0;
		run_game_reg = 0;
		multiplier_reg = 0;
	 end
	 
	 always @(posedge gameClk)
	 begin
	 
		// random
		if(hold == 1)
		begin
			if(compute == 1)
			begin
				multiplier_reg = multiplier_wire;
				balance_reg = balance_reg + (total_buffer * multiplier_reg);
				total_buffer = 0;
				run_game_reg = 0;
			end
		end
		else
		begin
			// Calculate the total buffer
			if(buffer_5)
				buffer_5_reg = 11'b0000000101;
			else
				buffer_5_reg = 0;
			if(buffer_10)
				buffer_10_reg = 11'b0000001010;
			else
				buffer_10_reg = 0;
			if(buffer_20)
				buffer_20_reg = 11'b0000010100;
			else
				buffer_20_reg = 0;
			total_buffer = buffer_5_reg + buffer_10_reg + buffer_20_reg;
		
			// Add balance
			if(add_btn)
			begin
				money_invested_reg = money_invested_reg + total_buffer;
				if(money_invested_reg > 11'b01111100111)
				begin
					money_invested_reg = 11'b01111100111;
				end
				balance_reg = balance_reg + total_buffer;
				if(balance_reg > 11'b01111100111)
				begin
					balance_reg = 11'b01111100111;
				end
			end
			// Gamble
			else if(gamble_btn)
			begin
				if(balance_reg >= total_buffer)//we are allowed to gamble
				begin
					balance_reg = balance_reg - total_buffer;
					run_game_reg = 1; // run the game
				end
			end
		
			// Cash out
			if(cash_out_btn)
			begin
				money_invested_reg = 0;
				balance_reg = 0;
			end
		end
	end
	
	
	generate_seed gs1 (
		.clk(gameClk),
		.initial_seed(3'b001),
		.run_game(run_game_reg),
		.seed(seed1_wire)
	);
	
	generate_seed gs2 (
		.clk(gameClk),
		.initial_seed(3'b011),
		.run_game(run_game_reg),
		.seed(seed2_wire)
	);
	
	generate_seed gs3 (
		.clk(gameClk),
		.initial_seed(3'b110),
		.run_game(run_game_reg),
		.seed(seed3_wire)
	);
		
	
	random digit_1_mod (
		.clk(changeClk),
		.seed(seed1_wire),
		.reset(cash_out_btn),
		.enable(run_game_reg),
		.out(out1)
	);
	
	random digit_2_mod (
		.clk(changeClk),
		.seed(seed2_wire),
		.reset(cash_out_btn),
		.enable(run_game_reg),
		.out(out2)
	);
	
	random digit_3_mod (
		.clk(changeClk),
		.seed(seed3_wire),
		.reset(cash_out_btn),
		.enable(run_game_reg),
		.out(out3)
	);
	
	
	 // calculate multiplier
	 calculate_result calculate (
		.card_1(out1),
		.card_2(out2),
		.card_3(out3),
		.multiplier(multiplier_wire)
    );

	 // Assign output
	 assign current_money_invested = money_invested_reg;
	 assign current_balance = balance_reg;
	 assign run_game = run_game_reg;
	 assign digit_1 = out1;
	 assign digit_2 = out2;
	 assign digit_3 = out3;


endmodule
