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
    input [0:23] Din,
    output logic Dout
    );
    
    typedef enum {  ST_HOLD, 
                    ST_T1H, ST_T1L,
                    ST_T0H, ST_T0L } State;
    
    State PS, NS;
    
    // 10n per clk
    const logic [15:0] T1H_CLOCKS = 80; // 800 ns = 40 clks
    const logic [15:0] T1L_CLOCKS = 45; // 450 ns = 23 clks 
    const logic [15:0] T0H_CLOCKS = 35; // 340 ns = 17 clks 
    const logic [15:0] T0L_CLOCKS = 90; // 900 ns = 45 clks 
    const logic [15:0] HOLD_CLOCKS = 30000; // 300 us = 15000 clks
    
   
    const logic [4:0] MESSAGE_SIZE = 5'h17;     // = 24 * num_leds - 1
                        
    logic [15:0] clk_count = 0;
    logic count_rst;
    
    logic [4:0] curr_bit = 0;
    logic curr_bit_rst, curr_bit_increase; 
    
    // Temp debugging
    logic done = 0;
    
    
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
                    
                    if (Din[0] == 1'b1)                 // Start sending '1' or '0' of beginning message
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
                    else if (Din[curr_bit + 1] == 1'b1)
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
                    else if (Din[curr_bit + 1] == 1'b1)
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
