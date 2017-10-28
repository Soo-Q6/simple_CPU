`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:59:32 03/18/2017 
// Design Name: 
// Module Name:    mux_2 
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
module mux_2(
    din,
	 dout,
	 option
    );
input [1:0] din;
input option;
output dout;
reg dout;

always@(*) begin
    if (option == 1'd0)begin
	     dout <= din[0];
	 end
	 else begin
	     dout <= din[1];
	 end
end

endmodule
