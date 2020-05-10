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
    input RST,
    input INTR,
    input [31:0] IOBUS_IN,
    output [31:0] IOBUS_OUT,
    output [31:0] IOBUS_ADDR,
    output IOBUS_WR
    );
    
  
    logic tPC_WRITE,                   // PC write enable
          tMEM_WE2, tMEM_RDEN1, tMEM_RDEN2,     // Memory write enable 2, read enable 1 and 2
          tRF_WRITE,                            // RF enable
          tBR_EQ, tBR_LT, tBR_LTU,              // Branch cond gen
          tALU_SRC_A,                           // ALU source A select
          tINTR_TAKEN, tCSR_WRITE, tMIE;        // CSR mie
          
    logic [1:0] tRF_WR_SEL,                    // RF write select
                tALU_SRC_B;                    // ALU source B select
                
    logic [2:0] tPC_SOURCE;                     // PC source select
    
    logic [3:0] tALU_FUN;                       // ALU function select
    
    logic [31:0] tPC_IN, tPC,                   // PC data
                 tJALR, tBRANCH, tJAL,          // Branch Address Generator
                 tINSTRUCTION, tMEM_DOUT2,      // Memory data
                 tRF_WD, tRF_RS1, tRF_RS2,      // Reg file data
                 tALU_RESULT, tALU_A, tALU_B,   // ALU data, source in
                 tU, tI, tS, tJ, tB,            // Immed Gen data
                 tMEPC, tMTVEC, tCSR_RD;        // CSR data
                 
    PC pc(
        .CLK(CLK), .PC_RST(RST), 
        .PC_WRITE(tPC_WRITE), .PC_DIN(tPC_IN), 
        .PC_COUNT(tPC));
    
    Mux8 pc_mux(
        .SEL(tPC_SOURCE), 
        .ZERO(tPC + 4), 
        .ONE(tJALR), 
        .TWO(tBRANCH), 
        .THREE(tJAL),
        .FOUR(tMTVEC),
        .FIVE(tMEPC), 
        .OUT(tPC_IN));
        
    //ProgRom prog_rom(.CLK(CLK), .ADDR(PC_COUNTER), .INSTRUCTION(INSTRUCTION));
    Memory mem(
        .MEM_CLK(CLK), 
        .MEM_ADDR1(tPC[15:2]), .MEM_DOUT1(tINSTRUCTION), .MEM_RDEN1(tMEM_RDEN1),
        .MEM_ADDR2(tALU_RESULT), .MEM_DOUT2(tMEM_DOUT2), .MEM_RDEN2(tMEM_RDEN2),
        .MEM_WD(tRF_RS2), .MEM_WE2(tMEM_WE2),
        .MEM_SIGN(tINSTRUCTION[14]),
        .MEM_SIZE(tINSTRUCTION[13:12]),
        .IO_IN(IOBUS_IN),
        .IO_WR(IOBUS_WR));
    
    RegFile regfile(
        .CLK(CLK), 
        .RF_EN(tRF_WRITE),
        .RF_ADDR1(tINSTRUCTION[19:15]), .RF_RS1(tRF_RS1),
        .RF_ADDR2(tINSTRUCTION[24:20]), .RF_RS2(tRF_RS2),
        .RF_WA(tINSTRUCTION[11:7]), .RF_WD(tRF_WD));  
    
    Mux4 reg_mux(
        .SEL(tRF_WR_SEL),
        .ZERO(tPC+4),
        .ONE(tCSR_RD),
        .TWO(tMEM_DOUT2),
        .THREE(tALU_RESULT),
        .OUT(tRF_WD));      
    
    IMMED_GEN immed_gen(
        .INSTRUCTION(tINSTRUCTION),
        .U(tU), .I(tI), .S(tS), .J(tJ), .B(tB));
        
    BRANCH_ADDR_GEN branch_addr_gen(
        .PC(tPC),
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
        .THREE(tPC),
        .OUT(tALU_B)
    );
    
    CU_DCDR cu_dcdr(
        .OPCODE(tINSTRUCTION[6:0]), 
        .FUNC3(tINSTRUCTION[14:12]),
        .FUNC7(tINSTRUCTION[31:25]),
        .INTR_TAKEN(tINTR_TAKEN),
        .BR_EQ(tBR_EQ),
        .BR_LT(tBR_LT),
        .BR_LTU(tBR_LTU),
        .ALU_FUN(tALU_FUN),
        .ALU_SRC_A(tALU_SRC_A),
        .ALU_SRC_B(tALU_SRC_B),
        .PC_SOURCE(tPC_SOURCE),
        .RF_WR_SEL(tRF_WR_SEL));
        
    CU_FSM cu_fsm(
        .CLK(CLK),
        .RST(RST),
        .INTR(INTR & tMIE),
        .OPCODE(tINSTRUCTION[6:0]),
        .FUNC3(tINSTRUCTION[14:12]),
        .PC_WRITE(tPC_WRITE),
        .RF_WRITE(tRF_WRITE),
        .MEM_WE2(tMEM_WE2),
        .MEM_RDEN1(tMEM_RDEN1),
        .MEM_RDEN2(tMEM_RDEN2),
        .CSR_WRITE(tCSR_WRITE),
        .INTR_TAKEN(tINTR_TAKEN));
    
    CSR csr(
        .CLK(CLK),
        .RST(RST),
        .INTR_TAKEN(tINTR_TAKEN),
        .PC(tPC),
        .ADDR(tINSTRUCTION[31:20]),
        .WD(tRF_RS1),
        .WE(tCSR_WRITE),
        .MIE(tMIE),
        .MEPC(tMEPC),
        .MTVEC(tMTVEC),
        .RD(tCSR_RD)
      );
    
    assign IOBUS_OUT = tRF_RS2;
    assign IOBUS_ADDR = tALU_RESULT;
endmodule
