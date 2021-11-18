/*
Filename:       MIPS_top.sv
Author:         DTW
Date:           11/17/2021
Description:    This module is the top level entity. All submodules of the MIPS are connected 
                in this file. 
*/

//=================================================================================================

module MIPS (   input   wire    clk,
                input   wire    resetN,
        );

    // Program Counter
    logic [31:0]    program_counter;

    always @(posedge clk or negedge resetN) begin
        if(~resetN)
            program_counter <=  32'b0;
        else
            // TODO: Set to output of PCSrc MUX
    end

    