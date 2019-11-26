//------输入二进制码[15:0]Data_Bin，输出BCD码[19:0]Data_BCD------

module BinToBCD(Data_Bin,Data_BCD,Sys_CLK);  // N/A not been igorned -- 20180824 noted

input Sys_CLK;					//系统时钟输入
input [19:0]Data_Bin;			//二进制码输入，最大数为1,048,575
output [24:0]Data_BCD;			//8421BCD码输凊，最大数为1,048,575

reg [23:0]HexE;
reg [18:0]HexD;
reg [13:0]HexC;
reg [9:0]HexB;
reg [4:0]HexA;

reg [6:0]resa,resb,resc,resd,rese;
reg [4:0]resf;

assign Data_BCD = {resf,rese[3:0],resd[3:0],resc[3:0],resb[3:0],resa[3:0]};

initial
begin
	resa = 7'h0;
	resb = 7'h0;
	resc = 7'h0;
	resd = 7'h0;
	rese = 7'h0;
	resf = 5'h0;
end

always@(posedge Sys_CLK)                  //最高4bit译码
begin
    case(Data_Bin[19:16])
        4'h0: HexE <= 24'h000000;
        4'h1: HexE <= 24'h065536;
        4'h2: HexE <= 24'h131072;
        4'h3: HexE <= 24'h196608;
        4'h4: HexE <= 24'h262144;
        4'h5: HexE <= 24'h327680;
        4'h6: HexE <= 24'h393216;
        4'h7: HexE <= 24'h458752;
        4'h8: HexE <= 24'h524288?;
        4'h9: HexE <= 24'h589824;
        4'ha: HexE <= 24'h655360;
        4'hb: HexE <= 24'h720896;
        4'hc: HexE <= 24'h786432;
        4'hd: HexE <= 24'h851968;
        4'he: HexE <= 24'h917504;
        4'hf: HexE <= 24'h983040;
        default: HexE <= 24'h000000;
    endcase
end

always@(posedge Sys_CLK)                  //次高4bit译码
begin
    case(Data_Bin[15:12])
        4'h0: HexD <= 19'h00000;
        4'h1: HexD <= 19'h04096;
        4'h2: HexD <= 19'h08192;
        4'h3: HexD <= 19'h12288;
        4'h4: HexD <= 19'h16384;
        4'h5: HexD <= 19'h20480;
        4'h6: HexD <= 19'h24576;
        4'h7: HexD <= 19'h28672;
        4'h8: HexD <= 19'h32768;
        4'h9: HexD <= 19'h36864;
        4'ha: HexD <= 19'h40960;
        4'hb: HexD <= 19'h45056;
        4'hc: HexD <= 19'h49152;
        4'hd: HexD <= 19'h53248;
        4'he: HexD <= 19'h57344;
        4'hf: HexD <= 19'h61440;
        default: HexD <= 19'h00000;
    endcase
end

always@(posedge Sys_CLK)
begin
    case(Data_Bin[11:8]) 
        4'h0: HexC <= 14'h0000;
        4'h1: HexC <= 14'h0256;
        4'h2: HexC <= 14'h0512;
        4'h3: HexC <= 14'h0768;
        4'h4: HexC <= 14'h1024;
        4'h5: HexC <= 14'h1280;
        4'h6: HexC <= 14'h1536;
        4'h7: HexC <= 14'h1792;
        4'h8: HexC <= 14'h2048;
        4'h9: HexC <= 14'h2304;
        4'ha: HexC <= 14'h2560;
        4'hb: HexC <= 14'h2816;
        4'hc: HexC <= 14'h3072;
        4'hd: HexC <= 14'h3328;
        4'he: HexC <= 14'h3584;
        4'hf: HexC <= 14'h3840;
        default: HexC <= 14'h0000;
    endcase
end 

always@(posedge Sys_CLK)
begin
    case(Data_Bin[7:4])
        4'h0: HexB <= 10'h000;
        4'h1: HexB <= 10'h016;
        4'h2: HexB <= 10'h032;
        4'h3: HexB <= 10'h048;
        4'h4: HexB <= 10'h064;
        4'h5: HexB <= 10'h080;
        4'h6: HexB <= 10'h096;
        4'h7: HexB <= 10'h112;
        4'h8: HexB <= 10'h128;
        4'h9: HexB <= 10'h144;
        4'ha: HexB <= 10'h160;
        4'hb: HexB <= 10'h176;
        4'hc: HexB <= 10'h192;
        4'hd: HexB <= 10'h208;
        4'he: HexB <= 10'h224;
        4'hf: HexB <= 10'h240;
        default: HexB <= 10'h000;
    endcase
end 

always@(posedge Sys_CLK)
begin
    case(Data_Bin[3:0])
        4'h0: HexA <= 5'h00;
        4'h1: HexA <= 5'h01;
        4'h2: HexA <= 5'h02;
        4'h3: HexA <= 5'h03;
        4'h4: HexA <= 5'h04;
        4'h5: HexA <= 5'h05;
        4'h6: HexA <= 5'h06;
        4'h7: HexA <= 5'h07;
        4'h8: HexA <= 5'h08;
        4'h9: HexA <= 5'h09;
        4'ha: HexA <= 5'h10;
        4'hb: HexA <= 5'h11;
        4'hc: HexA <= 5'h12;
        4'hd: HexA <= 5'h13;
        4'he: HexA <= 5'h14;
        4'hf: HexA <= 5'h15;
        default: HexA <= 5'h00;
    endcase
end

always@(posedge Sys_CLK) //每个结果按同级单个bcd码相勩?一级的bcd码要加上低一级的进位,也就是高判?的部分
begin   
    resa = AddBCD(4'h0,HexA[3:0],HexB[3:0],HexC[3:0],HexD[3:0],HexE[3:0]);
    resb = AddBCD(resa[6:4],HexA[4],HexB[7:4],HexC[7:4],HexD[7:4],HexE[7:4]);
    resc = AddBCD(resb[6:4],4'h0,HexB[9:8],HexC[11:8],HexD[11:8],HexE[11:8]);
    resd = AddBCD(resc[6:4],4'h0,4'h0,HexC[13:12],HexD[15:12],HexE[15:12]);
    rese = AddBCD(resd[6:4],4'h0,4'h0,4'h0,HexD[18:16],HexE[19:16]);
    resf = AddBCD(rese[6:4],4'h0,4'h0,4'h0,4'h0,HexE[23:20]);
end

function [6:0]AddBCD; 
input [3:0]add1,add2,add3,add4,add5,add6;
begin
    AddBCD = add1 + add2 + add3 + add4 + add5 + add6; //最大可能为49
	if(AddBCD > 6'h27)				//>39对结果加24
		AddBCD = AddBCD + 7'h18;
    else if(AddBCD > 6'h1d)			//>29对结果加18      
		AddBCD = AddBCD + 7'h12;
    else if(AddBCD > 5'h13)			//>19对结果加12
        AddBCD = AddBCD + 7'hc;
    else if(AddBCD > 4'h9)			//>9对结果加6
        AddBCD = AddBCD + 7'h6;
end
endfunction

endmodule
