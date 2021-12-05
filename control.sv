/*
Filename:       control.sv
Author:         DTW
Date:           12/5/2021
Description:    This module receives the opcode from the instruction and 
                outputs control signals to the rest of the MIPS
*/

module control (
    input   logic   [5:0]   opCode,
    input   logic           resetN,
    output  logic           RegDst,
    output  logic           Branch, 
    output  logic           MemRead,
    output  logic           MemtoReg,
    output  logic           MemWrite,
    output  logic           ALUSrc,
    output  logic           RegWrite,
    output  logic   [1:0]   ALUOp
);

always_comb begin 
    if (~resetN) begin 
        RegDst      =   1'b0;
        Branch      =   1'b0;  
        MemRead     =   1'b0;
        MemtoReg    =   1'b0; 
        MemWrite    =   1'b0;
        ALUSrc      =   1'b0;
        RegWrite    =   1'b0;
        ALUOp       =   2'b00;
    end 
    else begin 
        case (opCode)
            6'b000000:  begin  // R-format
                            RegDst      =   1'b1;
                            Branch      =   1'b0;  
                            MemRead     =   1'b0;
                            MemtoReg    =   1'b0; 
                            MemWrite    =   1'b0;
                            ALUSrc      =   1'b0;
                            RegWrite    =   1'b1;
                            ALUOp       =   2'b10;
            end 

            6'b100011:  begin // lw 
                            RegDst      =   1'b0;
                            Branch      =   1'b0;  
                            MemRead     =   1'b1;
                            MemtoReg    =   1'b1; 
                            MemWrite    =   1'b0;
                            ALUSrc      =   1'b1;
                            RegWrite    =   1'b1;
                            ALUOp       =   2'b00;
            end 

            6'b101011:  begin // sw
                            RegDst      =   1'bx;
                            Branch      =   1'b0;  
                            MemRead     =   1'b0;
                            MemtoReg    =   1'bx; 
                            MemWrite    =   1'b1;
                            ALUSrc      =   1'b1;
                            RegWrite    =   1'b0;
                            ALUOp       =   2'b00;
            end 

            6'b000100:  begin // beq
                            RegDst      =   1'bx;
                            Branch      =   1'b1;  
                            MemRead     =   1'b0;
                            MemtoReg    =   1'bx; 
                            MemWrite    =   1'b0;
                            ALUSrc      =   1'b0;
                            RegWrite    =   1'b0;
                            ALUOp       =   2'b01;
            end 
            default:        begin 
                            RegDst      =   1'b0;
                            Branch      =   1'b0;  
                            MemRead     =   1'b0;
                            MemtoReg    =   1'b0; 
                            MemWrite    =   1'b0;
                            ALUSrc      =   1'b0;
                            RegWrite    =   1'b0;
                            ALUOp       =   2'b00;
            end 

        endcase 

    end 
end 

endmodule 