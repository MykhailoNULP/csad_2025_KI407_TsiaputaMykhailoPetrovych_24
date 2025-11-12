`timescale 1ns/1ps
module tb_spi_master;
    parameter WIDTH = 8;

    reg clk = 0;
    reg rst = 1;
    reg start = 0;
    reg [WIDTH-1:0] tx_data = 0;
    wire [WIDTH-1:0] rx_data;
    wire rx_valid;
    wire busy;
    wire sclk;
    wire cs_n;
    wire mosi;
    reg miso = 0;

    // Instantiate DUT
    spi_master #(.WIDTH(WIDTH)) dut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .tx_data(tx_data),
        .rx_data(rx_data),
        .rx_valid(rx_valid),
        .mosi(mosi),
        .sclk(sclk),
        .cs_n(cs_n),
        .miso(miso)
    );

    // Clock generation: 100 MHz
    always #5 clk = ~clk;

    initial begin
        $display("Starting SPI master testbench");

        // Reset pulse
        rst = 1;
        #20;
        rst = 0;

        // Test vector: send 0xA5
        tx_data = 8'hA5;
        #10;
        start = 1;
        #10;
        start = 0;

        // Drive MISO with a pattern (0x3C) during transfer
        fork
        begin
            wait(cs_n == 0);
            #7;
            miso = 0; #10;
            miso = 0; #10;
            miso = 1; #10;
            miso = 1; #10;
            miso = 1; #10;
            miso = 1; #10;
            miso = 0; #10;
            miso = 0; #10;
        end
        join

        // Wait for reception
        wait(rx_valid == 1);
        $display("Received data: 0x%0h", rx_data);

        #100;
        $display("Testbench finished");
        $finish;
    end

    // VCD dump for waveform viewing
    initial begin
        $dumpfile("tb_spi_master.vcd");
        $dumpvars(0, tb_spi_master);
    end
endmodule

