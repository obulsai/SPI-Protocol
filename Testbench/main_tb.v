`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/11/2025 10:06:42 PM
// Design Name: 
// Module Name: main_tb
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
module main_tb;

    reg clk = 0;
    reg rst = 0;
    reg tx_enable = 0;
    wire mosi, chip_select, sclk, done, miso;
    wire [7:0] data_out;
    wire [7:0] rx_data;

    always #5 clk = ~clk;

    initial begin
        rst = 1;
        repeat(5) @(posedge clk);
        rst = 0;
    end

    initial begin
        tx_enable = 0;
        repeat(5) @(posedge clk);
        tx_enable = 1;
    end

     spi dut (
        .clk(clk), .reset(rst), .tx_enable(tx_enable),
        .mosi(mosi), .chip_select(chip_select),
        .sclk(sclk), .done(done), .data_out(data_out),
        .rx_data(rx_data), .miso(miso)
    );
    
    initial begin
    $monitor("Time=%0t | MOSI=%b | MISO=%b | RX=%h | OUT=%h | DONE=%b", $time, mosi, miso, rx_data, data_out, done);
end


endmodule