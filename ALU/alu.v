`timescale 1ns/1ps

//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    15:15:11 08/18/2010
// Design Name:
// Module Name:    alu
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

module alu(
           rst_n,         // negative reset            (input)
           src1,          // 32 bits source 1          (input)
           src2,          // 32 bits source 2          (input)
           ALU_control,   // 4 bits ALU control input  (input)
		     bonus_control, // 3 bits bonus control input(input) 
           result,        // 32 bits result            (output)
           zero,          // 1 bit when the output is 0, zero must be set (output)
           cout,          // 1 bit carry out           (output)
           overflow       // 1 bit overflow            (output)
           );


input           rst_n;
input  [32-1:0] src1;
input  [32-1:0] src2;
input   [4-1:0] ALU_control;
input   [3-1:0] bonus_control; 

output [32-1:0] result;
output          zero;
output          cout;
output          overflow;

//reg    [32-1:0] result;
reg             zero;
reg             cout;
reg             overflow;


wire w1,w2,w3;
wire COMP_result;
wire [31:0] equaltmp;
wire equaltmp1;
wire less,equal;
wire zerotmp;
wire c[32-1:0];
//wire b[30:0];
wire [32-1:0] srctmp1,srctmp2;
wire [32-1:0] resulttmp;
alu_top
    a1(srctmp1[0],srctmp2[0],COMP_result,ALU_control[3],ALU_control[2],ALU_control[2],ALU_control[1:0],resulttmp[0],c[0]),  //change the cin bit from ALU_control[3] to ALU_control[2].
    a2(srctmp1[1],srctmp2[1],1'b0,ALU_control[3],ALU_control[2],c[0],ALU_control[1:0],resulttmp[1],c[1]),
    a3(srctmp1[2],srctmp2[2],1'b0,ALU_control[3],ALU_control[2],c[1],ALU_control[1:0],resulttmp[2],c[2]),
    a4(srctmp1[3],srctmp2[3],1'b0,ALU_control[3],ALU_control[2],c[2],ALU_control[1:0],resulttmp[3],c[3]),
    a5(srctmp1[4],srctmp2[4],1'b0,ALU_control[3],ALU_control[2],c[3],ALU_control[1:0],resulttmp[4],c[4]),
    a6(srctmp1[5],srctmp2[5],1'b0,ALU_control[3],ALU_control[2],c[4],ALU_control[1:0],resulttmp[5],c[5]),
    a7(srctmp1[6],srctmp2[6],1'b0,ALU_control[3],ALU_control[2],c[5],ALU_control[1:0],resulttmp[6],c[6]),
    a8(srctmp1[7],srctmp2[7],1'b0,ALU_control[3],ALU_control[2],c[6],ALU_control[1:0],resulttmp[7],c[7]),
    a9(srctmp1[8],srctmp2[8],1'b0,ALU_control[3],ALU_control[2],c[7],ALU_control[1:0],resulttmp[8],c[8]),
    a10(srctmp1[9],srctmp2[9],1'b0,ALU_control[3],ALU_control[2],c[8],ALU_control[1:0],resulttmp[9],c[9]),
    a11(srctmp1[10],srctmp2[10],1'b0,ALU_control[3],ALU_control[2],c[9],ALU_control[1:0],resulttmp[10],c[10]),
    a12(srctmp1[11],srctmp2[11],1'b0,ALU_control[3],ALU_control[2],c[10],ALU_control[1:0],resulttmp[11],c[11]),
    a13(srctmp1[12],srctmp2[12],1'b0,ALU_control[3],ALU_control[2],c[11],ALU_control[1:0],resulttmp[12],c[12]),
    a14(srctmp1[13],srctmp2[13],1'b0,ALU_control[3],ALU_control[2],c[12],ALU_control[1:0],resulttmp[13],c[13]),
    a15(srctmp1[14],srctmp2[14],1'b0,ALU_control[3],ALU_control[2],c[13],ALU_control[1:0],resulttmp[14],c[14]),
    a16(srctmp1[15],srctmp2[15],1'b0,ALU_control[3],ALU_control[2],c[14],ALU_control[1:0],resulttmp[15],c[15]),
    a17(srctmp1[16],srctmp2[16],1'b0,ALU_control[3],ALU_control[2],c[15],ALU_control[1:0],resulttmp[16],c[16]),
    a18(srctmp1[17],srctmp2[17],1'b0,ALU_control[3],ALU_control[2],c[16],ALU_control[1:0],resulttmp[17],c[17]),
    a19(srctmp1[18],srctmp2[18],1'b0,ALU_control[3],ALU_control[2],c[17],ALU_control[1:0],resulttmp[18],c[18]),
    a20(srctmp1[19],srctmp2[19],1'b0,ALU_control[3],ALU_control[2],c[18],ALU_control[1:0],resulttmp[19],c[19]),
    a21(srctmp1[20],srctmp2[20],1'b0,ALU_control[3],ALU_control[2],c[19],ALU_control[1:0],resulttmp[20],c[20]),
    a22(srctmp1[21],srctmp2[21],1'b0,ALU_control[3],ALU_control[2],c[20],ALU_control[1:0],resulttmp[21],c[21]),
    a23(srctmp1[22],srctmp2[22],1'b0,ALU_control[3],ALU_control[2],c[21],ALU_control[1:0],resulttmp[22],c[22]),
    a24(srctmp1[23],srctmp2[23],1'b0,ALU_control[3],ALU_control[2],c[22],ALU_control[1:0],resulttmp[23],c[23]),
    a25(srctmp1[24],srctmp2[24],1'b0,ALU_control[3],ALU_control[2],c[23],ALU_control[1:0],resulttmp[24],c[24]),
    a26(srctmp1[25],srctmp2[25],1'b0,ALU_control[3],ALU_control[2],c[24],ALU_control[1:0],resulttmp[25],c[25]),
    a27(srctmp1[26],srctmp2[26],1'b0,ALU_control[3],ALU_control[2],c[25],ALU_control[1:0],resulttmp[26],c[26]),
    a28(srctmp1[27],srctmp2[27],1'b0,ALU_control[3],ALU_control[2],c[26],ALU_control[1:0],resulttmp[27],c[27]),
    a29(srctmp1[28],srctmp2[28],1'b0,ALU_control[3],ALU_control[2],c[27],ALU_control[1:0],resulttmp[28],c[28]),
    a30(srctmp1[29],srctmp2[29],1'b0,ALU_control[3],ALU_control[2],c[28],ALU_control[1:0],resulttmp[29],c[29]),
    a31(srctmp1[30],srctmp2[30],1'b0,ALU_control[3],ALU_control[2],c[29],ALU_control[1:0],resulttmp[30],c[30]),
    a32(srctmp1[31],srctmp2[31],1'b0,ALU_control[3],ALU_control[2],c[30],ALU_control[1:0],resulttmp[31],c[31]);

register
    r1(src1,srctmp1,rst_n),
	 r2(src2,srctmp2,rst_n);
or_32
    o1(result,zerotmp),
	 o2(equaltmp,equaltmp1);
not
    n1(equal,equaltmp1);
compare
    c1(bonus_control,less,equal,COMP_result);
	 
assign equaltmp=srctmp1 ^ srctmp2;
assign result=resulttmp;
assign less=~(c[31]^(srctmp1[31]^srctmp2[31]));       //less

//assign equal=((srctmp1[0]^srctmp2[0])||(srctmp1[1]^srctmp2[1])||(srctmp1[2]^srctmp2[2])||(srctmp1[3]^srctmp2[3])||(srctmp1[4]^srctmp2[4])||(srctmp1[5]^srctmp2[5])||(srctmp1[6]^srctmp2[6])||(srctmp1[7]^srctmp2[7])||(srctmp1[8]^srctmp2[8])||(srctmp1[0]^srctmp2[0])||(srctmp1[0]^srctmp2[0])||(srctmp1[0]^srctmp2[0])||(srctmp1[0]^srctmp2[0])||(srctmp1[0]^srctmp2[0])||(srctmp1[0]^srctmp2[0])||(srctmp1[0]^srctmp2[0])||(srctmp1[0]^srctmp2[0])||(srctmp1[0]^srctmp2[0])||(srctmp1[0]^srctmp2[0])||(srctmp1[0]^srctmp2[0])||(srctmp1[0]^srctmp2[0])||(srctmp1[0]^srctmp2[0])||(srctmp1[0]^srctmp2[0])||(srctmp1[0]^srctmp2[0])||(srctmp1[0]^srctmp2[0])||(srctmp1[0]^srctmp2[0])||(srctmp1[0]^srctmp2[0])||(srctmp1[0]^srctmp2[0])||(srctmp1[0]^srctmp2[0])||(srctmp1[0]^srctmp2[0])||(srctmp1[0]^srctmp2[0])||(srctmp1[0]^srctmp2[0]));
always@(*)begin
    if(rst_n == 1'b1)begin
	     //srctmp1 <= src1;    //<= or =?
		  //srctmp2 <= src2;
		  //zero=~(result[0]||result[1]||result[2]||result[3]||result[4]||result[5]||result[6]||result[7]||result[8]||result[9]||result[10]||result[11]||result[12]||result[13]||result[14]||result[15]||result[16]||result[17]||result[18]||result[19]||result[20]||result[21]||result[22]||result[23]||result[24]||result[25]||result[26]||result[27]||result[28]||result[29]||result[30]||result[31]);
		  zero=~zerotmp;
		  if((ALU_control==4'b0010) || (ALU_control == 4'b0110))begin
		      overflow <= c[30]^c[31];       //double signed.
				//cout <= c[30];
				cout <= c[31];
		  end
		  else begin
		      overflow <= 1'b0;
				cout <= 1'b0;
		  end
	 end
end


    
endmodule
