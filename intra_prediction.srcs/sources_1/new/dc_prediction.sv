`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/11/2025 02:34:39 AM
// Design Name: 
// Module Name: dc_prediction
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


module dc_prediction(
    output logic [7:0] dc_out,
    input logic clk,
    input logic rst
    );

parameter N=8;

logic [7:0] p[7:0][7:0]; //Pixel Array 

initial
begin
p[0][0]=1;    //Adjust p[x][-1] accordingly
p[1][0]=2;
p[2][0]=3;
p[3][0]=4;
p[4][0]=5;
p[5][0]=6;
p[6][0]=7;
p[7][0]=8;
end

initial
begin
p[0][0]=1;      //Adjust p[-1][y] accordingly
p[0][1]=2;
p[0][2]=3;
p[0][3]=4;
p[0][4]=5;
p[0][5]=6;
p[0][6]=7;
p[0][7]=8;
end



logic [7:0] sum_x;
logic [7:0] sum_y;


always_comb
begin
integer x;
sum_x=0;
for (x=0;x<8; x= x+1)
sum_x=sum_x+p[x][0];
end

always_comb
begin
integer y;
sum_y=0;
for (y=0;y<8; y= y+1)
sum_y=sum_y+p[0][y];
end

assign dc_out=sum_x+sum_y + N ;

logic [7:0] P[0:7][7:0];

always_comb 
P[0][0]= (p[0][1] + (2 * dc_out) + p[1][0]) >> 2; 

always_comb 
begin
integer x;
for (x=1; x<7; x=x+1)  // x= 1: N-1
P[x][0]= (p[x+1][0] + (3 * dc_out) + 2) >> 2; 
end

always_comb 
begin
integer y;
for (y=1; y<7; y=y+1)  // x= 1: N-1
P[0][y]= (p[0][y+1] + (3 * dc_out) + 2) >> 2; 
end

always_ff@(posedge clk)
 if(rst)
 dc_out<=0;
 else
 dc_out<=sum_x+sum_y + N ;


endmodule
