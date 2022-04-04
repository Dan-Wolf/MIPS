


module hazard_detection_unit (
    input   wire    [4:0]  RT_EX, RS_ID, RT_ID,
    input   wire            MemRead_EX, branch, jump,
    output  logic           PC_Write_En, IF_ID_Write, Flush_Control,
    output  logic           IF_ID_Flush, ID_EX_Flush, EX_MEM_Flush
);

logic condition;

assign condition = (MemRead_EX & ((RT_EX == RS_ID) | (RT_EX == RT_ID)));

assign PC_Write_En = !condition;
assign IF_ID_Write = !condition;
assign Flush_Control = condition;

assign IF_ID_Flush = branch | jump;
assign ID_EX_Flush = branch;
assign EX_MEM_Flush = branch;

endmodule