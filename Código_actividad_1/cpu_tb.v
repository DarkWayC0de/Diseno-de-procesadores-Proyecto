`timescale 1 ns / 10 ps

module cpu_tb;


reg clk, reset;
reg [7:0]a;
reg [2:0] interrupciones;


// generación de reloj clk
always //siempre activo, no hay condición de activación
begin
  clk = 1'b1;
  #30;
  clk = 1'b0;
  #30;
  a = a + 8'b01;
end

always @(a)
if(a ==8'b0101)
begin
a = 8'b00;
interrupciones = 3'b001;
end
else
begin
interrupciones = 3'b000;
end
reg [4:0][7:0] entradaDispositivo;
wire [4:0][7:0] salidaDispositivo;

// instanciación del procesador
cpu micpu(clk, 
          reset,
          interrupciones,
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

initial
begin
  $dumpfile("cpu_tb.vcd");
  $dumpvars;
  reset = 1;  //a partir del flanco de subida del reset empieza el funcionamiento normal
  #10;
  reset = 0;  //bajamos el reset 
  a = 0;
end

initial
begin

  #(60*60);  //Esperamos 9 ciclos o 9 instrucciones
  $finish;
end
initial
begin
interrupciones = 3'b000;
end

endmodule
