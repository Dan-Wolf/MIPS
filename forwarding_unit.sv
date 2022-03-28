



module forwarding_unit (
    input   wire            RegWrite_MEM, RegWrite_WB,
    input   wire    [4:0]   wrReg_MEM, wrReg_WB, RS_EX, RT_EX, 
    output  logic   [1:0]   Forward_A, Forward_B
);

logic   MEM_A, MEM_B, WB_A, WB_B;

assign MEM_A = (RegWrite_MEM) & (wrReg_MEM != 5'b00000) & (wrReg_MEM == RS_EX);
assign MEM_B = (RegWrite_MEM) & (wrReg_MEM != 5'b00000) & (wrReg_MEM == RT_EX);

assign WB_A = (RegWrite_WB) & (wrReg_WB != 5'b00000) & (!(RegWrite_MEM & (wrReg_MEM != 5'b00000) & (wrReg_MEM != RS_EX))) & (wrReg_WB == RS_EX);
assign WB_B = (RegWrite_WB) & (wrReg_WB != 5'b00000) & (!(RegWrite_MEM & (wrReg_MEM != 5'b00000) & (wrReg_MEM != RT_EX))) & (wrReg_WB == RT_EX);

always_comb begin 
    case ({MEM_A, WB_A})  
        2'b00   :   Forward_A = 2'b00;
        2'b01   :   Forward_A = 2'b01;
        2'b10   :   Forward_A = 2'b10;
        2'b11   :   Forward_A = 2'b10;
    endcase
end 

always_comb begin 
    case ({MEM_B, WB_B})  
        2'b00   :   Forward_B = 2'b00;
        2'b01   :   Forward_B = 2'b01;
        2'b10   :   Forward_B = 2'b10;
        2'b11   :   Forward_B = 2'b10;
    endcase
end 

endmodule 