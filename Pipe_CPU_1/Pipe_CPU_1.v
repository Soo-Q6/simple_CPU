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
module Pipe_CPU_1(
        clk_i,
		rst_i
		);
    
/****************************************
I/O ports
****************************************/
input clk_i;
input rst_i;

/****************************************
Internal signal
****************************************/
wire nclk;
wire fluse;
/**** IF stage ****/
wire [32-1:0] pc_data_in,pc_data_out,instr_out,pc_adder1;

/**** ID stage ****/

wire [64-1:0]	IF_ID_out;
wire [32-1:0] sign_extend_out,rt_out,rs_out;
//control signal
wire 	pc_write_o;
wire 	IF_ID_write;
wire 	frag_zero;
wire Regrite_out,ALUSrc_out,RegDst_out,Branch_out,MemRead_out,MemWrite_out,MemToReg_out;
wire [10-1:0] mux8_out;
wire [3-1:0] ALU_op_out;
wire IF_ID_fluse;
/**** EX stage ****/
wire [153-1:0] ID_EX_out;
wire [5-1:0] mux2_out;
wire [32-1:0] mux3_out,mux4_out,pc_adder2,ALU_out,shift_left_out,mux6_out,mux7_out;
wire [4-1:0] ALUCtrl_out;
wire [2-1:0] ForwardA_out,ForwardB_out;
//control signal
wire zero;

/**** MEM stage ****/
wire [107-1:0] EX_MEM_out;
wire [32-1:0] DM_out;
wire [5-1:0] mux9_out;
//control signal
wire zero_branch_out;
wire EX_MEM_fluse;


/**** WB stage ****/
wire [71-1:0] MEM_WB_out;
wire [32-1:0] mux5_out;
//control signal

/****************************************
Instnatiate modules
****************************************/
//assign nclk=~clk_i;
//Instantiate the components in IF stage
not not1(nclk,clk_i);
MUX_2to1 #(.size(32)) Mux1(
        .data0_i(pc_adder1),
        .data1_i(EX_MEM_out[36:5]),
        .select_i(zero_branch_out),
        .data_o(pc_data_in)

		);
and and2(fluse,IF_ID_fluse,rst_i);

ProgramCounter PC(
        .clk_i(clk_i),      
	    .rst_i (rst_i),     
		 .pc_write_i(pc_write_o),
	    .pc_in_i(pc_data_in) ,   
	    .pc_out_o(pc_data_out) 
	    );

Instr_Memory IM(
        .pc_addr_i(pc_data_out),  
	    .instr_o(instr_out)    
	    );

Adder Add_pc1(
        .src1_i(4),     
	    .src2_i(pc_data_out),     
	    .sum_o(pc_adder1)
		);

Hazard_Detect_Unit HDU(
		.PC_write(pc_write_o),
		.IF_ID_write(IF_ID_write),
		.Frag_zero(frag_zero),
		.IF_ID_Rt(IF_ID_out[52:48]),
		.IF_ID_Rs(IF_ID_out[57:53]),
		.ID_EX_Rt(ID_EX_out[147:143]),
		.ID_EX_MR(ID_EX_out[3]),
		.Branch_i(zero_branch_out),
		.IF_ID_fluse(IF_ID_fluse),
		.EX_MEM_fluse(EX_MEM_fluse)
		);
		
Pipe_Reg #(.size(64)) IF_ID(       //N is the total length of input/output
    .clk_i(clk_i),
	.rst_i(fluse),
	.data_write_i(IF_ID_write),
	.data_i({instr_out,pc_adder1}),
	.data_o(IF_ID_out)
		);

//Instantiate the components in ID stage
Reg_File RF(
        .clk_i(clk_i),      
	    .rst_i(rst_i) ,     
        .RSaddr_i(IF_ID_out[57:53]) ,  
        .RTaddr_i(IF_ID_out[52:48]) ,  
        .RDaddr_i(MEM_WB_out[70:66]) ,  
        .RDdata_i(mux5_out), 
        .RegWrite_i (MEM_WB_out[0]),
        .RSdata_o(rs_out) ,  
        .RTdata_o(rt_out) 
		);

Decoder Control(
        .instr_op_i(IF_ID_out[63:58]), 
	    .RegWrite_o(RegWrite_out), 
	    .ALU_op_o(ALU_op_out),   
	    .ALUSrc_o(ALUSrc_out),   
	    .RegDst_o(RegDst_out),   
		.Branch_o(Branch_out),
		//.Branch_Type_o(Branch_Type_out),
		//.Jump_o(Jump_out),
		.MemRead_o(MemRead_out),
		.MemWrite_o(MemWrite_out),
		.MemToReg_o(MemToReg_out)
		);
		
MUX_2to1 #(.size(10)) Mux8(
               .data0_i(10'b0),
               .data1_i({RegDst_out,ALUSrc_out,ALU_op_out,MemWrite_out,MemRead_out,Branch_out,MemToReg_out,RegWrite_out}),
               .select_i(frag_zero),
               .data_o(mux8_out)
        );

