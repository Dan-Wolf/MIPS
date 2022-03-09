/*
Filename:       dataMemory.sv
Author:         DTW
Date:           12/05/2021
Description:    Data memory storage for read/write operations
*/

module dataMemory ( 
            input   logic           clk, resetN,
            input   logic   [31:0]  address, wrData,
            input   logic           MemWrite, MemRead,
            output  logic   [31:0]  readData
);

    localparam MEM_SIZE = 1028;

    int i;
    logic [31:0] ram[MEM_SIZE:0];

    initial begin 
        for (i=0; i < MEM_SIZE; i++) begin 
            ram[i] <= 32'b0;
        end
    end

    always @(posedge clk) begin 
        if (MemWrite)
            ram[address] <= wrData;
    end

    assign readData = MemRead ? ram[address] : 32'b0;

endmodule
