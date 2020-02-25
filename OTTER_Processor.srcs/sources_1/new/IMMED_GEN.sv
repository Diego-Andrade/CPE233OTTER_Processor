`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/23/2020 10:43:32 PM
// Design Name: 
// Module Name: IMMED_GEN
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


module IMMED_GEN(
    input [31:0] INSTRUCTION,
    output [31:0] U, I, S, J, B
    );
    
    assign U = {INSTRUCTION[31:12], 12'b0};
    assign I = {{21{INSTRUCTION[31]}}, INSTRUCTION[30:25], INSTRUCTION[24:20]};
    assign S = {{21{INSTRUCTION[31]}}, INSTRUCTION[30:25], INSTRUCTION[11:7]};
    assign J = {{12{INSTRUCTION[31]}}, INSTRUCTION[19:12], INSTRUCTION[20], INSTRUCTION[30:21], 1'b0};
    assign B = {{20{INSTRUCTION[31]}}, INSTRUCTION[7], INSTRUCTION[30:25], INSTRUCTION[11:8], 1'b0};
    
endmodule
