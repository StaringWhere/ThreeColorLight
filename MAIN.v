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
module MAIN(Div_CLK,Sys_RST,Key,Switch,LED,fake_switch);

input Div_CLK;
input [1:0]Key;
input [1:0]Switch;
input Sys_RST;
input fake_switch;
output reg [3:0]LED;

reg [2:0]state;
reg [2:0]nextstate;
reg [19:0]count;
reg shutdown;

wire [19:0]duration;

assign duration = Switch[0]?20'd100000:20'd10000; //��������ܲ࿪�أ��ȴ�ʱ��10s��1s

//״̬����
parameter IDLE = 3'd0; //������
parameter SUN = 3'd1; //�չ�
parameter YELLOW = 3'd2; //�ƹ�
parameter WHITE = 3'd3; //�׹�
parameter WAITSUN = 3'd4; //�ȴ��չ�
parameter WAITYLW = 3'd5; //�ȴ��ƹ�
parameter WAITWHT = 3'd6; //�ȴ��׹�

//[3:0]LED����
parameter LIGHT_W = 4'b0011; //�׹�
parameter LIGHT_S = 4'b0110; //�չ�
parameter LIGHT_Y = 4'b1100; //�ƹ�
parameter LIGHT_N = 4'b0000; //������

initial
begin
	count = 20'd0;
	shutdown = 1'd0;
	state = IDLE;
end

//----------ʱ���߼�------------

always@(posedge Div_CLK) //״̬��ת����
begin
	if(!Sys_RST)
		state <= IDLE;
	else
		state <= nextstate;
end

always@(posedge Div_CLK) //WAIT��ʱ
begin
	if(shutdown == 1)
		shutdown = 0;
	else if(state == WAITSUN || state == WAITYLW || state == WAITWHT)
	begin
		if(count == duration) //1s 
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

//--------------����߼�----------------
always@(state or shutdown or fake_switch) //������һ״̬
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

always@(state) //���Ƶ�
begin
	case(state)
		IDLE   : LED = LIGHT_N;
		WHITE  : LED = LIGHT_W;
		SUN    : LED = LIGHT_S;
		YELLOW : LED = LIGHT_Y;
		//�ȴ�ʱ����
		//WAITWHT: LED = LIGHT_Y;
		//WAITSUN: LED = LIGHT_W;
		//WAITYLW: LED = LIGHT_S;
		//�ȴ�ʱ���
		WAITWHT: LED = LIGHT_N;
		WAITSUN: LED = LIGHT_N;
		WAITYLW: LED = LIGHT_N;
		default: LED = LIGHT_N;
	endcase
end

endmodule
