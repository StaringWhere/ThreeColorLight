`timescale 1ns / 1ns

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:40:51 11/23/2019
// Design Name:   MAIN
// Module Name:   D:/Workspace/verilog/ise/ThreeColorLight/MAIN_test.v
// Project Name:  ThreeColorLight
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: MAIN
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module MAIN_test;

	// Inputs
	reg Sys_CLK;
	reg Sys_RST;
	reg [1:0] Key;
	reg [1:0] Switch;

	// Outputs
	wire [3:0] LED;

	// Instantiate the Unit Under Test (UUT)
	MAIN uut (
		.Sys_CLK(Sys_CLK), 
		.Sys_RST(Sys_RST), 
		.Key(Key), 
		.LED(LED)
	);
	
	always #10 Sys_CLK = ~Sys_CLK;
	
	initial begin
		// Initialize Inputs
		Sys_CLK = 0;
		Sys_RST = 1;
		Key = 0;
		switch = 0;

		// Wait 100 ns for global reset to finish
		#100;
		#1_000_000 Key = 1; //开
		#2_000_000 Key = 0;
		#2_000_000 Key = 1; //关
		#2_000_000 Key = 0;
		#2_000_000 Key = 1; //开
		#2_000_000 Key = 0;
		#2_000_000 Key = 1; //关
		#2_000_000 Key = 0;
		#2_000_000 Key = 1; //开
		#2_000_000 Key = 0;
		
        
		// Add stimulus here

	end
      
endmodule

