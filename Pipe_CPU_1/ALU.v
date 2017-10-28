//Subject:     CO project 2 - ALU
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      0416111 0540112
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module ALU(
    src1_i,
	src2_i,
	ctrl_i,
	result_o,
	zero_o
	);
     
//I/O ports
input  signed [32-1:0]  src1_i;
input  signed [32-1:0]	 src2_i;
input  [4-1:0]   ctrl_i;

output [32-1:0]	 result_o;
output           zero_o;

//Internal signals
reg    [32-1:0]  result_o;
wire             zero_o;
wire unsigned [32-1:0] tmp_slt;
wire  signed [32-1:0] tmp_slt1,tmp_sgt;
//Parameter
assign zero_o =(result_o==0);
assign tmp_slt1=src1_i-src2_i;
assign tmp_sgt=src2_i-src1_i;
assign tmp_slt={16'b0,src2_i[16-1:0]};
//Main function
always@(ctrl_i or src1_i or src2_i)begin
case(ctrl_i)
	0:result_o<=src1_i&src2_i;				//and
	1:result_o<=src1_i|src2_i;				//or
	2:result_o<=src1_i+src2_i;				//add
	3:result_o<=(src1_i<tmp_slt)?1:0;	//sltiu
	4:result_o<=($signed(src1_i)<$signed(src2_i))?1:0;		//slt 
	5:result_o<=src1_i*src2_i;				//mul
	6:result_o<=src1_i-src2_i;				//sub
	7:result_o<=src1_i==src2_i?0:1;		//beq
	8:result_o<=src2_i>>>src1_i[10:6];	//sra
	9:result_o<=src2_i>>>src1_i;			//srav
	10:result_o<=(src1_i!=src2_i)?0:1;		//bne
	11:result_o<=src2_i<<<16;	 			//lui
	12:result_o<=($signed(src1_i)>$signed(src2_i))?1:0;		//sgt tmp_sgt[31]
	default:result_o<=32'b0;
endcase
end
endmodule





                    
                    