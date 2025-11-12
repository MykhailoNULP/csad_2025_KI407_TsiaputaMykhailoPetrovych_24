// SPI Receiver (Rx) Module
module spi_rx (
input wire clk,
input wire reset,
input wire i_clk_spi_sample, 
input wire i_miso,
output wire [7:0] o_rx_byte
);
reg [7:0] rx_shift_reg = 0;
always @(posedge clk or posedge reset) begin
if (reset) begin
rx_shift_reg <= 0;
end else begin
if (i_clk_spi_sample) begin
rx_shift_reg <= {rx_shift_reg[6:0], i_miso};
end
end
end
assign o_rx_byte = rx_shift_reg;
endmodule