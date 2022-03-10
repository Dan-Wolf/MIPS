











module MIPS_Pipelined (
    input wire clk,
    input wire resetN
);

    logic [31:0] PC, PC_4_IF, PC_next;
    assign PC_4_IF = (resetN) ? PC + 32'h0000_0004 : 32'h0000_0000;

    always @(posedge clk or negedge resetN) begin 
        if (~resetN) 
            PC <= 32'b0;
        else 
            PC <= PC_next;
    end 

//----------------------------------------------------------------------------
//  IF 
//----------------------------------------------------------------------------

    // Instruction Memory
    logic   [31:0]  instruction_IF, instruction_ID;
    logic   [31:0]  PC_4_ID;

    instruction_mem inst_mem(
        .PC             (PC),
        .resetN         (resetN),
        .instruction    (instruction_IF)
    );

    // IF/ID Register
    pipeline_reg #(64) IF_ID_reg (
        .clk        (clk),
        .resetN     (resetN),
        .data_in    ({PC_4_IF, instruction_IF}),
        .data_out   ({PC_4_ID, instruction_ID})
    );

//----------------------------------------------------------------------------
//  ID 
//----------------------------------------------------------------------------

    // Control Unit
    wire            RegDst_ID, Jump_ID, Branch_ID, MemRead_ID, MemtoReg_ID, MemWrite_ID, ALUSrc_ID, RegWrite_ID;
    logic   [1:0]   ALUOp_ID;
    wire    [5:0]   opCode;

    assign opCode = instruction_ID[31:26];  

    control control_0(
        .opCode       (opCode),
        .resetN       (resetN),
        .RegDst       (RegDst_ID),
        .Jump         (Jump_ID),
        .Branch       (Branch_ID),
        .MemRead      (MemRead_ID),
        .MemtoReg     (MemtoReg_ID),
        .MemWrite     (MemWrite_ID),
        .ALUSrc       (ALUSrc_ID),
        .RegWrite     (RegWrite_ID),
        .ALUOp        (ALUOp_ID)
    );

    // Registers 
    logic   [31:0]  regData1_ID, regData2_ID, wrData;
    logic   [4:0]   rdReg1, rdReg2, wrReg_WB;
    logic           RegWrite_WB;

    assign rdReg1 = instruction_ID[25:21];
    assign rdReg2 = instruction_ID[20:16];

    register_mem regMem(
        .clk       (clk),
        .regWrite  (RegWrite_WB),
        .resetN    (resetN),
        .rdReg1    (rdReg1),
        .rdReg2    (rdReg2),
        .wrReg     (wrReg_WB),
        .wrData    (wrData),
        .data1     (regData1_ID),
        .data2     (regData2_ID)
    );

    // Sign Extend Immediate Field
    logic   [31:0] imdtVal_ID;
    assign imdtVal_ID = {{16{instruction_ID[15]}}, instruction_ID[15:0]};

    // Pass RT and RD to next stage
    logic   [4:0] RT_ID, RD_ID;
    assign RT_ID = instruction_ID[20:16];
    assign RD_ID = instruction_ID[15:11];

    // PC Jump
    logic [31:0]    PC_jump_ID;
    assign PC_jump_ID = {PC_4_ID[31:28], instruction_ID[25:0], 2'b00};


    // ID/EX Register
    logic [31:0]    PC_4_EX, PC_jump_EX, regData1_EX, regData2_EX, imdtVal_EX;
    logic [4:0]     RT_EX, RD_EX;
    logic [1:0]     ALUOp_EX;
    logic           RegDst_EX, Jump_EX, Branch_EX, MemRead_EX, MemtoReg_EX, MemWrite_EX, ALUSrc_EX, RegWrite_EX;

    pipeline_reg #(180) ID_EX_reg (
        .clk        (clk),
        .resetN     (resetN),
        .data_in    ({PC_4_ID, PC_jump_ID, regData1_ID, regData2_ID, imdtVal_ID, RT_ID, RD_ID, RegDst_ID, Jump_ID, Branch_ID, MemRead_ID, MemtoReg_ID, MemWrite_ID, ALUSrc_ID, RegWrite_ID, ALUOp_ID}),
        .data_out   ({PC_4_EX, PC_jump_EX, regData1_EX, regData2_EX, imdtVal_EX, RT_EX, RD_EX, RegDst_EX, Jump_EX, Branch_EX, MemRead_EX, MemtoReg_EX, MemWrite_EX, ALUSrc_EX, RegWrite_EX, ALUOp_EX})
    );

