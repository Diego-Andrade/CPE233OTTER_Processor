`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/17/2020 09:22:34 AM
// Design Name: 
// Module Name: RegFile
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module RegFile(
    input CLK,
    input [4:0] RF_ADDR1, RF_ADDR2, RF_WA,
    input [31:0] RF_WD,
    input RF_EN,
    output logic [31:0] RF_RS1, RF_RS2 
);

logic [31:0] registers [0:31];

initial begin
    for (int i = 0; i < 32; i++) begin
        registers[i] = 0;
    end
end

always_ff @ (posedge CLK) begin
    if (RF_EN && RF_WA != 0)
        registers[RF_WA] <= RF_WD;
end

// Always continous data
assign RF_RS1 = registers[RF_ADDR1];
assign RF_RS2 = registers[RF_ADDR2];

endmodule
