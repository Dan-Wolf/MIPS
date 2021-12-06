/*
Filename:       dataMemory.sv
Author:         DTW
Date:           12/05/2021
Description:    TData memory storage for read/write operations
*/

module dataMemory ( 
            input   logic           clk, resetN,
            input   logic   [31:0]  address, wrData,
            input   logic           MemWrite, MemRead,
            output  logic   [31:0]  readData
);

    int i;
    logic [31:0] ram[255:0];

    always @(posedge clk or negedge resetN) begin 
        if (~resetN) begin 
            for (i=0; i < 256; i++) begin 
                ram[i] <= 32'b0;
            end
        end
        else begin 
            if (MemWrite)
                ram[address] <= wrData;
        end 
    end

    assign readData = MemRead ? ram[address] : 32'b0;

endmodule
