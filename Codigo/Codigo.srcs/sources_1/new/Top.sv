`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.10.2026 10:02:41
// Design Name: 
// Module Name: Top
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


module Top(
    input  logic clk,
    input  logic reset,
    input  logic data_in,

    output logic detect_mealy,
    output logic detect_moore
);

    maqmealy U1 (
        .clk(clk),
        .reset(reset),
        .data_in(data_in),
        .detect(detect_mealy)
    );

    maqmoore U2 (
        .clk(clk),
        .reset(reset),
        .data_in(data_in),
        .detect(detect_moore)
    );

endmodule
