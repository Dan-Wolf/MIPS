/*
Filename:       tb_control.sv
Author:         DTW
Date:           12/05/2021
Description:    Testbench for control.sv
*/

module tb_control;

// Set time units for the testbench 
timeunit 1ns; timeprecision 1ns;

// Signal Declaration 
logic   [5:0]   opCode;
logic   [1:0]   ALUOp;
logic           resetN, RegDst, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;

control DUT(.*);

initial begin 
    opCode  =   6'b000000;  // R-format
    resetN  =   1'b0;
    #10 resetN = 1'b1;
    #10 opCode = 6'b100011; // lw
    #10 opCode = 6'b101011; // sw
    #10 opCode = 6'b000100; // beq
    #10 opCode = 6'b011001; // garbage
end 

endmodule 