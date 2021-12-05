/*
Filename:       tb_ALUControl.sv
Author:         DTW
Date:           12/05/2021
Description:    Testbench for ALUControl.sv
*/

module tb_ALUControl;

// Set time units for the testbench 
timeunit 1ns; timeprecision 1ns;

// Signal Declaration 
logic   [1:0]   ALUOp;
logic   [5:0]   funct;
logic   [3:0]   ALUCtl;

ALUControl DUT(.*);

initial begin 
        ALUOp   <=  2'b00;
        funct   <=  6'b100000;
    #10 ALUOp   <=  2'b01;
    #10 ALUOp   <=  2'b10;
    #10 funct   <=  6'b100010;
    #10 funct   <=  6'b100100;
    #10 funct   <=  6'b100101;
    #10 funct   <=  6'b101010;
end

endmodule