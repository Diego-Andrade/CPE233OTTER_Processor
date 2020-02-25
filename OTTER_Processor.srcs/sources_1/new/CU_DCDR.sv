`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/14/2020 11:20:13 AM
// Design Name: 
// Module Name: CU_DCDR
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


module CU_DCDR(
    input [6:0] OPCODE,
    input [2:0] FUNC3,
    input [6:0] FUNC7,
    input BR_EQ, BR_LT, BR_LTU,
    output logic [3:0] ALU_FUN,
    output logic ALU_SRC_A,
    output logic [1:0] ALU_SRC_B,
    output logic [1:0] PC_SOURCE,
    output logic [1:0] RF_WR_SEL
    );
    
    always_comb begin
        ALU_FUN = 0; 
        ALU_SRC_A = 0; ALU_SRC_B = 0;
        RF_WR_SEL = 0;
        PC_SOURCE = 0;
    
        case(OPCODE)
            // All R-Types
            7'b0110011: begin      
                ALU_FUN = {FUNC7[5], FUNC3}; 
                ALU_SRC_A = 0; ALU_SRC_B = 0;
                RF_WR_SEL = 3;
                PC_SOURCE = 0;
            end
            
            // I-Types
            7'b0010011: begin       // Handle I-Type ADDI, ANDI, ORI, SL's, SR's, XORI
                if (FUNC3 == 3'b101)       // Handle sr ai and li
                    ALU_FUN = {FUNC7[5], FUNC3};
                else                        // Rest of ops
                   ALU_FUN = {1'b0, FUNC3}; 
                ALU_SRC_A = 0; ALU_SRC_B = 1;
                RF_WR_SEL = 3;
                PC_SOURCE = 0;
            end
            7'b1100111: begin       // Handle JALR
                RF_WR_SEL = 0;
                PC_SOURCE = 1;
            end
            7'b0000011: begin       // Handle L's
                ALU_FUN = 0;
                ALU_SRC_A = 0; ALU_SRC_B = 1;
                RF_WR_SEL = 2;
                PC_SOURCE = 0;
            end
            
            // S-Types
            7'b0100011: begin       // Handle S's
                ALU_FUN = 0;
                ALU_SRC_A = 0; ALU_SRC_B = 2;
                PC_SOURCE = 0;
            end
            
            // B-Types
            7'b1100011: begin       // Handle branches
                case(FUNC3)
                    3'b000: if (BR_EQ) PC_SOURCE = 2;               // BE
                    3'b001: if (~BR_EQ) PC_SOURCE = 2;              // BNE
                    3'b101: if (BR_EQ || ~BR_LT) PC_SOURCE = 2;     // BGE
                    3'b111: if (BR_EQ || ~BR_LTU) PC_SOURCE = 2;    // BGEU
                    3'b100: if (BR_LT) PC_SOURCE = 2;               // BLT
                    3'b110: if (BR_LTU) PC_SOURCE = 2;              // BLTU
                endcase
            end
            
            // U-TYPEs
            7'b0110111: begin           // Handle LUI
                 ALU_FUN = 4'b1001;
                 ALU_SRC_A = 1;
                 RF_WR_SEL = 3;
                 PC_SOURCE = 0;
            end
            
            7'b0010111: begin           // Handle AUIPC
                 ALU_FUN = 0;
                 ALU_SRC_A = 1; ALU_SRC_B = 3;
                 RF_WR_SEL = 3;
                 PC_SOURCE = 0;
            end
            
            // J-TYPES
            7'b1101111: begin           // Handle JAL
                RF_WR_SEL = 0;
                PC_SOURCE = 3;
            end  
        endcase
    end
endmodule
