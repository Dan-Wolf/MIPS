/*
Filename:       instructions.sv
Author:         DTW
Date:           11/17/2021
Description:    This module contains the instuction memory, it reads in a hex file called "instructions.mem".   
                Will be programmed with Machine language.
*/

//=================================================================================================

module instruction_mem #(
    MEM_SIZE = 256
) ( input   logic   [31:0]  PC,
    output  logic   [31:0]  instuction
);

    logic [31:0] instruction_mem [0:MEM_SIZE-1];
    $readmemh("instructions.mem", instruction_mem);

    assign instruction = instruction_mem[PC];

    
endmodule