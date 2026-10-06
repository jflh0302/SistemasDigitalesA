`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.10.2026 10:00:19
// Design Name: 
// Module Name: maqmoore
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


module maqmoore(
    input  logic clk,
    input  logic reset,
    input  logic data_in,
    output logic detect
);

    typedef enum logic [3:0] {
        S0 = 4'd0,
        S1 = 4'd1,
        S2 = 4'd2,
        S3 = 4'd3,
        S4 = 4'd4,
        S5 = 4'd5,
        S6 = 4'd6,
        S7 = 4'd7,
        S8 = 4'd8
    } state_actual;

    state_actual state, next_state;

    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end

    always_comb begin

        next_state = S0;

        case (state)

            S0: begin
                if (data_in == 1'b0)
                    next_state = S1;
                else
                    next_state = S0;
            end

            S1: begin
                if (data_in == 1'b1)
                    next_state = S2;
                else
                    next_state = S1;
            end

            S2: begin
                if (data_in == 1'b1)
                    next_state = S3;
                else
                    next_state = S1;
            end

            S3: begin
                if (data_in == 1'b0)
                    next_state = S4;
                else
                    next_state = S0;
            end

            S4: begin
                if (data_in == 1'b0)
                    next_state = S5;
                else
                    next_state = S2;
            end

            S5: begin
                if (data_in == 1'b1)
                    next_state = S6;
                else
                    next_state = S1;
            end

            S6: begin
                if (data_in == 1'b1)
                    next_state = S7;
                else
                    next_state = S1;
            end

            S7: begin
                if (data_in == 1'b0)
                    next_state = S8;
                else
                    next_state = S0;
            end

            S8: begin
                if (data_in == 1'b0)
                    next_state = S5;
                else
                    next_state = S0;
            end

            default: begin
                next_state = S0;
            end

        endcase

    end

    assign detect = (state == S8);

endmodule
