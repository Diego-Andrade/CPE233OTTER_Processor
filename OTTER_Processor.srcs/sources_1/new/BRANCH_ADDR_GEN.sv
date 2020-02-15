`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/06/2020 10:42:58 PM
// Design Name: 
// Module Name: BRANCH_COND_GEN
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

module BRANCH_ADDR_GEN(
    input [31:0] PC,
    input [31:0] B, I, J,
    input [31:0] RS1,
    output [31:0] JAL, BRANCH, JALR
);
    
    assign JAL = PC + J;
    assign BRANCH = PC + B;
    assign JALR = RS1 + I;
endmodule