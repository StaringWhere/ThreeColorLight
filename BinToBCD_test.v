`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   03:28:31 11/26/2019
// Design Name:   BinToBCD
// Module Name:   D:/Workspace/verilog/ise/ThreeColorLight/Verilog HDL/BinToBCD_test.v
// Project Name:  ThreeColorLight
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: BinToBCD
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module BinToBCD_test;

	// Inputs
	reg [19:0] Data_Bin;
	reg Sys_CLK;

	// Outputs
	wire [24:0] Data_BCD;

	// Instantiate the Unit Under Test (UUT)
	BinToBCD uut (
		.Data_Bin(Data_Bin), 
		.Data_BCD(Data_BCD), 
		.Sys_CLK(Sys_CLK)
	);
	
	always #10 Sys_CLK = ~Sys_CLK;
	
	initial begin
		// Initialize Inputs
		Data_Bin = 0;
		Sys_CLK = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		Data_Bin = 20'd19;
		#100
		Data_Bin = 20'd43508;
		#100
		Data_Bin = 20'd1048575;

	end
      
endmodule

