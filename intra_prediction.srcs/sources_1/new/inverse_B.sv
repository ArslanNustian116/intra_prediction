`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/10/2025 10:02:15 PM
// Design Name: 
// Module Name: Inverse_B
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


module Inverse_B(
    input logic signed [6:0] A,
    output logic signed [13:0] B
    );
    
//LUT for Inverse Angle Parameter B of Angular Parameter A Table 4.3
always_comb
 begin
 case(A)
 -32:B=-256;
 -26:B=-315;
 -21:B=-390;
 -17:B=-482;
 -13:B=-630;
 -9:B=-910;
  -5:B=-1638;
  -2:B=-4096;
  
  default B=0;
  endcase  

 end
    
    
    
endmodule
