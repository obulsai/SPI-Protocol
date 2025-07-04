`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/11/2025 10:02:38 PM
// Design Name: 
// Module Name: spi_slave
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
module spi_slave(
    input wire mosi,
    input wire sclk,
    input wire chip_select,
    input wire [7:0] fixed_data,
    output wire [7:0] data_out,
    output reg done,
    output reg miso
);

reg [7:0] data = 0;
reg [7:0] shift_out = 0;
reg [3:0] bit_count = 0;

always @(posedge chip_select) begin
    // Reset slave when deselected
    data <= 0;
    bit_count <= 0;
    done <= 0;
    miso <= 0;
end

// In spi_slave.v
always @(negedge sclk) begin
    if (!chip_select) begin
        if (bit_count == 0)
            shift_out <= fixed_data;

        miso <= shift_out[7 - bit_count]; // Set MISO early
        data <= {data[6:0], mosi};        // Sample MOSI

        bit_count <= bit_count + 1;

        if (bit_count == 7)
            done <= 1;
    end
end

assign data_out = data;

endmodule
