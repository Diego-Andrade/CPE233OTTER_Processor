`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/17/2020 02:00:14 PM
// Design Name: 
// Module Name: OTTER_Processor_sim
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


module OTTER_Processor_sim();

    logic CLK;
    logic RST = 0;
    
    OTTER_Processor processor(.CLK(CLK), .RST(RST));
    
    always begin
        CLK = 1; #5;
        CLK = 0; #5;
    end
    
    initial begin
        #35;
        RST = 1;
        #10
        RST = 0;
    end
    
endmodule
