//Subject:     CO project 2 - Simple Single CPU
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      0416111 0540112
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
module Simple_Single_CPU(
        clk_i,
		rst_i
		);
		
//I/O port
input         clk_i;
input         rst_i;
wire reg_write,alusrc_out,regdst_out,branch_out,zero,branch_select,branch_type_out,shamt_select,jump_out,memread_out,memwrite_out;
wire [32-1:0] pc_data_in,pc_data_out,pc_adder1,pc_adder2,instr_out,rs_out,rt_out,sign_extend_out,alu_in,alu_out,sl2_out,src1_select_in;
wire [32-1:0] jump_address,mem_out,reg_write_source_out,mux_pc_source_out,mux_jump_o;
wire [5-1:0] rd_select_out,mux_jal;
wire [3-1:0] alu_op_out;
wire [4-1:0] alu_ctr_out;
wire not_zero_out,not_sign_out,nor_zero_sign_out;
wire [1:0] memtoreg_out,branch_type_select_out;
wire mux_jal_i,mux_j,regwrite_c;
//Internal Signles


//Greate componentes
ProgramCounter PC(
        .clk_i(clk_i),      
	    .rst_i (rst_i),     
	    .pc_in_i(pc_data_in) ,   
	    .pc_out_o(pc_data_out) 
	    );
	
Adder Adder1(
        .src1_i(4),     
	    .src2_i(pc_data_out),     
	    .sum_o(pc_adder1)    
	    );

	
Instr_Memory IM(
        .pc_addr_i(pc_data_out),  
	    .instr_o(instr_out)    
	    );
		 		
Shift_Left_Two_32 Shifter1(
        .data_i(instr_out),
        .data_o(jump_address)
        );
		  
MUX_2to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(instr_out[20:16]),
        .data1_i(instr_out[15:11]),
        .select_i(regdst_out),
        .data_o(rd_select_out)
        );
and and0(mux_jal_i,memtoreg_out[0],memtoreg_out[1]);

MUX_2to1 #(.size(5)) Mux_Jal(
        .data0_i(rd_select_out),
        .data1_i(5'b11111),
        .select_i(mux_jal_i),
        .data_o(mux_jal)
        );	  
and and1(regwrite_c,reg_write,mux_j);		
Reg_File RF(
        .clk_i(clk_i),      
	    .rst_i(rst_i) ,     
        .RSaddr_i(instr_out[25:21]) ,  
        .RTaddr_i(instr_out[20:16]) ,  
        .RDaddr_i(mux_jal) ,  
        .RDdata_i(reg_write_source_out), 
        .RegWrite_i (regwrite_c),
        .RSdata_o(rs_out) ,  
        .RTdata_o(rt_out)   
        );
	
Decoder Decoder(
        .instr_op_i(instr_out[31:26]), 
	    .RegWrite_o(reg_write), 
	    .ALU_op_o(alu_op_out),   
	    .ALUSrc_o(alusrc_out),   
	    .RegDst_o(regdst_out),   
		.Branch_o(branch_out),
		.Branch_Type_o(branch_type_select_out),
		.Jump_o(jump_out),
		.MemRead_o(memread_out),
		.MemWrite_o(memwrite_out),
		.MemToReg_o(memtoreg_out)   
	    );

ALU_Ctrl AC(
        .funct_i(instr_out[5:0]),   
        .ALUOp_i(alu_op_out),   
        .ALUCtrl_o(alu_ctr_out),
		  .shamt_select(shamt_select),
		  .mux_jump_select(mux_j)
        );

MUX_2to1 #(.size(32)) Mux_shamt(
        .data0_i(rs_out),
        .data1_i(sign_extend_out),
        .select_i(shamt_select),
        .data_o(src1_select_in)
        );	
			
Sign_Extend SE(
        .data_i(instr_out[15:0]),
        .data_o(sign_extend_out)
        );

MUX_2to1 #(.size(32)) Mux_ALUSrc(
        .data0_i(rt_out),
        .data1_i(sign_extend_out),
        .select_i(alusrc_out),
        .data_o(alu_in)
        );	
		
ALU ALU(
        .src1_i(src1_select_in),
	    .src2_i(alu_in),
	    .ctrl_i(alu_ctr_out),
	    .result_o(alu_out),
		.zero_o(zero)
	    );

Data_Memory Data_Memory
(
	.clk_i(clk_i),
	.addr_i(alu_out),
	.data_i(rt_out),
	.MemRead_i(memread_out),
	.MemWrite_i(memwrite_out),
	.data_o(mem_out)
);
		
Adder Adder2(
        .src1_i(pc_adder1),     
	    .src2_i(sl2_out),     
	    .sum_o(pc_adder2)      
	    );
		
Shift_Left_Two_32 Shifter2(
        .data_i(sign_extend_out),
        .data_o(sl2_out)
        ); 		
		
MUX_2to1 #(.size(32)) Mux_PC_Source(
        .data0_i(pc_adder1),
        .data1_i(pc_adder2),
        .select_i(branch_select),
        .data_o(mux_pc_source_out)
        );	

and and2(branch_select,branch_out,branch_type_out);
not not_zero(not_zero_out,zero);
not not_sign(not_sign_out,alu_out[31]);
nor nor_zero_sign(nor_zero_sign_out,zero,alu_out[31]);

MUX_4to1 #(.size(1)) Branch_Type_Select(
               .data00_i(zero),
               .data01_i(nor_zero_sign_out),
               .data10_i(not_sign_out),
               .data11_i(not_zero_out),
               .select_i(branch_type_select_out),
               .data_o(branch_type_out)
               );
					
MUX_4to1 #(.size(32)) Reg_Write_Source(
               .data00_i(alu_out),
               .data01_i(mem_out),
               .data10_i(sign_extend_out),
               .data11_i(pc_adder1),
               .select_i(memtoreg_out),
               .data_o(reg_write_source_out)
               );
					
MUX_2to1 #(.size(32)) Mux_Jump(
               .data0_i(rs_out),			//{pc_adder1[31:28],jump_address[27:0]}
               .data1_i(mux_jump_o),
               .select_i(mux_j),
               .data_o(pc_data_in)					//mux_jump_o
               );

MUX_2to1 #(.size(32)) Jump_Address_Source(
               .data0_i(mux_pc_source_out),
               .data1_i({pc_adder1[31:28],jump_address[27:0]}),					//mux_jump_o
               .select_i(jump_out),
               .data_o(mux_jump_o)												//pc_data_in
               );


endmodule
		  


