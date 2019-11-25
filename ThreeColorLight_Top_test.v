`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   04:35:21 11/26/2019
// Design Name:   TreeColorLight_Top
// Module Name:   D:/Workspace/verilog/ise/ThreeColorLight/Verilog HDL/ThreeColorLight_Top_test.v
// Project Name:  ThreeColorLight
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: TreeColorLight_Top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ThreeColorLight_Top_test;

	// Inputs
	reg Sys_CLK;
	reg Sys_RST;
	reg [1:0] Key;
	reg [1:0] Switch;

	// Outputs
	wire [3:0] LED;
	wire [7:0] SEG;
	wire [1:0] COM;
	
	// Instantiate the Unit Under Test (UUT)
	TreeColorLight_Top uut (
		.Sys_CLK(Sys_CLK), 
		.Sys_RST(Sys_RST), 
		.Key(Key), 
		.Switch(Switch), 
		.LED(LED), 
		.SEG(SEG), 
		.COM(COM)
	);

	always #10 Sys_CLK = ~Sys_CLK;
	
	initial begin
		// Initialize Inputs
		Sys_CLK = 0;
		Sys_RST = 0;
		Key = 0;
		Switch = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

