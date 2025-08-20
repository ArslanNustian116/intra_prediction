`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/20/2025 02:21:47 AM
// Design Name: 
// Module Name: reference_sample_arrays
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


module reference_sample_arrays(
    input clk,
    input rst,
    input logic signed [3:0]x,
    input logic signed [3:0]y,
    input logic signed [7:0]B,
    output logic [7:0] ref_out1,   //For X
    output logic [7:0] ref_out2   //For Y
     );
    
    logic [7:0] p [0:7][0:7]; //2 D Pixel Array
    
    logic [7:0] ref_x[0:7];  //Reference Array X
    logic [7:0] ref_y[0:7]; //Reference Array y
        
        
    // The values of p are determined by other inputs or logic
        always_comb begin
            for (int i = 0; i < 8; i++) begin
                for (int j = 0; j < 8; j++) begin
                    // Example: Initialize based on inputs x and y
                    p[i][j] = (i * 8) + j; 
                end
            end
        end    
    
    //Reference X Equations
    always_comb begin
    if(x>0)
    ref_x[x]= p[x][0]; //Equation 4.8  x > 0 Vertical Mode  
    else 
    ref_x[x]=(p[0][-1 + (x*B) + 128 >>8]) ; // Equation 4.10 
    end
    
    //Reference Y Equations
        always_comb begin
        if(y>0)
        ref_y[y]= p[0][y]; //Equation 4.9  x > 0 Horizontal Mode p[-1][-1+y]  
        else 
        ref_y[y]= p[-1 + (y*B) + 128 >> 8][0] ; // Equation 4.11 
        end
        
    always_ff@(posedge clk)
    if(rst)
    ref_out1<=0;
    else
    ref_out1<=ref_x[x];
    
    always_ff@(posedge clk)
     if(rst)
     ref_out2<=0;
     else
    ref_out2<=ref_y[y];
        
    
endmodule
