`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/11/2025 12:03:44 AM
// Design Name: 
// Module Name: planar_prediction
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


module planar_prediction(
    input clk,
    input rst,
    input [7:0] data_in,
    input [4:0]x,
    input [4:0]y,
    output logic [7:0] Predict_planar
    );
    
  parameter N=32;  
    
    
 //Horizontal and Vertical Arrays
 logic [7:0] hor[0:31][0:31]; //32 x32 horizontal Array   
 logic [7:0] ver[0:31][0:31]; //32 x32 vertical Array   
     
 //Sample Reference Sample Array 2 D
 logic [7:0] p[0:31][0:31];     

// 2D array to store planar prediction results
logic [7:0] predict_sum[0:31][0:31];

integer i;
integer j;

always_ff@(posedge clk)
if(rst)
for (i=0; i<32; i = i+1)begin     
    for (j=0; j<32; j = j+1)begin
    p[i][j]<=0;
    end
end
else    
    p[x][y]<=data_in;
    

//assign Predict_planar=p[x][y];

// Planar prediction computation
    logic [15:0] sum;
    /*
    always_comb begin
    sum=0;
        // Planar formula from H.265 spec using p[] as reference storage
        sum =  ( ( (N-1 - x) * p[0][y+1] ) +    // left ref     hor[x][y] 
               ( (x+1)     * p[N-1][y+1] ) +  // right ref
               ( (N-1 - y) * p[x+1][0] ) +    // top ref      ver[x][y]
               ( (y+1)     * p[x+1][N-1] ) +  // bottom ref
               N)  ;                             

        Predict_planar = sum;// / (2 * N);
    end
     */

     always_ff @(posedge clk)begin
     if(rst)begin
     sum <=0;
     Predict_planar <=0;
     end
      
        else begin
                 // Planar formula from H.265 spec using p[] as reference storage
             sum <=  ( ( (N-1 - x) * p[0][y+1] ) +    // left ref     hor[x][y] 
                    ( (x+1)     * p[N-1][y+1] ) +  // right ref
                    ( (N-1 - y) * p[x+1][0] ) +    // top ref      ver[x][y]
                    ( (y+1)     * p[x+1][N-1] ) +  // bottom ref
                    N)  ;                             
     
              Predict_planar <= sum >> 6 ;// Sum/ (2 * N);
         end    
      end


    // Store prediction results in predict_sum array
    always_ff @(posedge clk) begin
        if (!rst) begin
           predict_sum[x][y] <= Predict_planar;
        end
    end
    
    
endmodule
