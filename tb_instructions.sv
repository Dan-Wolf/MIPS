/*
Filename:       tb_control.sv
Author:         DTW
Date:           12/05/2021
Description:    Testbench for instructions.sv
*/

module tb_instructions;

// Set time units for the testbench 
timeunit 1ns; timeprecision 1ns;

// Signal Declaration 
logic   [31:0]  PC;
logic           resetN;
logic   [31:0]  instruction;

instruction_mem DUT(.*);

initial begin 
    PC  <=  32'h0000_0000;
    resetN <= 1'b0;
    #10 resetN <= 1'b1;
    #10 PC <= 32'h0000_0004;
end 

endmodule