module timer(input wire reset,
             input wire clock,
			 input wire [2:0] selector,
             output wire salida);

reg [9:0] counter;
reg [9:0] datselector;
reg active;

always@(clock) begin
  if (reset) begin
   counter <= 0;
   active <= 0;
  end else begin
    if ( counter == datselector) begin
      counter <= 0;
      active <= 1;
    end else begin
      counter<= counter + 1;	
      active <= 0;
    end
  end
end
always@(selector) begin
  case (selector)
    3'b000: begin
	  datselector <= 7; //al 4 ciclo
	end
	3'b001:begin
	  datselector <= 15; //al 8 ciclo
	end
	3'b010: begin
	  datselector <= 31; // ...
	end
	3'b011:begin
	  datselector <= 63;
	end
	3'b100: begin
	  datselector <= 127;
	end
	3'b101:begin
	  datselector <= 255;
	end
	3'b110: begin
	  datselector <= 511;
	end
	3'b111:begin
	  datselector <= 1023; // 512
	end
  endcase
end

assign salida = active;



endmodule
