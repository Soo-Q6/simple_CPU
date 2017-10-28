`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:47:33 03/22/2017 
// Design Name: 
// Module Name:    compare 
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
module compare(
    input [2:0] comp,
    input less,
    input equal,
    output result
    );
reg result;

always@(*)begin
    case (comp)
	     3'b000 : result<=less;
		  3'b001 : result<=(~less)&&(~equal);
		  3'b010 : result<=less || equal;
		  3'b011 : result<=~less;
		  3'b110 : result<=equal;
		  3'b100 : result<=~equal;
		  default : result<=1'bz;
	 endcase
end
endmodule
