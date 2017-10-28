//Subject:     CO project 2 - ALU Controller
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      0416111 0540112
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module ALU_Ctrl(
          funct_i,
          ALUOp_i,
          ALUCtrl_o,
			 shamt_select
			 //mux_jump_select
          );
          
//I/O ports 
input      [6-1:0] funct_i;
input      [3-1:0] ALUOp_i;

output     [4-1:0] ALUCtrl_o;    
output shamt_select;
//output mux_jump_select;     
//Internal Signals
reg        [4-1:0] ALUCtrl_o;
reg shamt_select;
//reg mux_jump_select;

//Main function
always@(funct_i,ALUOp_i)begin
case(ALUOp_i)
	0:begin
		case(funct_i)
			3:ALUCtrl_o<=4'b1000;
			7:ALUCtrl_o<=4'b1001;
			24:ALUCtrl_o<=4'b0101;	//mul
			32:ALUCtrl_o<=4'b0010;	//add
			34:ALUCtrl_o<=4'b0110;	//sub
			36:ALUCtrl_o<=4'b0000;	//and
			37:ALUCtrl_o<=4'b0001;	//or
			42:ALUCtrl_o<=4'b0100;	//slt
			//0:
		endcase
	end
	1:ALUCtrl_o<=4'b0111;	//beq
	2:ALUCtrl_o<=4'b0100;	//bltz
	3:ALUCtrl_o<=4'b0010;   //addi
	4:ALUCtrl_o<=4'b0011;	//sltiu
	5:ALUCtrl_o<=4'b0001;	//ori
	6:ALUCtrl_o<=4'b1011;	//lui
	7:ALUCtrl_o<=4'b1100;	//sgt  if rs>rt then result=1;
endcase	
//Select exact operation

if(ALUOp_i==0)begin
	if(funct_i==3)begin
		shamt_select<=1;
		//mux_jump_select<=1;
	end
	else if(funct_i==8)begin
		//mux_jump_select<=0;
		shamt_select<=0;
	end
	else begin
		shamt_select<=0;
		//mux_jump_select<=1;
	end
end
else begin
	shamt_select<=0;
	//mux_jump_select<=1;
end
end
endmodule     





                    
                    