`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/19/2025 11:51:18 PM
// Design Name: 
// Module Name: reference_sample_generation
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

module reference_sample_generation (
    input  logic                       clk,
    input  logic                       rst_n,
    input  logic                       start,        // start signal
    input  logic signed [9:0]          B,            // intra pred angle parameter

    output logic                        done,         // operation done
    output logic [7:0]                  refx [0:15], // extended top reference
    output logic [7:0]                  refy [0:15]  // extended left reference
);

    // -------------------------------------------------
    // Internal 2D memory for pixel block
    // -------------------------------------------------
    logic [7:0] p [3:0][3:0]; 

    
   /*
    initial
       begin
       $readmemh("C:/Users/Administrator/Downloads/pixel_block.hex",p);
       end
    */

initial
begin
p[0][0]=1;    
p[0][1]=2;
p[0][2]=3;
p[0][3]=4;
p[1][0]=5;
p[1][1]=6;
p[1][2]=7;
p[1][3]=8;

p[2][0]=1;      
p[2][1]=2;
p[2][2]=3;
p[2][3]=4;
p[3][0]=5;
p[3][1]=6;
p[3][2]=7;
p[3][3]=8;
end





    integer x, y;

    // -------------------------------------------------
    // Build reference arrays on "start"
    // -------------------------------------------------
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            done <= 0;
        end
        else if (start) begin
            // =====================================================
            // Fill refx (vertical modes reference array)
            // =====================================================
            for (x = 0; x <= 7; x = x + 1) begin
                refx[x] <= p[0][x];   // p[-1][x] approximated by top row
            end
            
            //For Negative Indexes
            for (x = 8; x < 16; x = x + 1) begin
                refx[x] <= p[0][ ((x*B + 128) >>> 8) ];  
            end

            // =====================================================
            // Fill refy (horizontal modes reference array)
            // =====================================================
            for (y = 0; y <= 7; y = y + 1) begin
                refy[y] <= p[y][0];   // p[y][-1] approximated by left column
            end
            
            for (y = 8; y < 16; y = y + 1) begin
                refy[y] <= p[((y*B + 128) >>> 8)][0]; 
            end

            done <= 1;
        end
    end

endmodule
