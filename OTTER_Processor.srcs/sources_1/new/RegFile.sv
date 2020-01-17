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
    input [31:0] RF_ADDR1, RF_ADDR2,
    input [31:0] RF_WA, RF_WD,
    input RF_EN,
    output logic [31:0] RF_RS1, RF_RS2 
);

logic [31:0] ram [31:0];

initial begin
    for (int i = 0; i < 32; i++) begin
        ram[i] = 0;
    end
end

always_ff @ (posedge CLK) begin
    if (RF_EN)
        ram[RF_WA] = RF_WD;
end

// Always continous data
assign RF_RS1 = ram[RF_ADDR1];
assign RF_RS2 = ram[RF_ADDR2];

endmodule
