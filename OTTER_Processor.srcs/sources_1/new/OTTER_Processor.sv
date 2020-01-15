`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/15/2020 12:23:27 PM
// Design Name: 
// Module Name: OTTER_Processor
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


module OTTER_Processor(
    input CLK,
    // Temp data connections
    input PC_RST, PC_WRITE,
    input [1:0]PC_SEL,
    input [31:0] JALR, BRANCH, JAL,
    // End Temp
    output [31:0] INSTRUCTION
    );
    
    logic [31:0] PC_COUNTER;
    logic [31:0] tPC_DATA;
    
    ProgRom prog_rom(.CLK(CLK), .ADDR(PC_COUNTER), .INSTRUCTION(INSTRUCTION));
    
    Mux4 pc_mux(.SEL(PC_SEL), 
                .ZERO(PC_COUNTER + 4), 
                .ONE(JALR), 
                .TWO(BRANCH), 
                .THREE(JAL), 
                .OUT(tPC_DATA));
                
    PC pc(.CLK(CLK), .PC_RST(PC_RST), .PC_WRITE(PC_WRITE), .PC_DIN(tPC_DATA));
endmodule
