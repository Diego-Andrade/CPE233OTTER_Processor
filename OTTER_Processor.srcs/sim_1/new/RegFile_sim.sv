`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/24/2020 12:05:11 PM
// Design Name: 
// Module Name: RegFile_sim
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


module RegFile_sim();

logic CLK, RF_EN;
logic [4:0] RF_ADDR1, RF_ADDR2, RF_WA;
logic [31:0] RF_WD;

logic [31:0] RF_RS1, RF_RS2 ;

RegFile regFile(
        .CLK(CLK), 
        .RF_ADDR1(RF_ADDR1),
        .RF_ADDR2(RF_ADDR2),
        .RF_EN(RF_EN),
        .RF_WA(RF_WA),
        .RF_WD(RF_WD),
        .RF_RS1(RF_RS1), .RF_RS2(RF_RS2)
        );
        
always begin
    CLK = 0; #5;
    CLK = 1; #5;
end

initial begin
    RF_EN = 0;
    RF_ADDR1 = 0; RF_ADDR2 = 1;
    RF_WA = 0;
    RF_WD = 0;
    
    #2;         // Initial offset delay
    
    // Writting to x0
    RF_WA = 0;
    RF_WD = 32'hf;
    RF_EN = 1;
    #5
    RF_EN = 0;
    #5
    
    // Writting to x1
    RF_WA = 1;
    RF_WD = 32'hc;
    RF_EN = 1;
    #5
    RF_EN = 0;
    #5
    
    // Writting to x8 and x9
    RF_WA = 8;
    RF_WD = 32'h13;
    RF_EN = 1;
    #5
    RF_EN = 0;
    #5
    RF_WA = 9;
    RF_WD = 32'ha4;
    RF_EN = 1;
    #5
    RF_EN = 0;
    #5
    
    // Test async read 
    #2
    RF_ADDR1 = 8;
    #4
    RF_ADDR2 = 9;
    #2
    RF_ADDR1 = 1;

end

endmodule
