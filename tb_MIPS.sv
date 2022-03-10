/*
Filename:       tb_MIPS.sv
Author:         DTW
Date:           12/05/2021
Description:    Testbench for MIPS_top.sv
*/

module tb_MIPS;

// Set time units for the testbench 
timeunit 1ns; timeprecision 1ns;

// Signal Declaration
logic clk, resetN;

always #10 clk <= ~clk;

MIPS_Pipelined DUT(.*);

initial begin 
    clk = 1'b0;
    resetN = 1'b0;
    #20 resetN = 1'b1;
end 

endmodule 