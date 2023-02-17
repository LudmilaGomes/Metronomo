`timescale 1ns/1ns

/*

Testaremos a saída, ou seja, testaremos o array 'leds' para ver 
se eles obedecem à lógica do código. De acordo com a lógica, os
leds devem acender e apagar de forma alternada:

leds = [0, 1]
leds = [1, 0]
leds = [0, 1]
leds = [1, 0]
leds = [0, 1]
leds = [1, 0]

*/

module metronomo_tb();

parameter WIDTH = 2;
logic clk_tb;
logic rst_tb;
wire [WIDTH-1:0] leds_out;
logic [WIDTH-1:0] exp_out; // comparamos 'leds-out' com esse array
logic [31:0] index;

metronomo #(WIDTH) met (.clk    (clk_tb),
                        .rst_n  (rst_tb),
                        .leds   (leds_out)
);

// gerando clock
always #10 clk_tb = ~clk_tb;

initial 
begin
    clk_tb = 0;
    rst_tb = 0;
    exp_out = {{(WIDTH-1){1'b0}},1'b1}; // 'exp_out' obedece à lógica usada no código
    #100 rst_tb = 1;
    #500;
    $finish;
end

// a ideia é comparar 'leds_out' com 'leds_out'. Se eles forem diferentes, então há erro

always @ (posedge clk_tb or negedge rst_tb)
begin
    if(~rst_tb)
    begin
        index = 32'd0;
        exp_out = {{(WIDTH-1){1'b0}},1'b1};

        if(leds_out != exp_out)
        begin
            $display("[ERRO] %0t ns - valor de 'leds' observado no reset NÃO eh %b", $time, exp_out);
        end
        else 
        begin
            $display("[INFO] %0t ns - valor de 'leds' observado no reset eh %b", $time, exp_out);
        end
    end
    else 
    begin
        if (index == WIDTH-1)
        begin
            index = 0;
        end
        else 
        begin
            index = index + 1;
        end

        exp_out = {{(WIDTH-1){1'b0}},1'b1} << index;
        #1;
        
        if(leds_out != exp_out)
        begin
            $display("[ERRO] %0t ns -> leds = %b exp = %b", $time, leds_out, exp_out);
        end
        else 
        begin
            $display("[INFO] %0t ns -> leds = %b", $time, leds_out);
        end
    end
end

endmodule