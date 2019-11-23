`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:40:25 11/22/2019 
// Design Name: 
// Module Name:    SwitchDetection 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 用按钮代替开关
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module SwitchDetection(Sys_CLK,Key,fake_switch);

input Sys_CLK;
input [1:0]Key;
output reg fake_switch;

reg Div_CLK;
reg [15:0]Div_Cnt;
reg [11:0]Key_temp;

wire Key_detec;

initial
begin
	Div_CLK = 1'd0;
	Div_Cnt = 16'd0;
	Key_temp = 12'd0;
	fake_switch = 1'd0;
end

always@(posedge Sys_CLK)
begin
	if(Div_Cnt == 16'd2500)
	begin
		Div_Cnt <= 16'd0;
		Div_CLK <= ~Div_CLK;
	end
	else
		Div_Cnt <= Div_Cnt + 1'd1;
end

always@(posedge Div_CLK) //T = 0.1ms
begin
	Key_temp = (Key_temp << 1) + Key[0]|Key[1];
end

assign Key_detec = &Key_temp;	

always@(posedge Key_detec)
begin
	fake_switch = ~fake_switch;
end

endmodule
