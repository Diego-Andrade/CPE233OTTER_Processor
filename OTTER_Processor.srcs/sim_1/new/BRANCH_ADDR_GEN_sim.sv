`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/07/2020 10:14:13 AM
// Design Name: 
// Module Name: BRANCH_ADDR_GEN_sim
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


module BRANCH_ADDR_GEN_sim();

    logic [31:0] PC, B, I, J, rs1, jal, branch, jalr;
    
    BRANCH_ADDR_GEN br_addr_gen(
        .PC(PC),
        .B(B), .I(I), .J(J),
        .rs1(rs1),
        .jal(jal), .branch(branch), .jalr(jalr));
        
        initial begin
            PC = 32'h10;
            
            // For branch
            B = -12;
            
            // For jal
            J = 8;
            
            // Simulating jalr
            rs1 = 32'hC;
            I = 4;
        end
endmodule
