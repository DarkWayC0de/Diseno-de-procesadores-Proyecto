`timescale 1 ns / 10 ps

module cpu_tb;


reg clk, reset;
reg [2:0] interrupciones;


// generación de reloj clk
always //siempre activo, no hay condición de activación
begin
  clk = 1'b1;
  #30;
  clk = 1'b0;
  #30;
end

reg [4:0][7:0] entradaDispositivo;
wire [4:0][7:0] salidaDispositivo;

// instanciación del procesador
cpu micpu(clk, 
          reset,
          interrupciones[2:0],
          entradaDispositivo[0][7:0],
          salidaDispositivo[0][7:0],
          entradaDispositivo[1][7:0],
          salidaDispositivo[1][7:0],
          entradaDispositivo[2][7:0],
          salidaDispositivo[2][7:0],
          entradaDispositivo[3][7:0],
          salidaDispositivo[3][7:0],
          entradaDispositivo[4][7:0],
          salidaDispositivo[4][7:0]);

wire salidaTimer;
timer mitimer(reset,
              clk,
              salidaTimer);

always @(clk) begin
  if(salidaTimer) begin
    interrupciones = 3'b001;  
  end else begin
    interrupciones = 3'b000;  
  end
end

initial
begin
  $dumpfile("cpu_tb.vcd");
  $dumpvars;
  reset = 1;  //a partir del flanco de subida del reset empieza el funcionamiento normal
  #10;
  reset = 0;  //bajamos el reset 
end

initial
begin

  #(60*900);  //Esperamos 9 ciclos o 9 instrucciones
  $finish;
end
initial
begin
interrupciones = 3'b000;
end

endmodule
