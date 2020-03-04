`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/14/2020 11:20:13 AM
// Design Name: 
// Module Name: CU_FSM
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


module CU_FSM(
    input CLK,
    input RST, INTR,
    input [6:0] OPCODE,
    input [2:0] FUNC3,
    output logic PC_WRITE,
    output logic RF_WRITE,
    output logic MEM_WE2,
    output logic MEM_RDEN1,
    output logic MEM_RDEN2,
    output logic CSR_WRITE,
    output logic INTR_TAKEN
    );
    
    typedef enum {ST_FETCH, ST_EXEC, ST_WRITEBACK, ST_INTR} State; 
    
    State PS = ST_FETCH, NS = ST_FETCH;
    
    always_ff @ (posedge CLK) begin
        if (RST)
            PS <= ST_FETCH;
        else
            PS <= NS;
    end
    
    always_comb begin
        PC_WRITE = 0; 
        RF_WRITE = 0;
        MEM_WE2 = 0;
        MEM_RDEN1 = 0;
        MEM_RDEN2 = 0;
        CSR_WRITE = 0;
        INTR_TAKEN = 0;
        
        NS = ST_FETCH;
        
        case (PS)
            ST_FETCH: begin
                MEM_RDEN1 = 1;
                NS = ST_EXEC;
            end
            
            ST_EXEC: begin
                // Defaults for most commands, if not then explicitly set below
                RF_WRITE = 1;
                PC_WRITE = 1;
                
                if (INTR)
                    NS = ST_INTR;
                else
                    NS = ST_FETCH;
                                    
                case(OPCODE)
                   7'b0000011: begin       // Handle L's
                        MEM_RDEN2 = 1;     
                        RF_WRITE = 0; 
                        PC_WRITE = 0;
                        
                        NS = ST_WRITEBACK;
                    end
                    
                    // S-Types
                    7'b0100011: begin       // Handle S's, no writing required
                        MEM_WE2 = 1;
                        RF_WRITE = 0;
                    end
                    
                    // B-Types
                    7'b1100011: begin       // Handle branches, no rf writting required
                        RF_WRITE = 0;                      
                    end 
                    
                    7'b1110011: begin       
                        if (FUNC3 == 3'b001)    // Handle CSRRW
                            CSR_WRITE = 1;  
                    end
                    
                    default: begin 
                        // Blank in order to gen comb logic
                    end
                endcase
            end
            
            ST_WRITEBACK: begin
                RF_WRITE = 1;
                PC_WRITE = 1;
                
                if (INTR)
                    NS = ST_INTR;
                else
                    NS = ST_FETCH;
            end
            
            ST_INTR: begin
                INTR_TAKEN = 1;
                PC_WRITE = 1;
                
                NS = ST_FETCH;
            end
            
            default: begin 
                
            end
        endcase
    end
endmodule
