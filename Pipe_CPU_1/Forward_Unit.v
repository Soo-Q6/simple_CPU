//Subject:     CO project 4 - Pipe CPU 1
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module Forward_Unit(
		ID_EX_Rs,
		ID_EX_Rt,
		EX_MEM_RegWr,
		EX_MEM_Rd,
		MEM_WB_RegWr,
		MEM_WB_Rd,
		ForwardA,
		ForwardB
		);

input [5-1:0] ID_EX_Rs,ID_EX_Rt,EX_MEM_Rd,MEM_WB_Rd;
inout EX_MEM_RegWr,MEM_WB_RegWr;
output [2-1:0] ForwardA,ForwardB;
 
reg [2-1:0] ForwardA,ForwardB;
always @(*)begin
	if(EX_MEM_RegWr && EX_MEM_Rd!=0 && (EX_MEM_Rd==ID_EX_Rs))begin
		ForwardA<=2'b10;
	end
	else if(MEM_WB_RegWr && MEM_WB_Rd!=0 && (MEM_WB_Rd==ID_EX_Rs))begin
		ForwardA<=2'b01;
	end
	else begin
		ForwardA<=2'b00;
	end
	
	if(EX_MEM_RegWr && EX_MEM_Rd!=0 && (EX_MEM_Rd==ID_EX_Rt))begin
		ForwardB<=2'b10;
	end
	else if(MEM_WB_RegWr && MEM_WB_Rd!=0 && (MEM_WB_Rd==ID_EX_Rt))begin
		ForwardB<=2'b01;
	end
	else begin
		ForwardB<=2'b00;
	end
end 
endmodule	
	
