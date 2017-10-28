//Subject:     CO project 2 - Decoder
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      0416111 0540112
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module Decoder(
    instr_op_i,
	RegWrite_o,
	ALU_op_o,
	ALUSrc_o,
	RegDst_o,
	Branch_o,
	Branch_Type_o,
	Jump_o,
	MemRead_o,
	MemWrite_o,
	MemToReg_o
	);
     
//I/O ports
input  [6-1:0] instr_op_i;  //op_field

output         RegWrite_o;   //write Rd
output [3-1:0] ALU_op_o;		//
output         ALUSrc_o;		//immediate or not
output         RegDst_o;		//choose the rd,regdst=1?rd:rt
output         Branch_o;		//when brach=0,no branch;
output [2-1:0]	Branch_Type_o;
output			Jump_o;			//jump if Jump_o=1;
output 			MemRead_o;
output			MemWrite_o;
output [2-1:0]	MemToReg_o;		//if 1 then mem to reg else alu result to reg;
 
//Internal Signals
reg   [3-1:0]  ALU_op_o;
reg            ALUSrc_o;
reg            RegWrite_o;
reg            RegDst_o;
reg            Branch_o;
reg   [2-1:0]	Branch_Type_o;
reg				Jump_o;
reg 				MemRead_o;
reg				MemWrite_o;
reg	[2-1:0]	MemToReg_o;

//Main function
always@(instr_op_i)begin
case(instr_op_i)
	0:begin							//R-type
		RegWrite_o<=1;	
		ALU_op_o<=3'b000;
		ALUSrc_o<=0;
		RegDst_o<=1;
		Branch_o<=0;
		Branch_Type_o<=2'b00;
		Jump_o<=0;
		MemRead_o<=0;
		MemWrite_o<=0;
		MemToReg_o<=2'b00;
	end
	1:begin							//bltz
		RegWrite_o<=0;	
		ALU_op_o<=3'b010;			//slt:if rs<rt then alu_out=1 and zero=0;
		ALUSrc_o<=0;
		RegDst_o<=1;				//not interested.
		Branch_o<=1;
		Branch_Type_o<=2'b11;	//if rs<0 then zero=0 so that branch_type_oout=1 and then branch...
		Jump_o<=0;
		MemRead_o<=0;
		MemWrite_o<=0;
		MemToReg_o<=2'b00;		//not interested...
	end
	2:begin							//J
		RegWrite_o<=0;	
		ALU_op_o<=3'b001;
		ALUSrc_o<=0;
		RegDst_o<=1;
		Branch_o<=0;
		Branch_Type_o<=2'b00;
		Jump_o<=1;
		MemRead_o<=0;
		MemWrite_o<=0;
		MemToReg_o<=2'b00;
	end
	3:begin							//Jal
		RegWrite_o<=1;	
		ALU_op_o<=3'b001;
		ALUSrc_o<=0;
		RegDst_o<=1;
		Branch_o<=0;
		Branch_Type_o<=2'b00;
		Jump_o<=1;
		MemRead_o<=0;
		MemWrite_o<=0;
		MemToReg_o<=2'b11;
	end
	4:begin							//BEQ
		RegWrite_o<=0;
		ALU_op_o<=3'b001;
		ALUSrc_o<=0;
		RegDst_o<=0;
		Branch_o<=1;
		Branch_Type_o<=2'b00;
		Jump_o<=0;
		MemRead_o<=0;
		MemWrite_o<=0;
		MemToReg_o<=2'b00;
	end
	5:begin							//BNE and bnez
		RegWrite_o<=0;
		ALU_op_o<=3'b001;
		ALUSrc_o<=0;
		RegDst_o<=0;
		Branch_o<=1;
		Branch_Type_o<=2'b11;
		Jump_o<=0;
		MemRead_o<=0;
		MemWrite_o<=0;
		MemToReg_o<=2'b00;
	end
	6:begin							//ble if rs<=rt then branch
		RegWrite_o<=0;
		ALU_op_o<=3'b111;
		ALUSrc_o<=0;
		RegDst_o<=0;				//not interested
		Branch_o<=1;
		Branch_Type_o<=2'b00;
		Jump_o<=0;
		MemRead_o<=0;
		MemWrite_o<=0;
		MemToReg_o<=2'b00;
	end
	8:begin							//ADDI
		RegWrite_o<=1;
		ALU_op_o<=3'b011;
		ALUSrc_o<=1;
		RegDst_o<=0;
		Branch_o<=0;
		Branch_Type_o<=2'b00;
		Jump_o<=0;
		MemRead_o<=0;
		MemWrite_o<=0;
		MemToReg_o<=2'b00;
	end
	9:begin							//SLTIU
		RegWrite_o<=1;
		ALU_op_o<=3'b100;
		ALUSrc_o<=1;
		RegDst_o<=0;
		Branch_o<=0;
		Branch_Type_o<=2'b00;
		Jump_o<=0;
		MemRead_o<=0;
		MemWrite_o<=0;
		MemToReg_o<=2'b00;
	end
	13:begin							//ORI
		RegWrite_o<=1;
		ALU_op_o<=3'b101;
		ALUSrc_o<=1;
		RegDst_o<=0;
		Branch_o<=0;
		Branch_Type_o<=2'b00;
		Jump_o<=0;
		MemRead_o<=0;
		MemWrite_o<=0;
		MemToReg_o<=2'b00;
	end
	15:begin							//LUI and li?
		RegWrite_o<=1;
		ALU_op_o<=3'b110;
		ALUSrc_o<=1;
		RegDst_o<=0;
		Branch_o<=0;
		Branch_Type_o<=2'b00;
		Jump_o<=0;
		MemRead_o<=0;
		MemWrite_o<=0;
		MemToReg_o<=2'b00;
	end
	35:begin							//LW
		RegWrite_o<=1;
		ALU_op_o<=3'b011;
		ALUSrc_o<=1;
		RegDst_o<=0;
		Branch_o<=0;
		Branch_Type_o<=2'b00;
		Jump_o<=0;
		MemRead_o<=1;
		MemWrite_o<=0;
		MemToReg_o<=2'b01;
	end	
	43:begin							//SW
		RegWrite_o<=0;
		ALU_op_o<=3'b011;
		ALUSrc_o<=1;
		RegDst_o<=0;
		Branch_o<=0;
		Branch_Type_o<=2'b00;
		Jump_o<=0;
		MemRead_o<=0;
		MemWrite_o<=1;
		MemToReg_o<=2'b00;
	end
endcase
end
		


endmodule





                    
                    