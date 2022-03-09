/*
Filename:       tb_registers.sv
Author:         DTW
Date:           12/05/2021
Description:    Testbench for registers.sv
*/

module tb_registers;

// Set time units for the testbench 
timeunit 1ns; timeprecision 1ns;

// Signal Declaration 
logic           clk, regWrite, resetN;
logic   [4:0]   rdReg1, rdReg2, wrReg;
logic   [31:0]  wrData, data1, data2;

register_mem DUT(.*);

initial begin 
        regWrite    = 1'b0;
        resetN      = 1'b0;
        rdReg1      = 5'b0;
        rdReg2      = 5'b1;
        wrReg       = 5'b0;
        wrData      = 32'h0000_0101;
    #10 resetN      = 1'b1;
    #10 regWrite    = 1'b1;
    #10 regWrite    = 1'b0;
end 

endmodule 