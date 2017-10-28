//Subject:     CO project 4 - Pipe Register
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
module Pipe_Reg(
    clk_i,
	rst_i,
	data_write_i,
	data_i,
	data_o
	);

parameter size = 0;

input					clk_i;		  
input					rst_i;
input 				data_write_i;
input		[size-1: 0]	data_i;
output reg	[size-1: 0]	data_o;

always @(posedge clk_i) begin
    if(~rst_i)
        data_o <= 0;
    else
		if(data_write_i)begin
			data_o <= data_i;
		end
		else begin
			data_o<=data_o;
		end
end

endmodule	