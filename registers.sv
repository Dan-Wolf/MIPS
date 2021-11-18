/*
Filename:       registers.sv
Author:         DTW
Date:           11/17/2021
Description:    This module is the register memory of the MIPS. Capable of doing 2 simultanious reads
                and a sequential write.
*/

//=================================================================================================

module register_mem (
    input   logic           clk,
    input   logic           resetN,   
    input   logic   [4:0]   rdReg1, rdReg2, wrReg,
    input   logic   [31:0]  wrData,
    input   logic           regWrite, 
    output  logic   [31:0]  data1, data2
);  

    // Read from Register
    assign data1 = RF[rdReg1];
    assign data2 = RF[rdReg2];


    // Write to Register
    logic [31:0] RF [31:0]; // 32 registers each 32b
    int i;  

    always @(posedge clk or negedge resetN) begin 
        // Reset Registers to 0
        if(~resetN) begin 
            for (i=0; i < 32; i++) begin 
                RF[i] <= '0;
            end 
        end 
        else begin 
            // Write to register if regWrite is set
            if (regWrite)
                RF[wrReg] <= wrData;
        end
    end
    
            
endmodule