/*
Filename:       ALUControl.sv
Author:         DTW
Date:           11/17/2021
Description:    This module is the controller of the ALU. Determines 4b ALUCtl signal based on
                ALUOp code and funct field from instruction. 
*/

//=================================================================================================

module  ALUControl   (  input   logic   [1:0]   ALUOp,
                        input   logic   [5:0]   funct,
                        output  logic   [3:0]   ALUCtl
        );

    always_comb begin 
        case (ALUOp) 
            2'b00: ALUCtl <= 4'b0010;    // Add
            2'b01: ALUCtl <= 4'b0110;    // Sub
            2'b10: begin
                case(funct)
                    6'b100000:  ALUCtl <= 4'b0010;
                    6'b100010:  ALUCtl <= 4'b0110;
                    6'b100100:  ALUCtl <= 4'b0000;
                    6'b100101:  ALUCtl <= 4'b0001;
                    6'b101010:  ALUCtl <= 4'b0111;
                    default:    ALUCtl <= 4'b0000;
                endcase
            end
            default: ALUCtl <= 4'b0000;
        endcase
    end
endmodule

            

