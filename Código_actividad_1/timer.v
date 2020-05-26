module timer(input wire reset,
             input wire clock,
             output wire salida);

reg [7:0] counter;
reg active;

always@(clock)
begin
  if (reset) begin
   counter <= 0;
   active <= 0;
  end else begin
    if ( counter == 255) begin
      counter <= 0;
      active <= 1;
    end else begin
      counter<= counter + 1;	
      active <= 0;
    end
  end
end

assign salida = active;



endmodule
