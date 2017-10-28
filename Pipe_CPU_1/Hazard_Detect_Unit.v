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

module Hazard_Detect_Unit(
		PC_write,
		IF_ID_write,
		Frag_zero,
		IF_ID_Rt,
		IF_ID_Rs,
		ID_EX_Rt,
		ID_EX_MR,
		Branch_i,
		IF_ID_fluse,
		EX_MEM_fluse
		);
		
output	reg	PC_write;
output	reg	IF_ID_write;
output	reg	Frag_zero;
input	 [5-1:0]	IF_ID_Rt;
input	 [5-1:0]	IF_ID_Rs;
input	 [5-1:0]	ID_EX_Rt;
input				ID_EX_MR;
input				Branch_i;
output	reg	IF_ID_fluse;
output	reg	EX_MEM_fluse;
always @(*)begin
	if(ID_EX_MR && ((ID_EX_Rt==IF_ID_Rt) || (ID_EX_Rt==IF_ID_Rs)))begin
		Frag_zero<=0;
		PC_write<=0;
		IF_ID_write<=0;
	end 
	else begin
		if(Branch_i)begin
			Frag_zero<=0;
		end 
		else begin
			Frag_zero<=1;
		end
		PC_write<=1;
		IF_ID_write<=1;	
	end
		if(Branch_i)begin
			//Frag_zero<=0;
			IF_ID_fluse<=0;
			EX_MEM_fluse<=0;
		end 
		else begin
			//Frag_zero<=1;
			IF_ID_fluse<=1;
			EX_MEM_fluse<=1;
		end
end
endmodule
