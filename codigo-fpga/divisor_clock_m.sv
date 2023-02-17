`timescale 1ns/1ns

/*

contador dentro de um always_ff;

usamos esse módulo para um clock de entrada de
50 MHz (CLK_FPGA); variando esse clock de entrada,
basta alterar o parameter CLK_FPGA.

o contador irá contar até o valor de clk_velocidade;
quando cont == clk_velocidade, teremos o tempo em
segundos que está de acordo com o BPS (batidas por
segundos), este obtido a partir da velocidade em
BPMs (input velocidade).

*/

module divisor_clock_m 
# (parameter CLK_FPGA = 49999999)
(
    input clk, rst_n,
    input logic [7:0] velocidade,
    output clk_hz
);

logic [31:0] cont;
logic [31:0] clk_velocidade;
assign clk_velocidade = 49999999 / (velocidade/60);
    
always_ff @(posedge clk or negedge rst_n)
begin

    if(~rst_n)
    begin
        cont = 32'd0;
        clk_hz = 1'b0;
    end
    else if(cont < clk_velocidade)
    begin
        cont = cont + 1'b1;
        clk_hz = 1'b0;
    end
    else if(cont == clk_velocidade)
    begin
        cont = 32'd0;
        clk_hz = 1'b1;
    end

end

endmodule : divisor_clock_m