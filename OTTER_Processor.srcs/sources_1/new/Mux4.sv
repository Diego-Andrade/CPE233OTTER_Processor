`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/15/2020 11:32:23 AM
// Design Name: 
// Module Name: Mux4
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


module Mux4(
    input logic [31:0] ZERO, ONE, TWO, THREE,
    input logic [1:0] SEL,
    output logic [31:0] OUT
);

    always_comb begin
        if (SEL == 0)
            OUT = ZERO;
        else if (SEL == 1)
            OUT = ONE;
        else if (SEL == 2)
            OUT = TWO;
        else 
            OUT = THREE;
    end    
    
endmodule
