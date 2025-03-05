`timescale 1ns / 1ps

module pwm(
    input clk,
    input rst,
    input [3:0] sw,
    output reg pwm
    );
    
    reg [7:0] counter = 8'b0; // Contador de 8 bits
    reg [7:0] duty_cycle; // Ciclo de trabajo calculado (0-255)

// Proceso para controlar el contador y generar el PWM
always @(posedge clk or posedge rst) begin
    if (rst) begin
        counter <= 8'b0; // Resetear el contador
    end else begin
        if (counter == 8'd255) begin // Reiniciar el contador al alcanzar el máximo
            counter <= 8'b0;
        end else begin
            counter <= counter + 1;
        end
    end
end

// Calcular el ciclo de trabajo basado en los interruptores (SW)
always @(sw) begin
    duty_cycle <= sw * 16; // Convierte los 4 bits de SW a un valor de ciclo de trabajo proporcional (0-255)
end

// Generación de la señal PWM
always @(*) begin
    if (counter < duty_cycle)
    pwm <= 1'b1;
else
    pwm <= 1'b0;
end
    
endmodule
