`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/20/2025 09:54:18 PM
// Design Name: 
// Module Name: tb_planar_prediction
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

module tb_planar_prediction;

  // Clock and reset
  logic clk;
  logic rst;

  // DUT signals
  logic [7:0] data_in;
  logic [4:0] x, y;
  logic [7:0] Predict_planar;

  // Instantiate DUT
  planar_prediction dut (
    .clk(clk),
    .rst(rst),
    .data_in(data_in),
    .x(x),
    .y(y),
    .Predict_planar(Predict_planar)
  );

  // Clock generation (10ns period)
  initial clk = 1'b0;
  always #5 clk = ~clk;

  // VCD for waveform viewing
  initial begin
    $dumpfile("planar_prediction_tb.vcd");
    $dumpvars(0, tb_planar_prediction);
  end

   integer i;
   integer j;


  // Test stimulus
  initial begin
    // Initialize signals
    rst     = 1;
    data_in = 0;
    x       = 0;
    y       = 0;

    // Hold reset for a few cycles
    repeat (3) @(posedge clk);
    rst = 0;

    // Fill Our Sample Array First 
    for ( i=0; i< 10 ; i=i+1) begin
     for (j=0; j<10; j=j +1) begin
     #5 data_in=$random;
     #1 x=i;
     #1 y=j;
     end
    
    end
    
    #100
    // ---------------------------------------------------
    // Finish simulation
    // ---------------------------------------------------
    $display("\nSimulation complete at %0t", $time);
    $finish;
  end

endmodule
