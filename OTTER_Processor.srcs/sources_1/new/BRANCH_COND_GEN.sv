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


module BRANCH_COND_GEN(
    input [31:0] RS1, RS2,
    output BR_EQ, BR_LT, BR_LTU
    );
    
    
    assign BR_EQ = (RS1 == RS2);
    assign BR_LT = ($signed(RS1) < $signed(RS2));
    assign BR_LTU = (RS1 < RS2);
endmodule
