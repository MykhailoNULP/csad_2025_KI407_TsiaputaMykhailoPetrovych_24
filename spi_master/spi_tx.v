// SPI Transmitter (Tx) Module
module spi_tx (
input wire clk,
input wire reset,
input wire i_load, 
input wire i_clk_spi_edge, 
input wire [7:0] i_tx_byte, 
output wire o_mosi
);
reg [7:0] tx_shift_reg = 0;
always @(posedge clk or posedge reset) begin
if (reset) begin
tx_shift_reg <= 0;
end else begin
if (i_load) begin
tx_shift_reg <= i_tx_byte;
end else if (i_clk_spi_edge) begin
tx_shift_reg <= tx_shift_reg << 1;
end
end
end
assign o_mosi = tx_shift_reg[7];
endmodule