`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/29/2020 10:27:57 AM
// Design Name: 
// Module Name: WS2813_Driver
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


module WS2813_Driver(
    input CLK,
    input [23:0] LED1, LED2, LED3, LED4, LED5, LED6, LED7, LED8,
    output logic Dout
    );
    
    typedef enum {  ST_HOLD, 
                    ST_T1H, ST_T1L,
                    ST_T0H, ST_T0L } State;
    
    State PS, NS;
    
    // Timing variables. 10n per clk
    const logic [15:0] T1H_CLOCKS = 80; // 800 ns = 40 clks
    const logic [15:0] T1L_CLOCKS = 45; // 450 ns = 23 clks 
    const logic [15:0] T0H_CLOCKS = 35; // 340 ns = 17 clks 
    const logic [15:0] T0L_CLOCKS = 90; // 900 ns = 45 clks 
    const logic [15:0] HOLD_CLOCKS = 30000; // 300 us = 15000 clks
    
    const logic [7:0] MESSAGE_SIZE = 191;       // End of message = 24 * num_leds - 1
  
    // Message to send
    logic [0:191] message = { 
        {LED1[15:8], LED1[23:16], LED1[7:0]}, 
        {LED2[15:8], LED2[23:16], LED2[7:0]}, 
        {LED3[15:8], LED3[23:16], LED3[7:0]}, 
        {LED4[15:8], LED4[23:16], LED4[7:0]}, 
        {LED5[15:8], LED5[23:16], LED5[7:0]}, 
        {LED6[15:8], LED6[23:16], LED6[7:0]}, 
        {LED7[15:8], LED7[23:16], LED7[7:0]}, 
        {LED8[15:8], LED8[23:16], LED8[7:0]}     
    };  
                        
    logic [15:0] clk_count = 0;                
    logic count_rst;
    
    logic [7:0] curr_bit = 0;                   // Current bit being sent out
    logic curr_bit_rst, curr_bit_increase; 
    
    logic done = 0;                             // Signal to spot sending data, proably should be
                                                // implemented like VGA output data
    
    // Counter block to count the number of clock pulses when enabled  /////////
    // Triggered every 20 ns
    always_ff @(posedge CLK) begin
        PS <= NS;
    
        if (count_rst == 1'b1)
            clk_count <= 0;
        else
            clk_count <= clk_count + 1;
            
        if (curr_bit_rst == 1'b1)
            curr_bit <= 0;
        else if(curr_bit_increase == 1'b1)
            curr_bit <= curr_bit + 1;
    end
    ////////////////////////////////////////////////////////////////////////////    
     
    always_comb begin
        NS = ST_HOLD;
        count_rst = 1'b0;
        curr_bit_rst = 1'b0;
        curr_bit_increase = 1'b0;
                
        Dout = 1'b0;
        
        case (PS)
            ST_HOLD: begin
                Dout = 1'b0;                            // Output low
            
                if (clk_count == HOLD_CLOCKS && ~done) begin
                    count_rst = 1'b1;
                    curr_bit_rst = 1'b1;                // Reset to begin of message
                    
                    if (message[0] == 1'b1)                 // Start sending '1' or '0' of beginning message
                        NS = ST_T1H;
                    else
                        NS = ST_T0H;
                end
                else 
                    NS = ST_HOLD;
            end
            
            ST_T0H: begin
                Dout = 1'b1;                            // Output high
                
                if (clk_count == T0H_CLOCKS) begin
                    count_rst = 1'b1;
                    NS = ST_T0L;
                end
                else 
                    NS = ST_T0H;
            end
            
            ST_T0L: begin
                Dout = 1'b0;                            // Output low
                
                if (clk_count == T0L_CLOCKS) begin
                    count_rst = 1'b1;
                    curr_bit_increase = 1'b1;
                    
                    if (curr_bit == MESSAGE_SIZE) begin
                        NS = ST_HOLD;
                        //done = 1;                           // TEMP
                    end
                    else if (message[curr_bit + 1] == 1'b1)
                        NS = ST_T1H;
                    else 
                        NS = ST_T0H;
                end
                else
                    NS = ST_T0L;
            end
            
            ST_T1H: begin
                Dout = 1'b1;                            // Output high
                if (clk_count == T1H_CLOCKS) begin
                    NS = ST_T1L;
                    count_rst = 1'b1;
                end
                else begin
                    NS = ST_T1H;
                end
            end
            
            ST_T1L: begin
                Dout = 1'b0;                            // Output low
                if (clk_count == T1L_CLOCKS) begin
                    count_rst = 1'b1;
                    curr_bit_increase = 1'b1;
                    
                    if (curr_bit == MESSAGE_SIZE) begin
                        NS = ST_HOLD;
//                        done = 1;                       // TEMP
                    end
                    else if (message[curr_bit + 1] == 1'b1)
                        NS = ST_T1H;
                    else 
                        NS = ST_T0H;
                end
                else
                    NS = ST_T1L;
            end
            
            default: begin
                // Fail safe
            end
        endcase
    end    
        
        
        
endmodule
