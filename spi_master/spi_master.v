// ============================================================
// Module: SPI Master Top-Level
// Description: Connects TX and RX modules, generates logic
// ============================================================
module spi_master #(parameter WIDTH = 8)(
    input  wire        clk,
    input  wire        rst,
    input  wire        start,
    input  wire [WIDTH-1:0] tx_data,
    input  wire        miso,
    output wire        mosi,
    output wire        sclk,
    output wire        cs_n,
    output wire [WIDTH-1:0] rx_data,
    output wire        rx_valid
);

    wire busy, done;

    spi_tx #(.WIDTH(WIDTH)) u_tx (
        .clk(clk),
        .rst(rst),
        .start(start),
        .tx_data(tx_data),
        .sclk(sclk),
        .mosi(mosi),
        .cs_n(cs_n),
        .busy(busy),
        .done(done)
    );

    spi_rx #(.WIDTH(WIDTH)) u_rx (
        .clk(clk),
        .rst(rst),
        .sclk(sclk),
        .cs_n(cs_n),
        .miso(miso),
        .rx_data(rx_data),
        .rx_valid(rx_valid)
    );

endmodule

