`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:53:08 11/24/2019 
// Design Name: 
// Module Name:    ThreeColorLight_Top 
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
module TreeColorLight_Top(Sys_CLK,Sys_RST,Key,Switch,LED,SEG,COM);

input Sys_CLK;
input [1:0]Key;
input [1:0]Switch;
input Sys_RST;
output [3:0]LED;
output [7:0]SEG;
output [1:0]COM;

reg Div_CLK;
reg [15:0]Div_Cnt;

wire fake_switch;
wire [2:0]state;
wire [19:0]count;

initial
begin
	Div_CLK = 1'd0;
	Div_Cnt = 16'd0;
end


//------------------时钟--------------------
always@(posedge Sys_CLK) //小时钟
begin
	if(Div_Cnt == 12'd2500)
	begin
		Div_CLK <= ~Div_CLK; //T = 0.1ms;
		Div_Cnt <= 12'd0;
	end
	else
		Div_Cnt <= Div_Cnt + 1;
end

//------------------实例--------------------
MAIN MAIN(
	.Div_CLK(Div_CLK),
	.Sys_RST(Sys_RST),
	.Key(Key),
	.Switch(Switch),
	.LED(LED),
	.fake_switch(fake_switch),
	.count(count),
	.state(state)
	);
	
SwitchDetection SwitchDetection(
	.Div_CLK(Div_CLK),
	.Key(Key),
	.fake_switch(fake_switch)
	);
	
Recording Recording(
	.Div_CLK(Div_CLK),
	.fake_switch(fake_switch)
	);
	
LEDNixietube LEDNixietube(
	.Sys_CLK(Sys_CLK),
	.Div_CLK(Div_CLK),
	.Sys_RST(Sys_RST),
	.count(count),
	.state(state),
	.COM(COM),
	.SEG(SEG)
	);

endmodule
