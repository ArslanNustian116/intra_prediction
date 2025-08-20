`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/19/2025 11:40:12 PM
// Design Name: 
// Module Name: tb_angular_prediction
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


`timescale 1ns / 1ps

module angular_prediction_simple_tb;

    // =========================================================================
    // Parameters and signals
    // =========================================================================
    parameter DATA_WIDTH = 8;
    parameter CLK_PERIOD = 10; // 10 ns clock period (100 MHz)

    // DUT inputs
    logic clk;
    logic rst;
    logic [5:0] A;
    logic [3:0] x;
    logic [3:0] y;

    // DUT output
    logic [DATA_WIDTH-1:0] p_out;

    
    // Create a clock signal
    initial begin
        clk = 0;
        forever #(CLK_PERIOD / 2) clk = ~clk;
    end

    // Instantiate the DUT (Device Under Test)
    angular_prediction #(.data_width(DATA_WIDTH)) dut (
        .clk(clk),
        .rst(rst),
        .A(A),
        .x(x),
        .y(y),
        .p_out(p_out)
    );

    // =========================================================================
    // Simplified test logic
    // =========================================================================
    initial begin
        // Load the reference memory. This file must exist.
        // It should contain 16 lines of hex values for the reference pixels.
      
        // Initial values and reset
        rst = 1;
        A   = 0;
        x   = 0;
        y   = 0;
        
        @(posedge clk);
        rst = 0;
        $display("--------------------------------------------------");
        $display("Starting simplified simulation...");
        $display("--------------------------------------------------");

        // Loop through a small subset of x and y coordinates
        // and assign a random A for each.
        for (integer i_x = 0; i_x < 4; i_x++) begin
            for (integer i_y = 0; i_y < 4; i_y++) begin
                // Assign inputs
                x = i_x;
                y = i_y;
                A = $urandom_range(34, 1); // Get a random A between 1 and 34

                // Wait for the next clock edge to sample the output
                @(posedge clk);
                #1; // Wait for combinational logic to settle

                // Display the current inputs and the resulting output
                $display("A=%0d, x=%0d, y=%0d -> p_out = %0d", A, x, y, p_out);
            end
        end

        $display("--------------------------------------------------");
        $display("Simulation finished.");
        $finish; // End the simulation
    end

endmodule
