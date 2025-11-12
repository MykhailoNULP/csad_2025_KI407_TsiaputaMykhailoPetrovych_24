// ============================================================
// Module: SPI Master Transmitter (spi_tx)
// Description: Handles MOSI output data and SCLK generation
// ============================================================
module spi_tx #(parameter WIDTH = 8)(
    input  wire        clk,      // System clock
    input  wire        rst,      // Reset signal
    input  wire        start,    // Start transmission
    input  wire [WIDTH-1:0] tx_data, // Data to transmit
    output reg         sclk,     // SPI clock output
    output reg         mosi,     // Master-Out-Slave-In
    output reg         cs_n,     // Chip Select (active low)
    output reg         busy,     // Transmission in progress
    output reg         done      // Transmission finished
);

    reg [WIDTH-1:0] shift_reg;
    reg [3:0] bit_cnt;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            sclk <= 0; cs_n <= 1; mosi <= 0;
            busy <= 0; done <= 0; bit_cnt <= 0;
        end else begin
            if (start && !busy) begin
                busy <= 1; cs_n <= 0;
                shift_reg <= tx_data;
                bit_cnt <= WIDTH - 1;
                done <= 0;
            end else if (busy) begin
                sclk <= ~sclk;
                if (sclk) begin
                    mosi <= shift_reg[bit_cnt];
                    if (bit_cnt == 0) begin
                        busy <= 0;
                        cs_n <= 1;
                        done <= 1;
                    end else
                        bit_cnt <= bit_cnt - 1;
                end
            end
        end
    end
endmodule

