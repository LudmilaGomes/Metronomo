`timescale 1ns / 1ps

/*

Assim estão definidas as funções dos botões:

b_decrem - botão que decrementa a velocidade em 10
b_increm - botão que incrementa a velocidade em 10

*/

module veloc_atual_m
(
	input clk, 
	input b_decrem, 
	input b_increm, 
	input rst_n,   
	output logic [7:0] veloc      // a saída é a velocidade utilizada no módulo metronomo_m
);

logic clk_1HZ;

divisor_clock_m div(clk, rst_n, 60, clk_1HZ);

always_ff @(posedge clk_1HZ or negedge rst_n)
begin
	if(!rst_n)
		veloc = 6'b111100;    // velocidade definida por padrão é de 60 BPMs
	else if(b_decrem && !b_increm && veloc >= 5'b11110)
		veloc = veloc - 4'b1010;	// decrementa a velocidade em 10
	else if(b_increm && !b_decrem && veloc <= 8'b11011100)
		veloc = veloc + 4'b1010;	// incrementa a velocidade em 10
end

endmodule : veloc_atual_m