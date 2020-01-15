`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Created by: Diego Andrade 
// 
// Create Date: 01/09/2020 11:53:05 AM
// Design Name: ProgRom_sim
// Module Name: ProgRom_sim

// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ProgRom_sim();

logic PROG_CLK;
logic [31:0] PROG_ADDR = 0;
logic [31:0] INSTRUCT = 0;

ProgRom pRom(.PROG_CLK(PROG_CLK), .PROG_ADDR(PROG_ADDR), .INSTRUCT(INSTRUCT));

always begin
    PROG_CLK = 0; #5;
    PROG_CLK = 1; #5;
end

initial begin
    // Output first 6 instructions 0x0 -> 0x18
    for (int i = 0; i < 7; i++) begin
        PROG_ADDR = i*4; #10;
    end
end


endmodule
