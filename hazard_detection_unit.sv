


module hazard_detection_unit (
    input   wire    [31:0]  RT_EX, RS_ID, RT_ID,
    input   wire            MemRead_EX,
    output  logic           PC_Write_En, IF_ID_Write, Flush_Control
);

logic condition;

assign condition = (MemRead_EX & ((RT_EX == RS_ID) | (RT_EX == RT_ID)));

assign PC_Write_En = !condition;
assign IF_ID_Write = !condition;
assign Flush_Control = condition;

endmodule