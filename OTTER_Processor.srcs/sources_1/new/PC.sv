module PC(
    input logic PC_RST, PC_WRITE, 
    input logic [31:0] PC_DIN,
    input logic CLK,
    output logic [31:0] PC_COUNT = 0
);

always_ff @ (posedge CLK) begin
    if (!PC_RST)
        PC_COUNT = 0;
    else if (PC_WRITE)
        PC_COUNT = PC_DIN;
end

endmodule