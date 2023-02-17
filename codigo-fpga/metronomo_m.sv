/*

metronomo:

display exibindo valor BPM;
2 leds piscando alternadamente de acordo com o BPM;
divisor de clock;
debounce;
velocidade_atualizada;

clock de 50MHz
velocidade padrão de 60 bpm

*/

module metronomo_m 
# (parameter width = 2)
(
    input clk, rst_n,
    output logic [width - 1:0] leds
);

logic [width - 1:0] cont;

always_ff @ (posedge clk or negedge rst_n)
begin
    if(~rst_n)
    begin
       cont <= {{(width - 1){1'b0}}, 1'b1};
    end
    else
    begin
		cont = {cont[width - 2:0],cont[width - 1]};
    end
end

assign leds = cont;

endmodule : metronomo_m

/*

Explicações de código:

Escrevemos de maneira genérica, tal que funcione para WIDTH com valor qualquer:

    linha 29:
    cont <= {{(width - 1){1'b0}}, 1'b1};
    
    cont = [0, 1]

===============//===============//===============//===============

Escrevemos de maneira genérica, tal que funcione para WIDTH com valor qualquer:

    linha 35:
    cont = {cont[width - 2:0],cont[width - 1]};

    alternando o valor de 1 nas posições do array, exemplo: 
    [0,0,0,0,1] -> [0,0,0,1,0] -> [0,0,1,0,0] -> [0,1,0,0,0] -> [1,0,0,0,0] -> [0,0,0,0,1] -> ...
    cont = [0, 1]
    cont = [cont[0] = 1, cont[1] = 0]
    cont = [1, 0]
    cont = [cont[0] = 0, cont[1] = 1]
    cont = [0, 1]

*/