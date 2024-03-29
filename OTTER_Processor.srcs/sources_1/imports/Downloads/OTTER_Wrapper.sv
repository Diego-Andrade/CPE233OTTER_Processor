`timescale 1ns / 1ps
/////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: J. Calllenes
//           P. Hummel
//
// Create Date: 01/20/2019 10:36:50 AM
// Module Name: OTTER_Wrapper
// Target Devices: OTTER MCU on Basys3
// Description: OTTER_WRAPPER with Switches, LEDs, and 7-segment display
//
// Revision:
// Revision 0.01 - File Created
/////////////////////////////////////////////////////////////////////////////

module OTTER_Wrapper(
   input CLK,
   input RST,
   input INTR,
   input [15:0] SWITCHES,
   output logic [15:0] LEDS,
   output [7:0] CATHODES,
   output [3:0] ANODES,
   output logic LEDSTRIP
   );
     
    // INPUT PORT IDS ///////////////////////////////////////////////////////
    // Right now, the only possible inputs are the switches
    // In future labs you can add more MMIO, and you'll have
    // to add constants here for the mux below
    localparam SWITCHES_AD = 32'h11000000;
        
    // OUTPUT PORT IDS //////////////////////////////////////////////////////
    // In future labs you can add more MMIO
    localparam LEDS_AD    = 32'h11080000;
    localparam SSEG_AD    = 32'h110C0000;
    
    localparam LED1_AD    = 32'h11100000;
    localparam LED2_AD    = 32'h11140000;
    localparam LED3_AD    = 32'h11180000;
    localparam LED4_AD    = 32'h111C0000;
    localparam LED5_AD    = 32'h11200000;
    localparam LED6_AD    = 32'h11240000;
    localparam LED7_AD    = 32'h11280000;
    localparam LED8_AD    = 32'h112C0000;
            
    
   // Signals for connecting OTTER_MCU to OTTER_wrapper /////////////////////
   logic s_reset, s_intr;
   logic s_clk = 0;
   
   // Peripheral data signals //////////////////////////////////////////////  
   logic [15:0]  r_SSEG;  
   
   logic [23:0] LED1, LED2, LED3, LED4, LED5, LED6, LED7, LED8;
     
   logic [31:0] IOBUS_out,IOBUS_in,IOBUS_addr;
   logic IOBUS_wr;
    
   // Declare OTTER_CPU ////////////////////////////////////////////////////
    OTTER_Processor MCU (
        .RST(s_reset),  
        .INTR(s_intr), 
        .CLK(s_clk),
        .IOBUS_OUT(IOBUS_out),
        .IOBUS_IN(IOBUS_in),
        .IOBUS_ADDR(IOBUS_addr),
        .IOBUS_WR(IOBUS_wr));

    // Connect peripherals /////////////////////////////////////////////////

    SevSegDisp SSG_DISP(.DATA_IN(r_SSEG), .CLK(CLK), .MODE(1'b0),
        .CATHODES(CATHODES), .ANODES(ANODES));
   
    debounce_one_shot interupt(
        .CLK(s_clk),
        .BTN(INTR),
        .DB_BTN(s_intr));
   
    WS2813_Driver blade1(.CLK(CLK), 
        .LED1(LED1), .LED2(LED2), .LED3(LED3), .LED4(LED4), 
        .LED5(LED5), .LED6(LED6), .LED7(LED7), .LED8(LED8),   
        .Dout(LEDSTRIP));
                      
   // Clock Divider to create 50 MHz Clock //////////////////////////////////
   always_ff @(posedge CLK) begin
       s_clk <= ~s_clk;
   end
   
   // Connect Signals ///////////////////////////////////////////////////////
   assign s_reset = RST;
   
   // Connect Board input peripherals (Memory Mapped IO devices) to IOBUS
   always_comb begin
        case(IOBUS_addr)
            SWITCHES_AD: IOBUS_in = {16'b0,SWITCHES};
            default:     IOBUS_in = 32'b0;    // default bus input to 0
        endcase
    end
   
  
   // Connect Board output peripherals (Memory Mapped IO devices) to IOBUS
    always_ff @ (posedge s_clk) begin
        if(IOBUS_wr)
            case(IOBUS_addr)
                LEDS_AD: LEDS   <= IOBUS_out[15:0];
                SSEG_AD: r_SSEG <= IOBUS_out[15:0];
                
                LED1_AD: LED1   <= IOBUS_out[23:0];
                LED2_AD: LED2   <= IOBUS_out[23:0];
                LED3_AD: LED3   <= IOBUS_out[23:0];
                LED4_AD: LED4   <= IOBUS_out[23:0];
                LED5_AD: LED5   <= IOBUS_out[23:0];
                LED6_AD: LED6   <= IOBUS_out[23:0];
                LED7_AD: LED7   <= IOBUS_out[23:0];
                LED8_AD: LED8   <= IOBUS_out[23:0];
            endcase
    end
   
   endmodule
