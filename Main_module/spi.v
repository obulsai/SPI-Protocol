`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/11/2025 10:32:35 PM
// Design Name: 
// Module Name: spi
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
module spi (
    input clk,
    input reset,
    input tx_enable,
    output done,
    output [7:0] data_out,
    output [7:0] rx_data,
    output sclk,
    output chip_select,
    output mosi,
    output miso
);

spi_master spi_m (
    .clk(clk), .reset(reset), .tx_enable(tx_enable),
    .miso(miso), .mosi(mosi), .sclk(sclk),
    .chip_select(chip_select), .rx_data(rx_data)
);

spi_slave spi_s (
    .sclk(sclk), .chip_select(chip_select), .mosi(mosi),
    .done(done), .data_out(data_out), .fixed_data(8'hA5),
    .miso(miso)
);

endmodule