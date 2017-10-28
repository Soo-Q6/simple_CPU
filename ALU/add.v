`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:37:56 03/18/2017 
// Design Name: 
// Module Name:    add 
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
module add(
    src1,
	 src2,
	 cin,
	 cout,
	 result
    );

input src1,src2,cin;
output cout, result;
//reg cout,result;

assign result = (src1 ^ src2 ^ cin);
assign cout = (src1 && src2) || (cin && (src1 ^ src2));
/*always @(*) begin
    result <= (src1 ^ src2 ^ cin);
	 cout <= (src1 && src2) || (cin && (src1 ^ src2)); 
end*/

endmodule
