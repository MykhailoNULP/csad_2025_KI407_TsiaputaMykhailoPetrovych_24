// Testbench for spi_master (Step 3)
`timescale 1ns / 1ps // Set time units for simulation
module spi_master_tb;

// ---- Test Parameters ----
localparam CLK_PERIOD = 20; // Clock period (20 ns = 50 MHz)

// ---- Signals to connect to the UUT (Unit Under Test) ----
// 'reg' for inputs we generate
reg clk_tb;
reg reset_tb;
reg i_start_tb;
reg [7:0] i_tx_byte_tb;

// 'wire' for outputs we read
wire o_done_tb;
wire [7:0] o_rx_byte_tb;
wire o_mosi_tb;
wire o_sck_tb;
wire o_ss_tb;

// ---- 1. Instantiate the Unit Under Test (UUT) ----
// We only need to instantiate the top-level 'spi_master'
spi_master uut (
    .clk(clk_tb),
    .reset(reset_tb),
    .i_start(i_start_tb),
    .i_tx_byte(i_tx_byte_tb),
    .o_done(o_done_tb),
    .o_rx_byte(o_rx_byte_tb),
    
    // ---- Loopback: Connect MOSI output directly to MISO input ----
    .i_miso(o_mosi_tb),
    .o_mosi(o_mosi_tb),
    .o_sck(o_sck_tb),
    .o_ss(o_ss_tb)
);

// ---- 2. Clock Generation ----
initial begin
    clk_tb = 0;
end

always begin
    # (CLK_PERIOD / 2) clk_tb = ~clk_tb; // Invert clock every 10 ns
end

// ---- 3. Test Sequence ----
initial begin
    $display("Starting SPI Master Testbench (Loopback Mode)...");
    
    // Set initial values
    reset_tb <= 1; // Start in reset state
    i_start_tb <= 0;
    i_tx_byte_tb <= 8'h00;

    // Hold reset for 5 cycles
    # (CLK_PERIOD * 5);

    // De-assert reset. Module should go to S_IDLE
    reset_tb <= 0;
    
    // Wait 10 cycles
    # (CLK_PERIOD * 10);

    // --- TEST 1: Send byte 0xA5 ---
    $display("TEST 1: Sending 0xA5...");
    i_start_tb <= 1;    // Press "Start"
    i_tx_byte_tb <= 8'hA5; // 0b10100101
    
    # CLK_PERIOD;       // Hold "Start" for one cycle
    i_start_tb <= 0;
    
    // Wait for the module to signal it's done (o_done_tb == 1)
    wait (o_done_tb == 1);
    
    $display("TEST 1: Done flag received. Sent: 0xA5, Received: %h",
             o_rx_byte_tb);

    // Wait 20 cycles before next test
    # (CLK_PERIOD * 20);

    // --- TEST 2: Send byte 0xF0 ---
    $display("TEST 2: Sending 0xF0...");
    i_start_tb <= 1;    // Press "Start"
    i_tx_byte_tb <= 8'hF0; // 0b11110000
    
    # CLK_PERIOD;       // Hold "Start" for one cycle
    i_start_tb <= 0;
    
    // Wait for the module to signal it's done
    wait (o_done_tb == 1);
    
    $display("TEST 2: Done flag received. Sent: 0xF0, Received: %h",
             o_rx_byte_tb);
             
    # (CLK_PERIOD * 20);

    // ---- Finish Simulation ----
    $display("Simulation Finished.");
    $stop;
end
endmodule