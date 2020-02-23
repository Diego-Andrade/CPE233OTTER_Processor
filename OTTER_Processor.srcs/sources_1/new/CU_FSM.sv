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
    output logic PC_WRITE,
    output logic RF_WRITE,
    output logic MEM_WE2,
    output logic MEM_RDEN1,
    output logic MEM_RDEN2,
    output logic rst_out
    );
    
    typedef enum {ST_FETCH, ST_EXEC, ST_WRITEBACK} State; 
    
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
        rst_out = 0;
        
        case (PS)
            ST_FETCH: begin
                MEM_RDEN1 = 1;
                NS = ST_EXEC;
            end
            
            ST_EXEC: begin
                RF_WRITE = 1;
                PC_WRITE = 1;
                
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
                endcase
            end
            
            ST_WRITEBACK: begin
                RF_WRITE = 1;
                PC_WRITE = 1;
                
                NS = ST_FETCH;
            end
        endcase
    end
endmodule
