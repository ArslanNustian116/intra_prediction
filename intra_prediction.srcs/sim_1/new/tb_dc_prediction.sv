`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/20/2025 09:30:36 PM
// Design Name: 
// Module Name: tb_dc_prediction
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

module tb_dc_prediction;

  // Clock and reset
  logic clk;
  logic rst;

  // DUT output
  logic [7:0] dc_out;

  // Parameter (matches DUT default)
  localparam int N = 8;

  // Instantiate DUT
  dc_prediction #(.N(N)) dut (
    .dc_out(dc_out),
    .clk   (clk),
    .rst   (rst)
  );

  // Clock: 10 ns period
  initial clk = 1'b0;
  always #5 clk = ~clk;

  // Optional expected value based on your initial arrays:
  // p[0..7][0] = 1..8  => sum_x = 1+...+8 = 36
  // p[0][0..7] = 1..8  => sum_y = 1+...+8 = 36
  // expected = sum_x + sum_y + N = 36 + 36 + 8 = 80
  localparam int EXPECTED = 36 + 36 + N;

  // Stimulus
  initial begin
    // Initialize
    rst = 1'b1;

    // Hold reset for a few cycles
    repeat (3) @(posedge clk);
    rst = 1'b0;

    // Run a few cycles and print dc_out
    repeat (6) begin
      @(posedge clk);
      #1; // small delay to sample after the edge

      $display("%0t ns : dc_out = %0d (0x%0h)%s",
               $time, dc_out, dc_out,
               (dc_out === EXPECTED[7:0]) ? "  <-- OK" :
               (dc_out === 'x) ? "  <-- X (check DUT drivers)" : "  <-- MISMATCH");
    end

    $display("Testbench finished at %0t ns", $time);
    $finish;
  end

  // Wave dump
  initial begin
    $dumpfile("dc_prediction_tb.vcd");
    $dumpvars(0, tb_dc_prediction);
  end

endmodule
