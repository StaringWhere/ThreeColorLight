`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:52:22 11/24/2019 
// Design Name: 
// Module Name:    Recording 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: ¼�ư����Ͱ������
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Recording(Div_CLK,fake_switch);

input fake_switch;
input Div_CLK;

reg Tenmili_CLK; //T = 0.01s
reg [7:0]Tenmili_Cnt;
reg [19:0]record_switch;
reg [19:0]record_duration[7:0];
reg [4:0]index;

initial
begin
	Tenmili_CLK = 1'd1; //��֤��һ������
	Tenmili_Cnt = 8'd0;
	record_switch[19:1] = 0;
	record_switch[0] = 0;
	record_duration[7] = 20'd0; //���鲻�ܶ��һ��ֵ����������
	record_duration[6] = 20'd0;
	record_duration[5] = 20'd0;
	record_duration[4] = 20'd0;
	record_duration[3] = 20'd0;
	record_duration[2] = 20'd0;
	record_duration[1] = 20'd0;
	record_duration[0] = 20'd0;
	index = 5'd0;
end

//---------------ʱ���߼�------------------
always@(posedge Div_CLK) //T=10ms��ʱ��
begin
	if(Tenmili_Cnt == 8'd50)
	begin
		Tenmili_Cnt = 8'd0;
		Tenmili_CLK = ~Tenmili_CLK;
	end
	else
		Tenmili_Cnt = Tenmili_Cnt + 1;
end

always@(posedge Div_CLK) //¼�ư����Լ��ı�index ÿ0.1msһ��
begin
	if(fake_switch != record_switch[index])
	begin
		index = index + 1;
		record_switch[index] = fake_switch;
	end
end

always@(posedge Tenmili_CLK) //��ʱ
begin
	if(record_duration[index] < 127 )
		record_duration[index] = record_duration[index] + 1;
end

endmodule
