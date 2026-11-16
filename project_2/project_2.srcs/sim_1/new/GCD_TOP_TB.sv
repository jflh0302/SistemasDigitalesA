`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.11.2026 09:42:41
// Design Name: 
// Module Name: GCD_TOP_TB
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

module GCD_TOP_TB;

    // Entradas
    logic clk;
    logic clr;
    logic go;

    logic [7:0] xin;
    logic [7:0] yin;

    // Salida
    logic [7:0] gcd_out;

    // Instancia del circuito principal
    gcd_top DUT (
        .clk(clk),
        .clr(clr),
        .go(go),
        .xin(xin),
        .yin(yin),
        .gcd_out(gcd_out)
    );

    // Generador de reloj: periodo de 10 ns
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Tarea para ejecutar una prueba
    task automatic probar_mcd(
        input logic [7:0] numero_x,
        input logic [7:0] numero_y,
        input logic [7:0] resultado_esperado
    );

        integer i;
        logic terminado;

        begin
            // Reinicio del circuito
            @(negedge clk);
            clr = 1;
            go = 0;
            xin = numero_x;
            yin = numero_y;

            repeat (2) @(negedge clk);
            clr = 0;

            // Iniciar operación
            go = 1;
            @(negedge clk);
            go = 0;

            // Esperar el resultado
            terminado = 0;

            for (i = 0; i < 100; i = i + 1) begin
                @(negedge clk);

                if (gcd_out === resultado_esperado) begin
                    terminado = 1;
                    i = 100;
                end
            end

            // Comprobar resultado
            if (terminado) begin
                $display("--------------------------------");
                $display("PRUEBA CORRECTA");
                $display("X = %0d", numero_x);
                $display("Y = %0d", numero_y);
                $display("MCD = %0d", gcd_out);
                $display("--------------------------------");
            end
            else begin
                $display("--------------------------------");
                $display("ERROR EN LA PRUEBA");
                $display("X = %0d", numero_x);
                $display("Y = %0d", numero_y);
                $display("Esperado = %0d", resultado_esperado);
                $display("Obtenido = %0d", gcd_out);
                $display("--------------------------------");
                $fatal(1, "Fallo en el calculo del MCD");
            end
        end

    endtask

    // Secuencia de pruebas
    initial begin

        clr = 0;
        go = 0;
        xin = 0;
        yin = 0;

        // Prueba 1: MCD(48,18) = 6
        probar_mcd(8'd48, 8'd18, 8'd6);

        // Prueba 2: MCD(21,14) = 7
        probar_mcd(8'd21, 8'd14, 8'd7);

        // Prueba 3: MCD(36,24) = 12
        probar_mcd(8'd36, 8'd24, 8'd12);

        // Prueba 4: MCD(15,5) = 5
        probar_mcd(8'd15, 8'd5, 8'd5);

        $display("TODAS LAS PRUEBAS FINALIZARON CORRECTAMENTE");

        $finish;
    end

endmodule

