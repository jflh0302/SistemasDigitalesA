`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.10.2026 10:24:29
// Design Name: 
// Module Name: Tarea
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


module Tarea(
 
    input logic [3:0] A,
    input logic [3:0] B,
    input logic [2:0] Operation,

    output logic [3:0] Output,
    output logic Carry,
    output logic Overflow,
    output logic Zero,
    output logic Negative
);

logic [4:0] res;

always_comb begin

    Output = 4'b0000;
    Carry = 1'b0;
    Overflow = 1'b0;

    case (Operation)

        // SUMA
        3'b000: begin
            res = A + B;
            Output = res[3:0];
            Carry = res[4];

            Overflow = (~A[3] & ~B[3] & Output[3]) |
                       (A[3] & B[3] & ~Output[3]);
        end

        // RESTA
        3'b001: begin
            Output = A - B;

            Overflow = (A[3] & ~B[3] & ~Output[3]) |
                       (~A[3] & B[3] & Output[3]);
        end

        // AND
        3'b010: begin
            Output = A & B;
        end

        // OR
        3'b011: begin
            Output = A | B;
        end

        // XOR
        3'b100: begin
            Output = A ^ B;
        end

        // NOT
        3'b101: begin
            Output = ~A;
        end

        // SHIFT LEFT
        3'b110: begin
            Output = A << 1;
        end

        // SHIFT RIGHT
        3'b111: begin
            Output = A >> 1;
        end

    endcase

    // BANDERA ZERO
    if (Output == 4'b0000)
        Zero = 1'b1;
    else
        Zero = 1'b0;

    // BANDERA NEGATIVE
    Negative = Output[3];

end

endmodule
