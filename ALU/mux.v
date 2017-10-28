`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:02:16 03/18/2017 
// Design Name: 
// Module Name:    mux 
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
module mux(
    din,
	 dout,
	 option
    );

input [4-1:0] din;
input [2-1:0] option;
output dout;
reg dout;

always @(*) begin
    case (option)
	     2'b00 : dout <= din[0];
		  2'b01 : dout <= din[1];
        2'b10 : dout <= din[2];
		  2'b11 : dout <= din[3];
	 endcase
end
endmodule
