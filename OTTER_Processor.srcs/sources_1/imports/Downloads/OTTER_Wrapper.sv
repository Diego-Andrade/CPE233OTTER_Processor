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
    
//    localparam WA    = 32'h11010000;
//    localparam WD    = 32'h11020000;
//    localparam WE    = 32'h11030000;
            
    
   // Signals for connecting OTTER_MCU to OTTER_wrapper /////////////////////
   logic s_reset, s_load, s_intr;
   logic s_clk = 0;
   
   // Peripheral data signals //////////////////////////////////////////////  
   logic [15:0]  r_SSEG;
     
   logic [31:0] IOBUS_out,IOBUS_in,IOBUS_addr;
   logic IOBUS_wr;
    
//   logic [12:0] tempWA;
//   logic [7:0] tempWD;
//   logic tempWE;
    
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
   
    WS2813_Driver leds(.CLK(CLK), 
        .Din({
            SWITCHES[15:11], 3'b000, 
            SWITCHES[10:5], 2'b00, 
            SWITCHES[4:0], 3'b000
            }), 
        .Dout(LEDSTRIP));
                      
   //vga_fb_driver(.CLK(sclk), .WA(tempWA), .WD(tempWD), .WE(tempWE));
                           
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
//                WA: tempWA <= IOBUS_out[12:0];
//                WD: tempWD <= IOBUS_out[7:0];
//                WE: tempWE <= IOBUS_out[0];
            endcase
    end
   
   endmodule
