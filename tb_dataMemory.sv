/*
Filename:       tb_dataMemory.sv
Author:         DTW
Date:           12/07/2021
Description:    Testbench for dataMemory.sv
*/

module tb_dataMemory;

// Set time units for the testbench 
timeunit 1ns; timeprecision 1ns;

// Signal Declaration 
logic   [31:0]  address, wrData;
logic           clk,resetN, MemWrite, MemRead;
logic   [31:0]  readData;

// Clock Generation
always #10 clk = ~clk;

dataMemory DUT(.*);

initial begin 
    clk <= 1'b0;
    address <= 32'b0;
    wrData <= 32'h10101010;
    MemWrite <= 1'b0;
    MemRead <= 1'b0;
    resetN <= 1'b0;
    #10 resetN <= 1'b1;
    #10 MemRead <= 1'b1;
    #10 MemRead <= 1'b0;
    #10 MemWrite <= 1'b1;
    #10 MemWrite <= 1'b0;
    #10 MemRead <= 1'b1;
    #10 MemRead <= 1'b0;
end 

endmodule