`timescale 1ns/1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:58:01 10/10/2011 
// Design Name: 
// Module Name:    alu_top 
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

module alu_top(
               src1,       //1 bit source 1 (input)
               src2,       //1 bit source 2 (input)
               less,       //1 bit less     (input)
               A_invert,   //1 bit A_invert (input)
               B_invert,   //1 bit B_invert (input)
               cin,        //1 bit carry in (input)
               operation,  //operation      (input)
               result,     //1 bit result   (output)
               cout       //1 bit carry out(output)
               );

input         src1;
input         src2;
input         less;
input         A_invert;
input         B_invert;
input         cin;
input [2-1:0] operation;

output        result;
output        cout;

reg           result;

wire w1,w2,w3;
wand a1,a2;
wire r;

mux_2
    m1({~src1,src1},a1,A_invert),
	 m2({~src2,src2},a2,B_invert);
and
    and1(w1,a1,a2);

or 
    or1(w2,a1,a2);
add
    //A1(cin,cout,a1,a2,w3);
	 A1(a1,a2,cin,cout,w3);
mux
    //M1({w1,w2,w3,less},r,operation[1:0]);
	 M1({less,w3,w2,w1},r,operation[1:0]);

//assign r=result;	 
always@(r)begin
    result <= r;
end

endmodule
