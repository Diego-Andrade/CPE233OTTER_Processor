`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/07/2020 10:14:13 AM
// Design Name: 
// Module Name: BRANCH_COND_GEN_sim
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


module BRANCH_COND_GEN_sim();
    logic [31:0] rs1, rs2;
    logic br_eq, br_lt, br_ltu;

    BRANCH_COND_GEN br_cond_gen(
            .rs1(rs1), .rs2(rs2), 
            .br_eq(br_eq), .br_lt(br_lt), .br_ltu(br_ltu));
            
    initial begin
        rs1 = 32'h4
    end
endmodule
