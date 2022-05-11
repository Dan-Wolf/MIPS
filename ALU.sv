/*
Filename:       ALU.sv
Author:         DTW
Date:           11/15/2021
Description:    This module is a 32bit ALU. Performs arithmetic on operands based on opCode provided. 
                Outputs result and zero flag.
*/

//=================================================================================================

module ALU  (   input   logic   signed  [31:0]  A, B,       // Operands
                input   logic           [3:0]   opCode,     // ALU opcode
                output  logic   signed  [31:0]  ALU_Out,    // Output
                output  logic                   zero        // Zero Flag
        );

    always_comb begin 
        case (opCode)
            4'b0000 :   ALU_Out <=   A & B;
            4'b0001 :   ALU_Out <=   A | B;
            4'b0010 :   ALU_Out <=   A + B;
            4'b0110 :   ALU_Out <=   A - B;
            4'b0111 :   ALU_Out <=   A < B ? 1 : 0;
            4'b1100 :   ALU_Out <=   ~(A | B);
            default :   ALU_Out <=   0;
        endcase
    end

    assign zero = (ALU_Out == 0);   // Set if ALU_Out = 0


endmodule

