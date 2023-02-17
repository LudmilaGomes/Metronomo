`timescale 1ns/1ns

module metronomo
# (parameter width = 2)
(
    input clk, rst_n,
    output logic [width - 1:0] leds
);

logic [width - 1:0] cont;

always @ (posedge clk or negedge rst_n) 
begin
    if(~rst_n)
    begin
        cont <= {{(width - 1){1'b0}}, 1'b1}; 
    end
    else
        cont = {cont[width - 2:0],cont[width - 1]};
end

assign leds = cont;

endmodule : metronomo