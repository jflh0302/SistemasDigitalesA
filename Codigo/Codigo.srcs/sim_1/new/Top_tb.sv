`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.10.2026 10:07:20
// Design Name: 
// Module Name: Top_tb
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


`timescale 1ns/1ps

module Top_tb;

    // Señales del testbench
    logic clk;
    logic reset;
    logic data_in;

    logic detect_mealy;
    logic detect_moore;


    // Instancia del módulo TOP
    Top DUT (
        .clk(clk),
        .reset(reset),
        .data_in(data_in),
        .detect_mealy(detect_mealy),
        .detect_moore(detect_moore)
    );


    // Generación del reloj
    initial begin
        clk = 1'b0;

        forever #5 clk = ~clk;
    end


    
    initial begin

        // Inicio
        reset   = 1'b1;
        data_in = 1'b0;

        // Mantener reset
        #12;

        // Liberar reset
        reset = 1'b0;

        // Secuencia: 0110011001100110

        data_in = 0'b1; #10;
        data_in = 1'b1; #10;
        data_in = 1'b0; #10;
        data_in = 0'b0; #10;
        data_in = 0'b1; #10;
        data_in = 1'b1; #10;
        data_in = 1'b0; #10;
        data_in = 0'b0; #10;
        data_in = 0'b1; #10;
        data_in = 1'b1; #10;
        data_in = 1'b0; #10;
        data_in = 0'b0; #10;
        data_in = 0'b1; #10;
        data_in = 1'b1; #10;
        data_in = 1'b0; #10;
        data_in = 0'b0; #10;

        #10;

        $finish;

    end


    // Mostrar resultados en consola
   
endmodule