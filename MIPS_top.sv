/*
Filename:       MIPS_top.sv
Author:         DTW
Date:           11/17/2021
Description:    This module is the top level entity. All submodules of the MIPS are connected 
                in this file. 
*/

//=================================================================================================

module MIPS (   input   wire    clk,
                input   wire    resetN
        );

    // Program Counter
    logic   [31:0]  PC;

    // Instruction Memory
    logic   [31:0]  instruction;

    instruction_mem inst_mem(.PC            (PC),
                             .resetN        (resetN),
                             .instruction   (instruction)
    );

    // Control 
    logic       RegDst, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
    logic [1:0] ALUOp;

    control control_0(.opCode       (instruction[31:26]),
                      .resetN       (resetN),
                      .RegDst       (RegDst),
                      .Branch       (Branch),
                      .MemRead      (MemRead),
                      .MemtoReg     (MemtoReg),
                      .MemWrite     (MemWrite),
                      .ALUSrc       (ALUSrc),
                      .RegWrite     (RegWrite),
                      .ALUOp        (ALUOp)
    );

    // Registers
    logic   [31:0]  regData1, regData2, wrData;

    // Add wrReg MUX

    register_mem(.regWrite  (RegWrite),
                 .resetN    (resetN),
                 .rdReg1    (instruction[25:21]),
                 .rdReg2    (instruction[20:16]),
                 .wr
                 )

endmodule 

    