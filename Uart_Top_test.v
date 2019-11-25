`timescale 1ns / 1ns

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:17:53 11/25/2019
// Design Name:   Uart_Top
// Module Name:   D:/Workspace/verilog/ise/FPGAXC3_Test_3/Verilog HDL/Uart_Top_test.v
// Project Name:  FPGAXC3_Test
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Uart_Top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Uart_Top_test;

	// Inputs
	reg Sys_CLK;
	reg Sys_RST;
	reg Signal_Rx;

	// Outputs
	wire Signal_Tx;

	// Instantiate the Unit Under Test (UUT)
	Uart_Top uut (
		.Sys_CLK(Sys_CLK), 
		.Sys_RST(Sys_RST), 
		.Signal_Tx(Signal_Tx), 
		.Signal_Rx(Signal_Rx)
	);

	always #10 Sys_CLK = ~Sys_CLK;
	
	initial begin
		// Initialize Inputs
		Sys_CLK = 0;
		Sys_RST = 1;
		Signal_Rx = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

