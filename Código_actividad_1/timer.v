module timer(input wire reset,
             input wire activer,
             input wire clock,
	     input wire [2:0] selector,
             output wire salida);

reg [9:0] counter;
reg [13:0] datselector;
reg active;

always@(clock) begin
  if (reset) begin
   counter <= 0;
   active <= 0;
  end else begin
    if (activer) begin   
      if ( counter == datselector) begin
        counter <= 0;
        active <= 1;
      end else begin
        counter<= counter + 1;	
	    active <= 0;
	  end
	end
  end
end
always@(selector) begin
  case (selector)
    3'b000: begin
	  datselector <= 127; //al 64 ciclo
	end
	3'b001:begin
	  datselector <= 255; //al 128 ciclo
	end
	3'b010: begin
	  datselector <= 511; // 256
	end
	3'b011:begin
	  datselector <= 1023; // 512 
	end
	3'b100: begin
	  datselector <= 2047; // 1024
	end
	3'b101:begin
	  datselector <= 4095; // 2048
	end
	3'b110: begin
	  datselector <= 8191; // 4096
	end
	3'b111:begin
	  datselector <= 16383; // 8192
	end
  endcase
end

assign salida = active;



endmodule
