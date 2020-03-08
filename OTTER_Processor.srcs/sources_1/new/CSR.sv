`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/02/2020 10:20:54 PM
// Design Name: 
// Module Name: CSR
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


module CSR(
    input CLK,
    input RST,
    input INTR_TAKEN,
    input [11:0] ADDR,
    input WE,
    input [31:0] PC,
    input [31:0] WD,
    output logic MIE,
    output [31:0] MEPC,
    output [31:0] MTVEC,
    output [31:0] RD
    );
   
    logic [31:0] csr [0:833];
    
    always_ff @ (posedge CLK) begin
        if (RST) begin
            csr[12'h304] <= 0;       
            csr[12'h341] <= 0;         
            csr[12'h305] <= 0;
        end
        else if (WE) begin 
            csr[ADDR] <= WD; 
        end
        else if (INTR_TAKEN) begin
            csr[12'h305] <= 0;      // MIE
            csr[12'h341] <= PC;     // MEPC
        end
    end
    
    assign MIE = csr[12'h304][0];       
    assign MEPC = csr[12'h341];         
    assign MTVEC = csr[12'h305]; 
    assign RD = csr[ADDR];
    
endmodule
