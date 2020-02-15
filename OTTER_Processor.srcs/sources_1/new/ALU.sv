`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/23/2020 10:43:32 PM
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [31:0] A, B,
    input logic [3:0] ALU_FUN,
    output logic [31:0] RESULT
    );
    
    always_comb begin
        case (ALU_FUN)
            4'b0000: RESULT = A + B;                                // Add
            4'b1000: RESULT = A - B;                                // Sub
            4'b0110: RESULT = A | B;                                // OR
            4'b0111: RESULT = A & B;                                // AND
            4'b0100: RESULT = A ^ B;                                // XOR
            4'b0101: RESULT = A >> B[4:0];                          // SRL
            4'b0001: RESULT = A << B[4:0];                          // SLL
            4'b1101: RESULT = $signed(A) >> $signed(B[4:0]);        // SRA
            4'b0010:                                                // SLT
                if ( $signed(A) < $signed(B) ) 
                    RESULT = 1;
                else 
                    RESULT = 0;
            4'b0011:                                                // SLTU
                if ( A < B )
                    RESULT = 1;
                else 
                    RESULT = 0;
            4'b1001: RESULT = A;                                    // LUI - copy
            default:                                                // Default of nothing 
                ;
        endcase
    end
endmodule
