`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.10.2026 10:30:34
// Design Name: 
// Module Name: Tarea_tb
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



module Tarea_tb;

    // Entradas
    logic [3:0] A;
    logic [3:0] B;
    logic [2:0] Operation;

    // Salidas
    logic [3:0] Output;
    logic Carry;
    logic Overflow;
    logic Zero;
    logic Negative;

    // Conectar nuestra ALU
    Tarea prueba (
        .A(A),
        .B(B),
        .Operation(Operation),
        .Output(Output),
        .Carry(Carry),
        .Overflow(Overflow),
        .Zero(Zero),
        .Negative(Negative)
    );

    initial begin

        // Valores iniciales
        A = 4'b0101;
        B = 4'b0011;

        // SUMA
        Operation = 3'b000;
        #10;

        // RESTA
        Operation = 3'b001;
        #10;

        // AND
        Operation = 3'b010;
        #10;

        // OR
        Operation = 3'b011;
        #10;

        // XOR
        Operation = 3'b100;
        #10;

        // NOT
        Operation = 3'b101;
        #10;

        // SHIFT LEFT
        Operation = 3'b110;
        #10;

        // SHIFT RIGHT
        Operation = 3'b111;
        #10;

        // Terminar simulación
        #10;
        $finish;

    end

endmodule
