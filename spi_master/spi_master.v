// Module SPI Master (Variant 12)
// Language: Verilog
module spi_master (
// ---- Global Signals ----
input wire clk,
input wire reset,
// ---- Control Interface ----
input wire i_start,
input wire [7:0] i_tx_byte,
output reg o_done,
output reg [7:0] o_rx_byte,
// ---- SPI Lines ----
input wire i_miso,
output reg o_mosi,
output reg o_sck,
output reg o_ss
);
// ---- Parameters ----
localparam CLK_DIV_RATIO = 25; // 50MHz / (1MHz * 2) = 25 (Приклад для SCK = 1MHz)
// ---- FSM State Parameters ----
localparam S_IDLE = 2'b00;
localparam S_START = 2'b01;
localparam S_SHIFT = 2'b10;
localparam S_STOP = 2'b11;
// ---- FSM Internal Registers ----
reg [1:0] state_reg = S_IDLE;
reg [$clog2(CLK_DIV_RATIO):0] clk_div_counter = 0;
reg [3:0] bit_counter = 0;
// ---- Internal Wires for module communication ----
reg tx_load_reg; 
reg rx_sample_trigger_reg; 
reg tx_shift_trigger_reg; 
wire w_mosi_bit; 
wire [7:0] w_rx_byte; 
// ---- 1. Instantiate Transmitter (Tx) Module ----
spi_tx u_tx (
.clk(clk),
.reset(reset),
.i_load(tx_load_reg),
.i_tx_byte(i_tx_byte),
.i_clk_spi_edge(tx_shift_trigger_reg),
.o_mosi(w_mosi_bit)
);
// ---- 2. Instantiate Receiver (Rx) Module ----
spi_rx u_rx (
.clk(clk),
.reset(reset),
.i_clk_spi_sample(rx_sample_trigger_reg),
.i_miso(i_miso),
.o_rx_byte(w_rx_byte)
);
// ---- 3. Main Logic Block (FSM) ----
always @(posedge clk or posedge reset) begin
if (reset) begin
state_reg <= S_IDLE;
o_sck <= 0;
o_ss <= 1;
o_mosi <= 0;
o_done <= 0;
bit_counter <= 0;
clk_div_counter <= 0;
o_rx_byte <= 0;
tx_load_reg <= 0;
rx_sample_trigger_reg <= 0;
tx_shift_trigger_reg <= 0;
end else begin
tx_load_reg <= 0; // Reset triggers every clock cycle (pulses)
rx_sample_trigger_reg <= 0;
tx_shift_trigger_reg <= 0;
case (state_reg)
S_IDLE: begin
o_done <= 0;
o_ss <= 1;
o_sck <= 0;
o_mosi <= 0; 
if (i_start) begin
tx_load_reg <= 1; 
bit_counter <= 8;
state_reg <= S_START;
end
end
S_START: begin
o_ss <= 0;
// FIX #1: Output Bit 7 *before* the 1st clock edge
o_mosi <= w_mosi_bit;
state_reg <= S_SHIFT;
clk_div_counter <= 0;
end
S_SHIFT: begin
if (bit_counter > 0) begin
if (clk_div_counter == CLK_DIV_RATIO - 1) begin
// --- Second SCK half-cycle (SCK 'low', CPHA=0) ---
o_sck <= 0;
tx_shift_trigger_reg <= 1; 
clk_div_counter <= 0;
bit_counter <= bit_counter - 1;
end else if (clk_div_counter == (CLK_DIV_RATIO / 2) - 1) begin
// --- First SCK half-cycle (SCK 'high', CPHA=0) ---
o_sck <= 1;
rx_sample_trigger_reg <= 1; 
clk_div_counter <= clk_div_counter + 1;
end else if (clk_div_counter == 1) begin
o_mosi <= w_mosi_bit; // Update o_mosi with the *next* bit
clk_div_counter <= clk_div_counter + 1;
end else begin
clk_div_counter <= clk_div_counter + 1;
end
end else begin
state_reg <= S_STOP;
end
end
S_STOP: begin
o_ss <= 1;
o_sck <= 0;
o_mosi <= 0; 
o_done <= 1;
o_rx_byte <= w_rx_byte; 
state_reg <= S_IDLE;
end
default: begin
state_reg <= S_IDLE;
end
endcase
end
end
endmodule