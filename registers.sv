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
    input   logic           regWrite, 
    input   logic           resetN,   
    input   logic   [4:0]   rdReg1, rdReg2, wrReg,
    input   logic   [31:0]  wrData,
    output  logic   [31:0]  data1, data2
);  

    // Write to Register
    logic [31:0] RF [31:0]; // 32 registers each 32b
    int i;  

    initial begin 
        for (i=0; i < 32; i++) begin 
            RF[i] = 32'b0;
        end
    end

    // Read from Register
    assign data1 = RF[rdReg1];
    assign data2 = RF[rdReg2];

    always @(posedge clk) begin 
        // Write to register if regWrite is set
        if (regWrite)
            if (wrReg == 4'b0000)
                RF[wrReg] <= 4'b0000;
            else
                RF[wrReg] <= wrData;
        else 
            RF[wrReg] <= RF[wrReg];
    end
    
            
endmodule