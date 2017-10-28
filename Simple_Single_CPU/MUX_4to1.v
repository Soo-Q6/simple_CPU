//Subject:     CO project 2 - MUX 221
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      0416111 0540112
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
     
module MUX_4to1(
               data00_i,
               data01_i,
               data10_i,
               data11_i,
               select_i,
               data_o
               );

parameter size = 0;			   
			
//I/O ports               
input   [size-1:0] data00_i;          
input   [size-1:0] data10_i;               
input   [size-1:0] data01_i;          
input   [size-1:0] data11_i;
input   [2-1:0]    select_i;
output  [size-1:0] data_o; 

//Internal Signals
reg     [size-1:0] data_o;
//Main function
always @(select_i,data00_i,data01_i,data10_i,data11_i)begin
case(select_i)
	2'b00:data_o<=data00_i;
	2'b01:data_o<=data01_i;
	2'b10:data_o<=data10_i;
	2'b11:data_o<=data11_i;
endcase
end

endmodule 