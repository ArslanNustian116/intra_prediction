`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/20/2025 02:42:13 AM
// Design Name: 
// Module Name: tb_reference_array
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

`timescale 1ns/1ps

module tb_reference_sample_arrays;

  // Testbench signals
  logic clk;
  logic rst;
  logic [3:0] x, y;
  logic [7:0] B;
  logic [7:0] ref_out1, ref_out2;

  // Instantiate DUT
  reference_sample_arrays dut (
    .clk(clk),
    .rst(rst),
    .x(x),
    .y(y),
    .B(B),
    .ref_out1(ref_out1),
    .ref_out2(ref_out2)
  );

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;   // 10ns period

  // Stimulus
  initial begin
    // Initialize
    rst = 1;
    B = 8'd5;   // Example value for B
    x = 0;
    y = 0;

    // Apply reset
    #20;
    rst = 0;


        for (int xi = 0; xi <= 15; xi++) begin
      for (int yi = 0; yi <= 15; yi++) begin
        @(posedge clk);  // <<< Apply at clock edge
        x <= xi;
        y <= yi;
        B <= 8'd5; // Example constant
        @(posedge clk); // Wait for DUT to update outputs
    
        $display("Time=%0t | x=%0d | y=%0d | ref_out1=%0d | ref_out2=%0d",
                 $time, x, y, ref_out1, ref_out2);
      end
    end


    // End simulation
    $display("Simulation completed at %0t", $time);
    $finish;
  end

  // VCD dump for GTKWave
  initial begin
    $dumpfile("reference_sample_arrays_tb.vcd");
    $dumpvars(0, tb_reference_sample_arrays);
  end

endmodule
