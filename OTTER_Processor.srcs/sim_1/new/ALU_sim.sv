`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/30/2020 05:51:22 PM
// Design Name: 
// Module Name: ALU_sim
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


module ALU_sim();
    logic [31:0] A, B;
    logic [3:0] FUN;
    logic [31:0] RESULT;
    
    ALU alu( .A(A), .B(B), .ALU_FUN(FUN), .RESULT(RESULT));
    
    initial begin
        FUN = 4'b0000;                          // ADD
        A = 32'hA50F96C3; B = 32'h5AF0693C; #1;
        A = 32'h84105F21; B = 32'h7B105FDE; #1;
        A = 32'hFFFFFFFF; B = 32'h00000001; #1;       
        
        FUN = 4'b1000;                          // SUB
        A = 32'h00000000; B = 32'h00000001; #1; 
        A = 32'hAA806355; B = 32'h550162AA; #1;
        A = 32'h550162AA; B = 32'hAA806355; #1;
        
        FUN = 4'b0110;                          // OR
        A = 32'h9A9AC300; B = 32'h65A3CC0F; #1;
        A = 32'hC3C3F966; B = 32'hFF669F5A; #1;
        
        FUN = 4'b0111;                          // AND
        A = 32'hA55A00FF; B = 32'h5A5AFFFF; #1;
        A = 32'hC3C3F966; B = 32'hFF669F5A; #1;
        
        FUN = 4'b0100;                          // XOR
        A = 32'hAA5500FF; B = 32'h5AA50FF0; #1;
        A = 32'hA5A56C6C; B = 32'hFF00C6FF; #1;
        
        FUN = 4'b0101;                          // SRL
        A = 32'h805A6CF3; B = 32'h00000010; #1;
        A = 32'h705A6CF3; B = 32'h00000005; #1;
        A = 32'h805A6CF3; B = 32'h00000000; #1;
        A = 32'h805A6CF3; B = 32'h00000100; #1;
        
        FUN = 4'b0001;                          // SLL
        A = 32'h805A6CF3; B = 32'h00000010; #1;
        A = 32'h805A6CF3; B = 32'h00000005; #1;
        A = 32'h805A6CF3; B = 32'h00000100; #1;
        
        FUN = 4'b1101;                          // SRA
        A = 32'h805A6CF3; B = 32'h00000010; #1;
        A = 32'h705A6CF3; B = 32'h00000005; #1;
        A = 32'h805A6CF3; B = 32'h00000000; #1;
        A = 32'h805A6CF3; B = 32'h00000100; #1;
        
        FUN = 4'b0010;                          // SLT
        A = 32'h7FFFFFFF; B = 32'h80000000; #1;
        A = 32'h80000000; B = 32'h00000001; #1;
        A = 32'h00000000; B = 32'h00000000; #1;
        A = 32'h55555555; B = 32'h55555555; #1;
        
        FUN = 4'b0011;                          // SLTU
        A = 32'h7FFFFFFF; B = 32'h80000000; #1;
        A = 32'h80000000; B = 32'h00000001; #1;
        A = 32'h00000000; B = 32'h00000000; #1;
        A = 32'h55AA55AA; B = 32'h55AA55AA; #1;
                
        FUN = 4'b1001;                          // LUI - copy
        A = 32'h01234567; B = 32'h76543210; #1;
        A = 32'hFEDCBA98; B = 32'h89ABCDEF; #1;
        
    end
endmodule
