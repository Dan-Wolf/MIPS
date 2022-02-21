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
    int i;

    always_comb begin 
        if (~resetN) begin 
            for(i=0; i < MEM_SIZE; i++) begin 
                instruction_mem[i] = 32'b0;
            end 
        end
        else begin 
            // initialize memory 
            instruction_mem[0] = 32'b0;
            instruction_mem[4] = 32'b00100000000100010000000000000001;
            instruction_mem[8] = 32'b10101100000100010000000000000000;
            instruction_mem[12] = 32'b10001100000100100000000000000000;
        end 
    end
    // TODO: Understand how to implement instruction memory input
    //$readmemh("instructions.mem", instruction_mem);

    assign instruction = instruction_mem[PC];

    
endmodule