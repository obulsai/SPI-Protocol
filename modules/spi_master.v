`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/11/2025 10:01:33 PM
// Design Name: 
// Module Name: spi_master
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
module spi_master(
    input wire clk,
    input wire reset,
    input wire tx_enable,
    input wire miso,
    output reg mosi,
    output reg sclk,
    output reg chip_select,
    output reg [7:0] rx_data  // received from slave
);

// FSM states
parameter idle = 2'b00, tx_start = 2'b01, tx_data = 2'b10, tx_end = 2'b11;

reg [1:0] state, next_state;
reg [2:0] count = 0;
reg [3:0] bit_count = 0;
reg [7:0] send_data = 8'd181;

// state update
always @(posedge clk) begin
    if (reset)
        state <= idle;
    else
        state <= next_state;
end

// count and bit_count
always @(posedge clk) begin
    case (state)
        idle: begin
            count <= 0;
            bit_count <= 0;
        end

        tx_start: begin
            count <= count + 1;
            bit_count <= 0;
        end

        tx_data: begin
            if (bit_count < 8) begin
                if (count == 7) begin
                    bit_count <= bit_count + 1;
                    count <= 0;
                end else
                    count <= count + 1;
            end
        end

        tx_end: begin
            bit_count <= 0;
            count <= count + 1;
        end
    endcase
end

// generate sclk
always @(posedge clk) begin
    case (next_state)
        idle: sclk <= 0;
        tx_start, tx_data: sclk <= (count < 3 || count == 7) ? 1 : 0;
        tx_end: sclk <= (count < 3) ? 1 : 0;
    endcase
end

// FSM transitions and output logic
always @(*) begin
    case (state)
        idle: begin
            chip_select <= 1;
            mosi <= 0;
            next_state <= tx_enable ? tx_start : idle;
        end

        tx_start: begin
            mosi <= 0;
            chip_select <= 0;
            next_state <= (count == 7) ? tx_data : tx_start;
        end

        tx_data: begin
            mosi <= send_data[7 - bit_count];
            if (bit_count < 8)
                next_state <= tx_data;
            else begin
                next_state <= tx_end;
                mosi <= 0;
            end
        end

        tx_end: begin
            mosi <= 0;
            chip_select <= 1;
            next_state <= (count == 7) ? idle : tx_end;
        end
    endcase
end

// sample miso (receive data)
always @(posedge clk) begin
    if (state == tx_data && count == 3) begin
        rx_data <= {rx_data[6:0], miso};  // MSB first
    end
end

endmodule