`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:34:41 11/26/2019 
// Design Name: 
// Module Name:    LEDNixietube 
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
module LEDNixietube(Sys_CLK,Div_CLK,Sys_RST,count,state,COM,SEG);

input Sys_CLK;
input Div_CLK;
input Sys_RST;
input [19:0]count;
input state;
output [1:0]COM;
output [7:0]SEG;

reg COM_Cnt;
reg [9:0]Num; //0-9数字显示哪个
wire [24:0]count_BCD;

initial
begin
	COM_Cnt = 1'd0;
	Num[9:0] = 10'd0;
end

//assign COM = (Sys_RST)?((COM_Cnt)?2'b10:2'b01):2'b00;
assign COM = COM_Cnt?2'b10:2'b01;

//数显0-9
or OR7(SEG[7],Num[0],Num[2],Num[3],Num[5],Num[6],Num[7],Num[8],Num[9]);
or OR6(SEG[6],Num[0],Num[1],Num[2],Num[3],Num[4],Num[7],Num[8],Num[9]);
or OR5(SEG[5],Num[0],Num[1],Num[3],Num[4],Num[5],Num[6],Num[7],Num[8],Num[9]);
or OR4(SEG[4],Num[0],Num[2],Num[3],Num[5],Num[6],Num[8],Num[9],Num[9]);
or OR3(SEG[3],Num[0],Num[2],Num[6],Num[8]);
or OR2(SEG[2],Num[0],Num[4],Num[5],Num[6],Num[8],Num[9]);
or OR1(SEG[1],Num[2],Num[3],Num[4],Num[5],Num[6],Num[8],Num[9]);

BinToBCD BinToBCD(.Data_Bin(count),.Data_BCD(count_BCD),.Sys_CLK(Sys_CLK));

always@(posedge Div_CLK)
begin
	COM_Cnt = ~COM_Cnt;
	Num[9:0] = 10'd0;
	if(COM_Cnt) //低位
	begin
		Num[1] = 1'd1;
	end
	else //高位
	begin
		Num[2] = 1'd1;
	end
end

endmodule
