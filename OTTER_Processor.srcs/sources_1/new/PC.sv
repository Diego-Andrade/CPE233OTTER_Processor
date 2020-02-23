`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Created by: Diego Andrade & Brian Padilla
// Create Date: 01/14/2020 11:00:00 AM
// Design Name: Program Counter
// Module Name: PC
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

module PC(
    input logic PC_RST, PC_WRITE, 
    input logic [31:0] PC_DIN,
    input logic CLK,
    output logic [31:0] PC_COUNT = 0
);

always_ff @ (posedge CLK) begin
    if (PC_RST)
        PC_COUNT <= 0;
    else if (PC_WRITE)
        PC_COUNT <= PC_DIN;
end

endmodule