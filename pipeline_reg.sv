


module pipeline_reg (
    clk, 
    resetN, 
    data_in,
    data_out 
);

parameter WIDTH = 8;

input   wire                clk;
input   wire                resetN;
input   wire    [WIDTH-1:0] data_in;
output  logic   [WIDTH-1:0] data_out;

always @(posedge clk or negedge resetN) begin 
    if (~resetN) 
        data_out <= '0;
    else 
        data_out <= data_in;
end 

endmodule