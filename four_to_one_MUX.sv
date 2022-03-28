

module four_to_one_MUX ( 
    input wire [31:0]    data_in0,
    input wire [31:0]    data_in1,
    input wire [31:0]    data_in2,
    input wire [31:0]    data_in3,
    input wire [1:0]     select,
    output logic [31:0]   data_out
);

always_comb begin 
    case (select) 
        2'b00   :   data_out = data_in0;
        2'b01   :   data_out = data_in1;
        2'b10   :   data_out = data_in2;
        2'b11   :   data_out = data_in3;
    endcase
end 

endmodule