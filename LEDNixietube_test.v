`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   04:25:09 11/26/2019
// Design Name:   LEDNixietube
// Module Name:   D:/Workspace/verilog/ise/ThreeColorLight/Verilog HDL/LEDNixietube_test.v
// Project Name:  ThreeColorLight
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: LEDNixietube
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module LEDNixietube_test;

	// Inputs
	reg Sys_CLK;
	reg Div_CLK;
	reg Sys_RST;
	reg [19:0] count;
	reg state;

	// Outputs
	wire [1:0] COM;
	wire [7:0] SEG;

	// Instantiate the Unit Under Test (UUT)
	LEDNixietube uut (
		.Sys_CLK(Sys_CLK), 
		.Div_CLK(Div_CLK), 
		.Sys_RST(Sys_RST), 
		.count(count), 
		.state(state), 
		.COM(COM), 
		.SEG(SEG)
	);
	
	always #10 Sys_CLK = ~Sys_CLK;
	always #50000 Div_CLK = ~Div_CLK;
	
	initial begin
		// Initialize Inputs
		Sys_CLK = 0;
		Div_CLK = 0;
		Sys_RST = 0;
		count = 0;
		state = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

