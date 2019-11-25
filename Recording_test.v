`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:08:33 11/24/2019
// Design Name:   Recording
// Module Name:   D:/Workspace/verilog/ise/ThreeColorLight/Verilog HDL/Recording_test.v
// Project Name:  ThreeColorLight
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Recording
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Recording_test;

	// Inputs
	reg Div_CLK;
	reg fake_switch;

	// Instantiate the Unit Under Test (UUT)
	Recording uut (
		.Div_CLK(Div_CLK), 
		.fake_switch(fake_switch)
	);

	always #50_000 Div_CLK = ~Div_CLK; //0,1ms
	
	initial begin
		// Initialize Inputs
		Div_CLK = 0;
		fake_switch = 0;

		// Wait 100 ns for global reset to finish
		#100;
		#20_000_000 fake_switch = 1;
		#30_000_000 fake_switch = 0;
		#40_000_000 fake_switch = 1;
        
		// Add stimulus here

	end
      
endmodule

