// ============================================================
// Module: SPI Master Receiver (spi_rx)
// Description: Receives data from MISO line
// ============================================================
module spi_rx #(parameter WIDTH = 8)(
    input  wire clk,      // System clock
    input  wire rst,      // Reset
    input  wire sclk,     // SPI clock
    input  wire cs_n,     // Chip Select
    input  wire miso,     // Master-In-Slave-Out
    output reg [WIDTH-1:0] rx_data, // Received data
    output reg rx_valid                 // Valid flag
);
    reg [3:0] bit_cnt;
    reg [WIDTH-1:0] shift_reg;

    always @(posedge sclk or posedge rst) begin
        if (rst) begin
            rx_data <= 0;
            rx_valid <= 0;
            bit_cnt <= 0;
        end else if (!cs_n) begin
            shift_reg <= {shift_reg[WIDTH-2:0], miso};
            bit_cnt <= bit_cnt + 1;
            if (bit_cnt == WIDTH-1) begin
                rx_data <= {shift_reg[WIDTH-2:0], miso};
                rx_valid <= 1;
                bit_cnt <= 0;
            end
        end else begin
            rx_valid <= 0;
        end
    end
endmodule

