`timescale 1ns / 1ps

module top_level
# (parameter width = 2)
(
    input clk,
    input rst_n,
    input botao1, // decrementa a velocidade em 10
    input botao2, // incrementa a velocidade em 10
    output logic [width - 1:0] LED, // leds - saída
    output logic [6:0] digito1, digito2, digito3
);

wire [7:0] veloc;
wire inc, dec;

veloc_atual_m   vel(clk, botao1, botao2, rst_n, veloc);                  // alteramos a velocidade de acordo com os botões
divisor_clock_m div(clk, rst_n, veloc, clk_veloc);                 // a velocidade retorna o clock de acordo com o BPM
triple_display_7_segments  displays(veloc, rst_n, clk, digito1, digito2, digito3); // saída dos dígitos
metronomo_m     met(clk_veloc, rst_n, LED);                        // os leds acendem de acordo com o 'clk_veloc'

endmodule : top_level