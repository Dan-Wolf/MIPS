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
    input   logic           resetN,
    output  logic   [31:0]  instruction
);

    logic [31:0] instruction_mem [0:MEM_SIZE-1];

   always_comb begin 
	instruction_mem[0] = 32'b00100000000100010000000000000001;
instruction_mem[4] = 32'b00100000000100100000000000001010;
instruction_mem[8] = 32'b00000010001100101001100000100000;

	end

    assign instruction = instruction_mem[PC];

    
endmodule