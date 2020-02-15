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
    input CLK
    );
    
  
    logic tPC_RST, tPC_WRITE,                   // PC write enable
          tRF_EN,                               // RF enable
          tBR_EQ, tBR_LT, tBR_LTU,              // Branch cond gen
          tALU_SRC_A, tALU_SRC_B;               // ALU source selects
          
    logic [1:0]  tPC_SOURCE,                    // PC source select
                 tRF_WR_SEL;                    // RF write select
    
    logic [3:0] tALU_FUN;                       // ALU function select
    
    logic [31:0] tPC_IN, tPC_OUT,               // PC data
                 tJALR, tBRANCH, tJAL,          // Branch Address Generator
                 tINSTRUCTION, tMEM_DOUT2,      // Memory data
                 tRF_WD, tRF_RS1, tRF_RS2,      // Reg file data
                 tALU_RESULT, tALU_A, tALU_B,   // ALU data, source in
                 tCSR_REG,                      // Control Regs???
                 tU, tI, tS, tJ, tB;            // Immed Gen data
    PC pc(
        .CLK(CLK), .PC_RST(tPC_RST), 
        .PC_WRITE(tPC_WRITE), .PC_DIN(tPC_IN), 
        .PC_COUNT(tPC_OUT));
    
    Mux4 pc_mux(
        .SEL(tPC_SOURCE), 
        .ZERO(tPC_OUT + 4), 
        .ONE(tJALR), 
        .TWO(tBRANCH), 
        .THREE(tJAL), 
        .OUT(tPC_IN));
        
    //ProgRom prog_rom(.CLK(CLK), .ADDR(PC_COUNTER), .INSTRUCTION(INSTRUCTION));
    Memory mem(
        .MEM_CLK(CLK), 
        .MEM_ADDR1(tPC_OUT), .MEM_DOUT1(tINSTRUCTION),
        .MEM_ADDR2(tALU_RESULT), .MEM_WD(tRF_RS2), .MEM_DOUT2(tMEM_DOUT2));
    
    RegFile regfile(
        .CLK(CLK), 
        .RF_EN(tRF_EN),
        .RF_ADDR1(tINSTRUCTION[19:15]), .RF_RS1(tRF_RS1),
        .RF_ADDR2(tINSTRUCTION[24:20]), .RF_RS2(tRF_RS2),
        .RF_WA(tINSTRUCTION[11:7]), .RF_WD(tRF_WD));  
    
    Mux4 reg_mux(
        .SEL(tRF_WR_SEL),
        .ZERO(tPC_OUT),
        .ONE(tCSR_REG),
        .TWO(tMEM_DOUT2),
        .THREE(tALU_RESULT),
        .OUT(tRF_WD));      
    
    IMMED_GEN immed_gen(
        .INSTRUCTION(tINSTRUCTION),
        .U(tU), .I(tI), .S(tS), .J(tJ), .B(tB));
        
    BRANCH_ADDR_GEN branch_addr_gen(
        .PC(tPC_OUT),
        .J(tJ), .B(tB), .I(tI),
        .RS1(tRF_RS1),
        .JAL(tJAL), .BRANCH(tBRANCH), .JALR(tJALR));
        
    BRANCH_COND_GEN branch_cond_gen(
        .RS1(tRF_RS1), .RS2(tRF_RS2),
        .BR_EQ(tBR_EQ), .BR_LT(tBR_LT), .BR_LTU(tBR_LTU));
        
    ALU alu(
        .A(tALU_A), .B(tALU_B),
        .ALU_FUN(tALU_FUN),
        .RESULT(tALU_RESULT)
    );
    
    Mux2 alu_a_mux2(
        .SEL(tALU_SRC_A),
        .ZERO(tRF_RS1),
        .ONE(tU),
        .OUT(tALU_A)
    );
    
    Mux4 alu_b_mux4(
        .SEL(tALU_SRC_B),
        .ZERO(tRF_RS2),
        .ONE(tI),
        .TWO(tS),
        .THREE(tPC_OUT),
        .OUT(tALU_B)
    );
    
    
endmodule
