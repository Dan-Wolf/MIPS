/*
Filename:       tb_ALUControl.sv
Author:         DTW
Date:           11/17/2021
Description:    Testbench for ALU.sv
*/

module tb_MIPSALU;

// Set time units for the testbench 
timeunit 1ns; timeprecision 1ns;

// Signal Declaration 
logic   [3:0]   opCode;
logic   [31:0]  A, B, ALU_Out;
logic           zero;

ALU     DUT(.*);

initial begin 
        A   <= 32'h0000_0007;
        B   <= 32'H0000_000A;
        opCode  <= 4'b0010;
    #10 opCode  <= 4'b0000;
    #10 A   <= 32'h0000_000A;
        opCode  <= 4'b0100;
end

endmodule 