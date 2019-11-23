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
reg [1:0]light;

wire fake_switch;

parameter IDLE = 3'b000; //不发光
parameter WAIT = 3'b001; //等待熄灭
parameter SUN = 3'b010; //日光
parameter YELLOW = 3'b011; //黄光
parameter WHITE = 3'b100; //白光

SwitchDetection SwitchDetection(.Sys_CLK(Sys_CLK),.Key(Key),.fake_switch(fake_switch));

initial
begin
	Div_CLK = 1'd0;
	Div_Cnt = 16'd0;
	count = 20'd0;
	shutdown = 1'd0;
	light = 1'd0;
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
	else if(state == WAIT)
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
always@(state or shutdown or fake_switch or light) //生成下一状态
begin
	case(state)
		IDLE:
			if(fake_switch == 1)
				nextstate = WHITE;
			else
				nextstate = IDLE;
		WHITE:
			if(fake_switch == 0)
				nextstate = WAIT;
			else
				nextstate = WHITE;
		SUN:
			if(fake_switch == 0)
				nextstate = WAIT;
			else
				nextstate = SUN;
		YELLOW:
			if(fake_switch == 0)
				nextstate = WAIT;
			else
				nextstate = YELLOW;
		WAIT:
			if(fake_switch == 1)
			begin
				if(light == 3)
					nextstate = WHITE;
				else if(light == 2)
					nextstate = YELLOW;
				else
					nextstate = SUN;
			end
			else if(shutdown == 1)
				nextstate = IDLE;
			else
				nextstate = WAIT;
		default:
			nextstate = IDLE;
	endcase
end

always@(state) //改变light
begin
	case(state)
		IDLE: light = 2'd0;
		WHITE: light = 2'd1;
		SUN: light = 2'd2;
		YELLOW: light = 2'd3;
		default: light = light;
	endcase
end

always@(light) //控制灯
begin
	case(light)
	2'd0: LED = 4'b0000;
	2'd1: LED = 4'b0011;
	2'd2: LED = 4'b0110;
	2'd3: LED = 4'b1100;
	endcase
end

endmodule
