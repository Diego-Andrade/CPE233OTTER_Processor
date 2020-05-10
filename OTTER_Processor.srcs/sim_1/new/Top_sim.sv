`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/23/2020 12:58:43 AM
// Design Name: 
// Module Name: Top_sim
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


module Top_sim();
    
    logic CLK;
    logic INTR;
    logic RST;
    logic [15:0] SWITCHES;
    logic [15:0] LEDS;
    logic [7:0] CATHODES;
    logic [3:0] ANODES;
    logic LEDSTRIP;
    
    OTTER_Wrapper wp(
            .CLK(CLK), 
            .RST(RST), 
            .INTR(INTR),
            .SWITCHES(SWITCHES),
            .LEDS(LEDS),
            .CATHODES(CATHODES),
            .ANODES(ANODES),
            .LEDSTRIP(LEDSTRIP));
            
    always begin
        CLK = 0; #1;
        CLK = 1; #1;
    end
    
    initial begin
        SWITCHES = 6;
        RST = 0;
        INTR = 0;
        
        // Trigger interrupt6
        #300
        INTR = 1;
        #140
        INTR = 0;
        
//        BTNC = 1; #50;
//        BTNC = 0; #5;
    
    end
endmodule
