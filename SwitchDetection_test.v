`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:51:48 11/23/2019
// Design Name:   SwitchDetection
// Module Name:   D:/Workspace/verilog/ise/ThreeColorLight/SwitchDetection_test.v
// Project Name:  ThreeColorLight
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: SwitchDetection
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module SwitchDetection_test;

	// Inputs
	reg Sys_CLK;
	reg [1:0] Key;

	// Outputs
	wire fake_switch;

	// Instantiate the Unit Under Test (UUT)
	SwitchDetection uut (
		.Sys_CLK(Sys_CLK), 
		.Key(Key), 
		.fake_switch(fake_switch)
	);

	always #10 Sys_CLK<=~Sys_CLK;
	
	initial begin
		// Initialize Inputs
		Sys_CLK = 0;
		Key = 0;

		// Wait 100 ns for global reset to finish
		#100;
		// Add stimulus here
        #300 Key[0] = 1;
		#1300000 Key[0] = 0;
        #300000 Key[0] = 1;
		#1300000 Key[0] = 0;
	end
      
endmodule