//----------------------------------------------------------------------------
//  EX 
//----------------------------------------------------------------------------

    // ALU Control 
    logic   [3:0]   ALUCtl;
    logic   [5:0]   funct;

    assign funct = imdtVal_EX[5:0];

    ALUControl ALUCtrl(
        .ALUOp   (ALUOp_EX),
        .funct   (funct),
        .ALUCtl  (ALUCtl)
    );

    // ALU
    logic           zero_EX;
    logic   [31:0]  operand_A, operand_B, ALU_Out_EX;

    assign operand_A = regData1_EX;
    assign operand_B = ALUSrc_EX ? imdtVal_EX : regData2_EX;

    ALU alu(
        .A      (operand_A),
        .B      (operand_B),
        .opCode (ALUCtl),
        .ALU_Out(ALU_Out_EX),
        .zero   (zero_EX)
    );

    // PC Branch
    logic [31:0] PC_branch_EX;
    assign PC_branch_EX = {imdtVal_EX[29:0], 2'b00} + PC_4_EX;

    // wrReg
    logic [4:0] wrReg_EX;
    assign wrReg_EX = RegDst_EX ? RD_EX : RT_EX;

    // EX/MEM Register
    logic [31:0]    PC_branch_MEM, PC_jump_MEM, ALU_Out_MEM, regData2_MEM;
    logic [4:0]     wrReg_MEM;
    logic           zero_MEM, Jump_MEM, Branch_MEM, MemRead_MEM, MemtoReg_MEM, MemWrite_MEM, RegWrite_MEM;

    pipeline_reg #(140) EX_MEM_reg (
        .clk        (clk),
        .resetN     (resetN),
        .data_in    ({PC_branch_EX, PC_jump_EX, ALU_Out_EX, zero_EX, regData2_EX, wrReg_EX, Jump_EX, Branch_EX, MemRead_EX, MemtoReg_EX, MemWrite_EX, RegWrite_EX}),
        .data_out   ({PC_branch_MEM, PC_jump_MEM, ALU_Out_MEM, zero_MEM, regData2_MEM, wrReg_MEM, Jump_MEM, Branch_MEM, MemRead_MEM, MemtoReg_MEM, MemWrite_MEM, RegWrite_MEM})
    );

//----------------------------------------------------------------------------
//  MEM 
//----------------------------------------------------------------------------

    // PC_next Logic 
    logic b_and_z;
    assign b_and_z = Branch_MEM & zero_MEM;

    logic [31:0] PC_4_branch;
    assign PC_4_branch = b_and_z ? PC_branch_MEM : PC_4_IF;
    assign PC_next = Jump_MEM ? PC_jump_MEM : PC_4_branch;

    // Data Memory 
    logic [31:0] dMem_addr, dMem_wrData, dMem_data_MEM;
    
    assign dMem_addr = ALU_Out_MEM;
    assign dMem_wrData = regData2_MEM;

    dataMemory dMem(
        .clk        (clk),
        .resetN     (resetN),
        .address    (dMem_addr),
        .wrData     (dMem_wrData),
        .MemWrite   (MemWrite_MEM),
        .MemRead    (MemRead_MEM),
        .readData   (dMem_data_MEM)
    );

    // MEM/WB Register
    logic [31:0]    dMem_data_WB, ALU_Out_WB;
    logic           MemtoReg_WB;

    pipeline_reg #(140) MEM_WB_reg (
        .clk        (clk),
        .resetN     (resetN),
        .data_in    ({dMem_data_MEM, ALU_Out_MEM, wrReg_MEM, MemtoReg_MEM, RegWrite_MEM}),
        .data_out   ({dMem_data_WB, ALU_Out_WB, wrReg_WB, MemtoReg_WB, RegWrite_WB})
    );

//----------------------------------------------------------------------------
//  WB
//----------------------------------------------------------------------------

    assign wrData = MemtoReg_WB ? dMem_data_WB : ALU_Out_WB;

endmodule 