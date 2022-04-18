


module pipeline_reg (
    clk, 
    resetN,
    enable,
    flush, 
    data_in,
    data_out 
);

parameter WIDTH = 8;

input   wire                clk;
input   wire                resetN;
input   wire                enable;
input   wire                flush;
input   wire    [WIDTH-1:0] data_in;
output  logic   [WIDTH-1:0] data_out;

always @(posedge clk or negedge resetN) begin 
    if (~resetN) 
        data_out <= '0;
	else if (flush)
			data_out <= '0;
    else 
        if (enable)
            data_out <= data_in;
        else
            data_out <= data_out;
end 

endmodule