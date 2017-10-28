`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:56:15 03/21/2017 
// Design Name: 
// Module Name:    register 
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
module register(
    din,
	 dout,
	 en
    );

input [31:0] din;
input en;
output [31:0] dout;
reg [31:0] dout;


always @(*)begin
    if(en)
	     dout <= din;
	 else 
	     dout <=dout;
end


endmodule
