`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/27/2020 10:32:03 AM
// Design Name: 
// Module Name: Mux2
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


module Mux2(
    input logic [31:0] ZERO, ONE,
    input logic SEL,
    output logic [31:0] OUT 
);
    
    always_comb begin
        if (SEL == 0)
            OUT = ZERO;
        else
            OUT = ONE;
    end 
endmodule
