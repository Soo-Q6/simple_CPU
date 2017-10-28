`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:08:58 03/22/2017 
// Design Name: 
// Module Name:    or_32 
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
module or_32(
    input [31:0] src,
    output res
    );
assign res=(src[0]||src[1]||src[2]||src[3]||src[4]||src[5]||src[6]||src[7]||src[8]||src[9]||src[10]||src[11]||src[12]||src[13]||src[14]||src[15]||src[16]||src[17]||src[18]||src[19]||src[20]||src[21]||src[22]||src[23]||src[24]||src[25]||src[26]||src[27]||src[28]||src[29]||src[30]||src[31]);


endmodule
