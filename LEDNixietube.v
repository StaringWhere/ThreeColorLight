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
module LEDNixietube(Sys_CLK,Div_CLK,Sys_RST,count,state,COM,SEG,Switch);

input Sys_CLK;
input Div_CLK;
input Sys_RST;
input [19:0]count;
input [2:0]state;
input [1:0]Switch;
output [1:0]COM;
output [7:0]SEG;

reg COM_Cnt;
reg [9:0]Num; //0-9������ʾ�ĸ�
reg SEG_dp; //С����
reg [13:0]dp_Cnt;
reg dp_CLK;
wire [24:0]count_BCD;

//״̬����
parameter IDLE = 3'd0; //������
parameter SUN = 3'd1; //�չ�
parameter YELLOW = 3'd2; //�ƹ�
parameter WHITE = 3'd3; //�׹�
parameter WAITSUN = 3'd4; //�ȴ��չ�
parameter WAITYLW = 3'd5; //�ȴ��ƹ�
parameter WAITWHT = 3'd6; //�ȴ��׹�

initial
begin
	COM_Cnt = 1'd0;
	Num[9:0] = 10'd0;
end

assign COM = (Sys_RST & Switch[0])?((COM_Cnt)?2'b10:2'b01):2'b00; //��ʾλ

//����0-9
or OR7(SEG[7],Num[0],Num[2],Num[3],Num[5],Num[6],Num[7],Num[8],Num[9]);
or OR6(SEG[6],Num[0],Num[1],Num[2],Num[3],Num[4],Num[7],Num[8],Num[9]);
or OR5(SEG[5],Num[0],Num[1],Num[3],Num[4],Num[5],Num[6],Num[7],Num[8],Num[9]);
or OR4(SEG[4],Num[0],Num[2],Num[3],Num[5],Num[6],Num[8],Num[9],Num[9]);
or OR3(SEG[3],Num[0],Num[2],Num[6],Num[8]);
or OR2(SEG[2],Num[0],Num[4],Num[5],Num[6],Num[8],Num[9]);
or OR1(SEG[1],Num[2],Num[3],Num[4],Num[5],Num[6],Num[8],Num[9]);
//����С����
assign SEG[0] = SEG_dp;

BinToBCD BinToBCD(.Data_Bin(count),.Data_BCD(count_BCD),.Sys_CLK(Sys_CLK));

always@(posedge Div_CLK) 
begin
	COM_Cnt = ~COM_Cnt;
	
	//���ּ�ʱ
	Num[9:0] = 10'd0;
	if(COM_Cnt) //��λ
	begin
		Num[count_BCD[15:12]] = 1'd1;
	end
	else //��λ
	begin
		Num[count_BCD[19:16]] = 1'd1;
	end
	
	//С����״̬
	case(state)
		IDLE:  
		begin
			SEG_dp = 1'd0;
		end
		WHITE: 
		begin
			if(COM_Cnt)
				SEG_dp = 1'b1;
			else
				SEG_dp = 1'b0;
		end
		SUN:
		begin
			if(COM_Cnt)
				SEG_dp = 1'b1;
			else	
				SEG_dp = 1'b1;
		end
		YELLOW :  
		begin
			if(COM_Cnt)
				SEG_dp = 1'b0;
			else
				SEG_dp = 1'b1;
		end
		WAITWHT: 
		begin
			if(COM_Cnt)
				SEG_dp = 1'b0;
			else
				SEG_dp = dp_CLK;
		end
		WAITSUN: 
		begin
			if(COM_Cnt)
				SEG_dp = dp_CLK;
			else
				SEG_dp = 1'b0;
		end			
		WAITYLW:
		begin			
			if(COM_Cnt)
				SEG_dp = dp_CLK;
			else
				SEG_dp = dp_CLK;
		end
		default: SEG_dp = 1'd0;
	endcase
end

always@(posedge Div_CLK) //dp_CLK T = 1s
begin
	if(dp_Cnt == 14'd5000)
	begin
		dp_Cnt = 14'd0;
		dp_CLK = ~dp_CLK; 
	end
	else
		dp_Cnt = dp_Cnt + 1;
end
endmodule
