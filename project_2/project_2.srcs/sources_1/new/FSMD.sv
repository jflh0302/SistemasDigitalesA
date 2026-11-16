`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.11.2026 09:25:08
// Design Name: 
// Module Name: FSMD
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



`timescale 1ns / 1ps

//====================================================
// 1. COMPARATOR
//====================================================
module comparator
    #(parameter N = 8)
    (
        input  logic [N-1:0] x, y,
        output logic eqflg, ltflg
    );

    always_comb begin
        eqflg = 1'b0;
        ltflg = 1'b0;

        if (x < y)
            ltflg = 1'b1;
        else if (x == y)
            eqflg = 1'b1;
    end

endmodule


//====================================================
// 2. CONTROL UNIT
//====================================================
module control_unit(
    input  logic clk, clr, go, eqflg, ltflg,
    output logic xsel, ysel, gld, yld, xld
);

    typedef enum {
        start, _input, test1, done, test2, y_x, x_y
    } state_type;

    state_type state_reg, state_next;

    always_ff @(posedge clk or posedge clr) begin
        if (clr)
            state_reg <= start;
        else
            state_reg <= state_next;
    end

    always_comb begin
        state_next = state_reg;

        xsel = 1'b0;
        ysel = 1'b0;
        xld  = 1'b0;
        yld  = 1'b0;
        gld  = 1'b0;

        case (state_reg)

            start:
                if (~go)
                    state_next = start;
                else
                    state_next = _input;

            _input: begin
                xsel = 1'b1;
                ysel = 1'b1;
                xld = 1'b1;
                yld = 1'b1;
                state_next = test1;
            end

            test1:
                if (~eqflg)
                    state_next = test2;
                else
                    state_next = done;

            test2:
                if (~ltflg)
                    state_next = x_y;
                else
                    state_next = y_x;

            y_x: begin
                yld = 1'b1;
                ysel = 1'b0;
                state_next = test1;
            end

            x_y: begin
                xld = 1'b1;
                xsel = 1'b0;
                state_next = test1;
            end

            done: begin
                gld = 1'b1;
                state_next = done;
            end

            default:
                state_next = start;

        endcase
    end

endmodule


//====================================================
// 3. MULTIPLEXER
//====================================================
module multiplexer(
    input  logic [7:0] in_0, in_1,
    input  logic sel,
    output logic [7:0] mux_out
);

    always_comb begin
        if (~sel)
            mux_out = in_0;
        else
            mux_out = in_1;
    end

endmodule


//====================================================
// 4. REGISTER
//====================================================
module register(
    input  logic clk, clr, ld,
    input  logic [7:0] d,
    output logic [7:0] q
);

    always_ff @(posedge clk or posedge clr) begin
        if (clr)
            q <= 8'b0;
        else if (ld)
            q <= d;
    end

endmodule


//====================================================
// 5. SUBTRACTOR
//====================================================
module subtractor
    #(parameter N = 8)
    (
        input  logic [N-1:0] a, b,
        output logic [N-1:0] r
    );

    always_comb begin
        r = a - b;
    end

endmodule


//====================================================
// 6. MAIN MODULE: GCD TOP
//====================================================
module gcd_top(
    input  logic clk,
    input  logic clr,
    input  logic go,

    input  logic [7:0] xin,
    input  logic [7:0] yin,

    output logic [7:0] gcd_out
);

    // Internal signals
    logic xsel, ysel;
    logic xld, yld, gld;

    logic eqflg, ltflg;

    logic [7:0] x, y;
    logic [7:0] xr, yr;

    logic [7:0] x1, y1;

    // Control unit
    control_unit CU(
        .clk(clk),
        .clr(clr),
        .go(go),
        .eqflg(eqflg),
        .ltflg(ltflg),
        .xsel(xsel),
        .ysel(ysel),
        .gld(gld),
        .yld(yld),
        .xld(xld)
    );

    // X multiplexer
    multiplexer XMUX(
        .in_0(xr),
        .in_1(xin),
        .sel(xsel),
        .mux_out(x1)
    );

    // Y multiplexer
    multiplexer YMUX(
        .in_0(yr),
        .in_1(yin),
        .sel(ysel),
        .mux_out(y1)
    );

    // X register
    register XREG(
        .clk(clk),
        .clr(clr),
        .ld(xld),
        .d(x1),
        .q(x)
    );

    // Y register
    register YREG(
        .clk(clk),
        .clr(clr),
        .ld(yld),
        .d(y1),
        .q(y)
    );

    // X subtractor: X - Y
    subtractor XSUBTRACTOR(
        .a(x),
        .b(y),
        .r(xr)
    );

    // Y subtractor: Y - X
    subtractor YSUBTRACTOR(
        .a(y),
        .b(x),
        .r(yr)
    );

    // Comparator
    comparator COMPARE(
        .x(x),
        .y(y),
        .eqflg(eqflg),
        .ltflg(ltflg)
    );

    // GCD result register
    register GREG(
        .clk(clk),
        .clr(clr),
        .ld(gld),
        .d(x),
        .q(gcd_out)
    );

endmodule

