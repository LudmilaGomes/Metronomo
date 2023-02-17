`timescale 1ns/1ns

module triple_display_7_segments(value, rst, clk, disp7_dig1, disp7_dig2, disp7_dig3);
	input rst, clk;
	input [8:0] value;
	output [6:0] disp7_dig1, disp7_dig2, disp7_dig3;
	
	logic [8:0] aux_buffer;

	always_ff @(posedge clk)
		begin
			if(value >= 7'b1100100 && value < 8'b11001000) begin
				disp7_dig1 = 7'b1111001;
				aux_buffer = value - 7'b1100100;
			end else if(value >= 8'b11001000) begin
				disp7_dig1 = 7'b0100100;
				aux_buffer = value - 8'b11001000;
			end else begin
				disp7_dig1 = 7'b1000000;
				aux_buffer = value;
			end
			
			if(aux_buffer >= 4'b1010 && aux_buffer < 5'b10100) begin
				disp7_dig2 = 7'b1111001;
				aux_buffer = aux_buffer - 4'b1010;
			end else if(aux_buffer >= 5'b10100 && aux_buffer < 5'b11110) begin
				disp7_dig2 = 7'b0100100;
				aux_buffer = aux_buffer - 5'b10100;
			end else if(aux_buffer >= 5'b11110 && aux_buffer < 6'b101000) begin
				disp7_dig2 = 7'b0110000;
				aux_buffer = aux_buffer - 5'b11110;
			end else if(aux_buffer >= 6'b101000 && aux_buffer < 6'b110010) begin
				disp7_dig2 = 7'b0011001;
				aux_buffer = aux_buffer - 6'b101000;
			end else if(aux_buffer >= 6'b110010 && aux_buffer < 6'b111100) begin
				disp7_dig2 = 7'b0010010;
				aux_buffer = aux_buffer - 6'b110010;
			end else if(aux_buffer >= 6'b111100 && aux_buffer < 7'b1000110) begin
				disp7_dig2 = 7'b0000010;
				aux_buffer = aux_buffer - 6'b111100;
			end else if(aux_buffer >= 7'd1000110 && aux_buffer < 7'b1010000) begin
				disp7_dig2 = 7'b1111000;
				aux_buffer = aux_buffer - 7'd1000110;
			end else if(aux_buffer >= 7'b1010000 && aux_buffer < 7'b1011010) begin
				disp7_dig2 = 7'b0000000;
				aux_buffer = aux_buffer - 7'b1010000;
			end else if(aux_buffer >= 7'b1011010) begin	
				disp7_dig2 = 7'b0010000;
				aux_buffer = aux_buffer - 7'b1011010;
			end else begin
				disp7_dig2 = 7'b1000000;
			end
			
			case (aux_buffer)
				4'd0: disp7_dig3 = 7'b1000000;
				4'd1: disp7_dig3 = 7'b1111001;
				4'd2: disp7_dig3 = 7'b0100100;
				4'd3: disp7_dig3 = 7'b0110000;
				4'd4: disp7_dig3 = 7'b0011001;
				4'd5: disp7_dig3 = 7'b0010010;
				4'd6: disp7_dig3 = 7'b0000010;
				4'd7: disp7_dig3 = 7'b1111000;
				4'd8: disp7_dig3 = 7'b0000000;
				4'd9: disp7_dig3 = 7'b0010000;
			endcase
		end
endmodule : triple_display_7_segments