Sign_Extend Sign_Extend(
        .data_i(IF_ID_out[47:32]),
        .data_o(sign_extend_out)
		);	

Pipe_Reg #(.size(153)) ID_EX(
    .clk_i(nclk),
	.rst_i(rst_i),
	.data_write_i(1),
	.data_i({IF_ID_out[57:53],IF_ID_out[52:43],sign_extend_out,rt_out,rs_out,IF_ID_out[31:0],mux8_out}),
	.data_o(ID_EX_out)
		);

Forward_Unit  FU(
		.ID_EX_Rs(IF_ID_out[57:53]),
		.ID_EX_Rt(IF_ID_out[52:48]),
		.EX_MEM_RegWr(EX_MEM_out[0]),
		.EX_MEM_Rd(EX_MEM_out[106:102]),
		.MEM_WB_RegWr(MEM_WB_out[0]),
		.MEM_WB_Rd(MEM_WB_out[70:66]),
		.ForwardA(ForwardA_out),
		.ForwardB(ForwardB_out)
		);
//Instantiate the components in EX stage	   
ALU ALU(
    .src1_i(mux4_out),
	.src2_i(mux3_out),
	.ctrl_i(ALUCtrl_out),
	.result_o(ALU_out),
	.zero_o(zero)
		);

ALU_Ctrl ALU_Ctrl(
          .funct_i(ID_EX_out[111:106]),
          .ALUOp_i(ID_EX_out[7:5]),
          .ALUCtrl_o(ALUCtrl_out),
			 .shamt_select(shamt_select_out)
			 //.mux_jump_select()
		);

MUX_2to1 #(.size(5)) Mux2(
               .data0_i(ID_EX_out[147:143]),
               .data1_i(ID_EX_out[142:138]),
               .select_i(ID_EX_out[9]),
               .data_o(mux2_out)
        );
		  
Shift_Left_Two_32  shift_left(
    .data_i(ID_EX_out[137:106]),
    .data_o(shift_left_out)
    );
	 
Adder Add_pc2(
        .src1_i(shift_left_out),     
	    .src2_i(ID_EX_out[41:10]),     
	    .sum_o(pc_adder2)
		);
MUX_4to1 #(.size(32)) Mux6(
               .data00_i(ID_EX_out[105:74]),
               .data01_i(mux5_out),
               .data10_i(EX_MEM_out[69:38]),
               .data11_i(0),
               .select_i(ForwardB_out),
               .data_o(mux6_out)
        );
		  
MUX_4to1 #(.size(32)) Mux7(
               .data00_i(ID_EX_out[73:42]),
               .data01_i(mux5_out),
               .data10_i(EX_MEM_out[69:38]),
               .data11_i(0),
               .select_i(ForwardA_out),
               .data_o(mux7_out)
        );
MUX_2to1 #(.size(32)) Mux3(
               .data0_i(mux6_out),
               .data1_i(ID_EX_out[137:106]),
               .select_i(ID_EX_out[8]),
               .data_o(mux3_out)
        );
		  
MUX_2to1 #(.size(32)) Mux4(
               .data0_i(mux7_out),
               .data1_i(ID_EX_out[137:106]),
               .select_i(shamt_select_out),
               .data_o(mux4_out)
        );
		  
MUX_2to1 #(.size(5)) Mux9(
               .data0_i(5'b0),
               .data1_i(ID_EX_out[4:0]),
               .select_i(EX_MEM_fluse),
               .data_o(mux9_out)
        );
		  
		  
Pipe_Reg #(.size(107)) EX_MEM(
    .clk_i(clk_i),
	.rst_i(rst_i),
	.data_write_i(1),
	.data_i({mux2_out,ID_EX_out[105:74],ALU_out,zero,pc_adder2,mux9_out}),
	.data_o(EX_MEM_out)
		);

//Instantiate the components in MEM stage
Data_Memory DM(
	.clk_i(clk_i),
	.addr_i(EX_MEM_out[69:38]),
	.data_i(EX_MEM_out[101:70]),
	.MemRead_i(EX_MEM_out[3]),
	.MemWrite_i(EX_MEM_out[4]),
	.data_o(DM_out)
	    );

and and1(zero_branch_out,EX_MEM_out[37],EX_MEM_out[2]);

Pipe_Reg #(.size(71)) MEM_WB(
    .clk_i(clk_i),
	.rst_i(rst_i),
	.data_write_i(1),
	.data_i({EX_MEM_out[106:102],EX_MEM_out[69:38],DM_out,EX_MEM_out[1:0]}),
	.data_o(MEM_WB_out)        
		);

//Instantiate the components in WB stage
MUX_2to1 #(.size(32)) Mux5(
               .data0_i(MEM_WB_out[65:34]),
               .data1_i(MEM_WB_out[33:2]),
               .select_i(MEM_WB_out[1]),
               .data_o(mux5_out)
        );

/****************************************
signal assignment
****************************************/	
endmodule

