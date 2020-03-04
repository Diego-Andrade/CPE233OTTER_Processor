`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/03/2020 11:31:40 AM
// Design Name: 
// Module Name: Mux8
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


module Mux8(
    input logic [31:0] ZERO, ONE, TWO, THREE, FOUR, FIVE, // SIX, SEVEN,
    input logic [2:0] SEL,
    output logic [31:0] OUT
    );

    always_comb begin
        case(SEL)
            0: OUT = ZERO;
            1: OUT = ONE;
            2: OUT = TWO;
            3: OUT = THREE;
            4: OUT = FOUR;
            5: OUT = FIVE;
            //6: OUT = SIX;
            //7: OUT = SEVEN;
            default: OUT = 0;
        endcase
    end    
endmodule
