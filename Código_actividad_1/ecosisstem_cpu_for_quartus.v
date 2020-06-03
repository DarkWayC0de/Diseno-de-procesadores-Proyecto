module ecosistem_cpu(input wire clk, reset, 
			  input [1:0] interrupciones,
           input wire [7:0] entradaDispositivo1,
           output wire [7:0] salidaDispositivo1,
           input wire [7:0] entradaDispositivo2,
           output wire [7:0] salidaDispositivo2,
           input wire [7:0] entradaDispositivo3,
           output wire [7:0] salidaDispositivo3,
           input wire [7:0] entradaDispositivo4,
           output wire [7:0] salidaDispositivo4,
           input wire [7:0] entradaDispositivo5,
           output wire [7:0] salidaDispositivo5);
wire salidaTimer;			  

// instanciación del procesador
cpu micpu(clk, 
          reset,
          {interrupciones[1:0],salidaTimer},
          entradaDispositivo1[7:0],
          salidaDispositivo1[7:0],
          entradaDispositivo2[7:0],
          salidaDispositivo2[7:0],
          entradaDispositivo3[7:0],
          salidaDispositivo3[7:0],
          entradaDispositivo4[7:0],
          salidaDispositivo4[7:0],
          entradaDispositivo5[7:0],
          salidaDispositivo5[7:0]);


timer mitimer(reset || !salidaDispositivo1[3],
              clk,
			     salidaDispositivo1[2:0],
              salidaTimer);				  
	
endmodule