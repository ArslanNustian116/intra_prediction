`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/20/2025 12:12:56 AM
// Design Name: 
// Module Name: tb_reference_samples
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


// File: reference_sample_generation_tb.v
//
// A very basic and simple testbench for the reference_sample_generation module.
// It applies a few sets of inputs and displays the output arrays.

`timescale 1ns / 1ps

module reference_sample_generation_tb;

    // =========================================================================
    // Parameters and signals
    // =========================================================================
    // The parameters must match the DUT's parameters.
    parameter N          = 8;
    parameter CLK_PERIOD = 10; // 10 ns clock period (100 MHz)

    // DUT inputs - declared as `reg` in the testbench
    reg clk;
    reg rst_n;
    reg start;
    reg signed [9:0] B;

    // DUT outputs - declared as `wire` in the testbench
    wire done;
    wire [7:0] refx [0:15];
    wire [7:0] refy [0:15];

    // Instantiate the Device Under Test (DUT)
    reference_sample_generation dut (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .B(B),
        .done(done),
        .refx(refx),
        .refy(refy)
    );

    // =========================================================================
    // Clock generation
    // =========================================================================
    initial begin
        clk = 0;
        forever #(CLK_PERIOD / 2) clk = ~clk;
    end

    // =========================================================================
    // Test stimulus
    // =========================================================================
    initial begin
        $display("-----------------------------------------------------");
        $display("Starting simulation for reference_sample_generation.");
        $display("-----------------------------------------------------");

        // Initial values and reset sequence
        rst_n = 0; // Assert reset
        start = 0;
        B     = 0;
        @(posedge clk);
        rst_n = 1; // De-assert reset
        $display("Reset complete.");

        // --- Test Case 1: Start with a positive B value ---
        $display("\n--- Test Case 1: B = 100 ---");
        B     = 100;
        start = 1;
        @(posedge clk);
        start = 0; // Hold start for one cycle
        @(posedge clk);
        #1; // Wait for combinational logic to settle
        $display("Done signal is: %d", done);
        
        // Display the contents of the output arrays
        $display("refx array:");
        for (integer i = 0; i <= 31; i = i + 1) begin
            $display("  refx[%0d] = %d", i, refx[i]);
        end

        $display("\nrefy array:");
        for (integer j = 31; j <= 63; j = j + 1) begin
            $display("  refy[%0d] = %d", j, refy[j]);
        end


        // --- Test Case 2: Start with a negative B value ---
        $display("\n--- Test Case 2: B = -50 ---");
        B     = -50;
        start = 1;
        @(posedge clk);
        start = 0;
        @(posedge clk);
        #1;
        $display("Done signal is: %d", done);
        
        $display("refx array:");
        for (integer i = 0; i <= 31; i = i + 1) begin
            $display("  refx[%0d] = %d", i, refx[i]);
        end

        $display("\nrefy array:");
        for (integer j = 31; j <= 63; j = j + 1) begin
            $display("  refy[%0d] = %d", j, refy[j]);
        end

        $display("-----------------------------------------------------");
        $display("Simulation finished.");
        $finish;
    end

endmodule
