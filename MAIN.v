`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:05:01 11/22/2019 
// Design Name: 
// Module Name:    MAIN 
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
module MAIN(Sys_CLK,Sys_RST,Key,LED);

input Sys_CLK;
input [1:0]Key;
input Sys_RST;
//output reg [7:0]SEG;
//output reg [1:0]COM;
output reg [3:0]LED;

reg Div_CLK;
reg [15:0]Div_Cnt;
reg [2:0]state;
reg [2:0]nextstate;
reg [19:0]count;
reg shutdown;

wire fake_switch;

//状态常量
parameter IDLE = 3'd0; //不发光
parameter SUN = 3'd1; //日光
parameter YELLOW = 3'd2; //黄光
parameter WHITE = 3'd3; //白光
parameter WAITSUN = 3'd4; //等待日光
parameter WAITYLW = 3'd5; //等待黄光
parameter WAITWHT = 3'd6; //等待白光

//[3:0]LED常量
parameter LIGHT_W = 4'b0011; //白光
parameter LIGHT_S = 4'b0110; //日光
parameter LIGHT_Y = 4'b1100; //黄光
parameter LIGHT_N = 4'b0000; //不发光

SwitchDetection SwitchDetection(.Sys_CLK(Sys_CLK),.Key(Key),.fake_switch(fake_switch));

initial
begin
	Div_CLK = 1'd0;
	Div_Cnt = 16'd0;
	count = 20'd0;
	shutdown = 1'd0;
	state = IDLE;
end

//----------时序逻辑------------
always@(posedge Sys_CLK)
begin
	if(Div_Cnt == 12'd2500)
	begin
		Div_CLK <= ~Div_CLK; //T = 0.1ms;
		Div_Cnt <= 12'd0;
	end
	else
		Div_Cnt <= Div_Cnt + 1;
end

always@(posedge Div_CLK) //状态跳转程序
begin
	if(!Sys_RST)
		state <= IDLE;
	else
		state <= nextstate;
end

always@(posedge Div_CLK) //WAIT计时
begin
	if(shutdown == 1)
		shutdown = 0;
	else if(state == WAITSUN || state == WAITYLW || state == WAITWHT)
	begin
		if(count == 20'd10000) //1s 
		begin
			count <= 20'd0;
			shutdown = 1;
		end
		else
			count <= count + 1;
	end
	else
		count <= 0;
end

//--------------组合逻辑----------------
always@(state or shutdown or fake_switch) //生成下一状态
begin
	case(state)
		IDLE:
			if(fake_switch == 1)
				nextstate = WHITE;
			else
				nextstate = IDLE;
		WHITE:
			if(fake_switch == 0)
				nextstate = WAITSUN;
			else
				nextstate = WHITE;
		SUN:
			if(fake_switch == 0)
				nextstate = WAITYLW;
			else
				nextstate = SUN;
		YELLOW:
			if(fake_switch == 0)
				nextstate = WAITWHT;
			else
				nextstate = YELLOW;
		WAITWHT:
			if(fake_switch == 1)
				nextstate = WHITE;
			else if(shutdown == 1)
				nextstate = IDLE;
			else
				nextstate = WAITWHT;
		WAITSUN:
			if(fake_switch == 1)
				nextstate = SUN;
			else if(shutdown == 1)
				nextstate = IDLE;
			else
				nextstate = WAITSUN;
		WAITYLW:
			if(fake_switch == 1)
				nextstate = YELLOW;
			else if(shutdown == 1)
				nextstate = IDLE;
			else
				nextstate = WAITYLW;
		default:
			nextstate = IDLE;
	endcase
end

always@(state) //控制灯
begin
	case(state)
		IDLE   : LED = LIGHT_N;
		WHITE  : LED = LIGHT_W;
		SUN    : LED = LIGHT_S;
		YELLOW : LED = LIGHT_Y;
		//等待时亮灯
		//WAITWHT: LED = LIGHT_Y;
		//WAITSUN: LED = LIGHT_W;
		//WAITYLW: LED = LIGHT_S;
		//等待时灭灯
		WAITWHT: LED = LIGHT_N;
		WAITSUN: LED = LIGHT_N;
		WAITYLW: LED = LIGHT_N;
		default: LED = LIGHT_N;
	endcase
end

endmodule
