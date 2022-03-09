/*
Filename:       MIPS_top.sv
Author:         DTW
Date:           11/17/2021
Description:    This module is the top level entity. All submodules of the MIPS are connected 
                in this file. 
                
                Instrucions supported: add, sub, and, or, nor, slt, lw, sw, addi, beq, j
*/

//=================================================================================================

module MIPS_top (   input   wire    clk,
                input   wire    resetN
);

    // Program Counter
    logic   [31:0]  PC, PC_next, PC_4, PC_branch, PC_jump, PC_4_branch;

    always @(posedge clk or negedge resetN) begin 
        if (~resetN) 
            PC <= 32'b0;
        else 
            PC <= PC_next;
    end 

    
    // Instruction Memory
    logic   [31:0]  instruction;

    instruction_mem inst_mem(
        .PC            (PC),
        .resetN        (resetN),
        .instruction   (instruction)
    );

    // Control 
    wire           RegDst, Jump, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
    logic   [1:0]   ALUOp;
    wire    [5:0]   opCode;

    assign opCode = instruction[31:26];        

    control control_0(
        .opCode       (opCode),
        .resetN       (resetN),
        .RegDst       (RegDst),
        .Jump         (Jump),
        .Branch       (Branch),
        .MemRead      (MemRead),
        .MemtoReg     (MemtoReg),
        .MemWrite     (MemWrite),
        .ALUSrc       (ALUSrc),
        .RegWrite     (RegWrite),
        .ALUOp        (ALUOp)
    );

    // Registers
    logic   [31:0]  regData1, regData2, regWriteData;
    logic   [4:0]   wrReg, rdReg1, rdReg2;

    assign wrReg = RegDst ? instruction[15:11] : instruction[20:16];
    assign rdReg1 = instruction[25:21];
    assign rdReg2 = instruction[20:16];

    register_mem regMem(
        .clk       (clk),
        .regWrite  (RegWrite),
        .resetN    (resetN),
        .rdReg1    (rdReg1),
        .rdReg2    (rdReg2),
        .wrReg     (wrReg),
        .wrData    (regWriteData),
        .data1     (regData1),
        .data2     (regData2)
    );

    // Sign Extend Immediate Field
    logic   [31:0] imdtVal;
    assign imdtVal = {{16{instruction[15]}}, instruction[15:0]};

    // ALU Control 
    logic   [3:0]   ALUCtl;
    logic   [5:0]   funct;

    assign funct = instruction[5:0];

    ALUControl ALUCtrl(
        .ALUOp   (ALUOp),
        .funct   (funct),
        .ALUCtl  (ALUCtl)
    );

    // ALU
    logic           zero;
    logic   [31:0]  operand_A, operand_B, ALU_Out;

    assign operand_A = regData1;
    assign operand_B = ALUSrc ? imdtVal : regData2;

    ALU alu(
        .A      (operand_A),
        .B      (operand_B),
        .opCode (ALUCtl),
        .ALU_Out(ALU_Out),
        .zero   (zero)
    );

    // Data Memory
    logic [31:0] dMem_addr, dMem_wrData, dMem_data;
    
    assign dMem_addr = ALU_Out;
    assign dMem_wrData = regData2;

    dataMemory dMem(
        .clk        (clk),
        .resetN     (resetN),
        .address    (dMem_addr),
        .wrData     (dMem_wrData),
        .MemWrite   (MemWrite),
        .MemRead    (MemRead),
        .readData   (dMem_data)
    );

    assign regWriteData = MemtoReg ? dMem_data : ALU_Out;

    // PC_next Logic
    assign PC_4 = (resetN) ? PC + 32'h0000_0004 : 32'h0000_0000;   // Increment PC Counter 
    assign PC_branch = {imdtVal[29:0], 2'b00} + PC_4;
    assign PC_jump = {PC_4[31:28], instruction[25:0], 2'b00};

    logic b_and_z;
    assign b_and_z = Branch & zero;

    assign PC_4_branch = b_and_z ? PC_branch : PC_4;
    assign PC_next = Jump ? PC_jump : PC_4_branch;



endmodule 

    