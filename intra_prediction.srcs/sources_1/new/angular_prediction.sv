`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/01/2025 12:06:24 PM
// Design Name: 
// Module Name: angular_prediction
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


module angular_prediction #(
    parameter data_width = 8
)(
    input logic clk,
    input logic rst,
    input logic [5:0] A,                       // Angular parameter
    input logic [3:0] x, y,                   // Pixel location
    output logic [data_width-1:0] p_out
);


   logic mode;  // 1 for horizontal, 0 for vertical

   logic [data_width-1:0] ref_mem [0:15]; // Reference pixels
   logic [data_width-1:0] p; 
    
  initial
       begin
       $readmemh("C:/Users/Administrator/Downloads/ref_memory.hex",ref_mem);
       end


   always_comb   begin
   if(A>=2 && A<=17)
   mode=1;
   
   else if (A>=18 && A<=34)
   mode=0;
   end   

    logic [5:0] i;
    logic [5:0] f;
    logic [data_width+5:0] mul1, mul2;
    logic [data_width+5:0] sum;
    logic [data_width-1:0] ref1, ref2;

    always_comb begin
        if (mode && A>=2 && A<=17) begin //modes(2 to 17) Based on A
            i = ((x + 1) * A) >> 5;
            f = ((x + 1) * A) & 6'd31;   //4.12 from Book
            ref1 = ref_mem[y + i + 1];
            ref2 = ref_mem[y + i + 2];
        end else if (~mode && A>=18 && A<=34)  begin //modes (18 to 34 based on A) 
            i = ((y + 1) * A) >> 5;
            f = ((y + 1) * A) & 6'd31;
            ref1 = ref_mem[x + i + 1];
            ref2 = ref_mem[x + i + 2];
        end
        else  begin  //Illegal Condition 
            i = 0;
            f = 0;
            ref1 = ref_mem[y + i + 1];
            ref2 = ref_mem[y + i + 2];
        end  

        mul1 = (32 - f) * ref1;
        mul2 = f * ref2;
        sum = mul1 + mul2 + 16;
        p = sum >> 5;                //The Predicted value at current pixel location (x,y)
    end

   always_ff@(posedge clk) begin
           if(rst) 
            p_out<=0;
            else
            p_out<=p;
  end
endmodule 