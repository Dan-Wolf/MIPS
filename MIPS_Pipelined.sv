











module MIPS_Pipelined (
    input wire clk,
    input wire resetN
);

logic [31:0] PC, PC_4_IF, PC_next, PC_jump_MEM;
wire PCSrc;

assign PC_4_IF = (resetN) ? PC + 32'h0000_0004 : 32'h0000_0000;
assign PC_next = (PCSrc) ? PC_jump_MEM : PC_4_IF;

always @(posedge clk or negedge resetN) begin 
    if (~resetN) 
        PC <= 32'b0;
    else 
        PC <= PC_next;
end 


// Instruction Memory
logic   [31:0]  instruction_IF, instruction_ID;
logic   [31:0]  PC_4_ID;

instruction_mem inst_mem(
    .PC             (PC),
    .resetN         (resetN),
    .instruction    (instruction_IF)
);

pipeline_reg #(64) IF_ID_reg (
    .clk        (clk),
    .resetN     (resetN),
    .data_in    ({PC_4_IF, instruction_IF}),
    .data_out   ({PC_4_ID, instruction_ID})

);

// Control 
    wire            RegDst_ID, Jump_ID, Branch_ID, MemRead_ID, MemtoReg_ID, MemWrite_ID, ALUSrc_ID, RegWrite_ID;
    logic   [1:0]   ALUOp_ID;
    wire    [5:0]   opCode;

    assign opCode = instruction_ID[31:26];  

    control control_0(
        .opCode       (opCode),
        .resetN       (resetN),
        .RegDst       (RegDst_ID),
        .Jump         (Jump_ID),
        .Branch       (Branch_ID),
        .MemRead      (MemRead_ID),
        .MemtoReg     (MemtoReg_ID),
        .MemWrite     (MemWrite_ID),
        .ALUSrc       (ALUSrc_ID),
        .RegWrite     (RegWrite_ID),
        .ALUOp        (ALUOp_ID)
    );

    

endmodule 