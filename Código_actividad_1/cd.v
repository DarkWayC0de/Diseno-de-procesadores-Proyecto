module cd (input wire clk, reset, s_inc, s_inm, we3, wez, selectorMuxSaltoR, guardarMemoriaDatos, activarMemoria, selecionarMuxDireccionesMemoriaDatos,
           input wire [2:0] op_alu, 
           output wire z, 
           output wire [5:0] opcode);
//Camino de datos de instrucciones de un solo ciclo

wire [9:0] entradaDatosMemoriaPrograma;
wire [15:0] salidaDatosMemoriaPrograma;

memprog memoriaPrograma(clk, 
                        entradaDatosMemoriaPrograma[9:0], 
                        salidaDatosMemoriaPrograma[15:0]);

assign opcode[5:0] = salidaDatosMemoriaPrograma[15:10];

wire habilitarEscrituraBancoRegistros;
wire [3:0] direccionSalidaRegistro1,
           direccionSalidaRegistro2,
           direccionRegistroEscritura;
wire [7:0] datoAEscribir,
           datoSalidaRegistro1,
           datoSalidaRegistro2;

regfile bancoDeRegistros(clk, 
                         habilitarEscrituraBancoRegistros, 
                         direccionSalidaRegistro1[3:0], 
                         direccionSalidaRegistro2[3:0], 
                         direccionRegistroEscritura[3:0], 
                         datoAEscribir[7:0], 
                         datoSalidaRegistro1[7:0], 
                         datoSalidaRegistro2[7:0]);

assign direccionSalidaRegistro1[3:0] = salidaDatosMemoriaPrograma[11:8];
assign direccionSalidaRegistro2[3:0] = salidaDatosMemoriaPrograma[7:4];
assign direccionRegistroEscritura[3:0] = salidaDatosMemoriaPrograma[3:0];
assign habilitarEscrituraBancoRegistros = we3;


wire [9:0] entradaPC, 
           salidaPC;

registro #(10) pc(clk, 
                  reset, 
                  entradaPC[9:0], 
                  salidaPC[9:0]);

assign entradaDatosMemoriaPrograma[9:0] = salidaPC[9:0];


wire entradaFFZ,
     cargaFFZ,
     salidadFFZ;

ffd ffz(clk,
        reset,
        entradaFFZ,
        cargaFFZ,
        salidadFFZ);

assign cargaFFZ = wez;

wire [9:0] entrada1MuxPC,
           entrada2MuxPC,
           salidaMuxPC;
wire selectorMuxPC;

mux2 #(10) muxPC(entrada1MuxPC[9:0],
                 entrada2MuxPC[9:0],
                 selectorMuxPC,
                 salidaMuxPC[9:0]);

assign entrada1MuxPC[9:0] = salidaDatosMemoriaPrograma[9:0];
assign entradaPC[9:0] = salidaMuxPC[9:0];
assign selectorMuxPC = s_inc;

wire [9:0] entrada1SumadorPC,
           entrada2SumadorPC,
           salidaSumadorPC;

sum sumadorPC(entrada1SumadorPC[9:0],
              entrada2SumadorPC[9:0],
              salidaSumadorPC[9:0]);

assign entrada2MuxPC[9:0] = salidaSumadorPC[9:0];
assign entrada2SumadorPC[9:0] = salidaPC [9:0];

wire [9:0] entrada1MuxSaltoR,
           entrada2MuxSaltoR,
           salidaMuxSaltoR;

mux2 #(10) muxSaltoRelativo(entrada1MuxSaltoR[9:0],
                            entrada2MuxSaltoR[9:0],
                            selectorMuxSaltoR,
                            salidaMuxSaltoR[9:0]);

assign entrada1SumadorPC[9:0] = salidaMuxSaltoR[9:0];
assign entrada1MuxSaltoR[9:0] = 10'b0000000001;
assign entrada2MuxSaltoR[9:0] = salidaDatosMemoriaPrograma[9:0];


wire salidaZALU;
wire [7:0] operando1ALU,
           operando2ALU,
           salidaALU;

alu unidaAritmeticoLogica(operando1ALU[7:0],
                          operando2ALU[7:0],
                          op_alu[2:0],
                          salidaALU[7:0],
                          salidaZALU);

assign operando1ALU[7:0] = datoSalidaRegistro1[7:0];
assign operando2ALU[7:0] = datoSalidaRegistro2[7:0];
assign entradaFFZ =  salidaZALU;

wire selectorMuxRegistros;
wire [7:0] entrada1MuxRegistros,
           entrada2MuxRegistros,
           salidaMuxRegistros;

mux2 #(8) muxRegistros(entrada1MuxRegistros[7:0],
                       entrada2MuxRegistros[7:0],
                       selectorMuxRegistros,
                       salidaMuxRegistros[7:0]);

assign selectorMuxRegistros = s_inm;
assign entrada1MuxRegistros[7:0] = salidaALU[7:0];
assign entrada2MuxRegistros[7:0] = salidaDatosMemoriaPrograma[11:04];
assign datoAEscribir[7:0] = salidaMuxRegistros[7:0];

wire [6:0] direccionMemoriaDatos;
wire [7:0] entradaMemoriaDatos,
           salidaMemoriaDatos;

memoriaDatos memoriaDeDatos(clk,
                            guardarMemoriaDatos,
                            activarMemoria,
                            direccionMemoriaDatos[6:0],
                            entradaMemoriaDatos[7:0],
                            salidaMemoriaDatos[7:0]);

assign datoAEscribir[7:0] = salidaMemoriaDatos[7:0];
assign entradaMemoriaDatos = datoSalidaRegistro1[7:0];


wire [6:0] entrada1MuxDireccionMemoriaDatos,
           entrada2MuxDireccionMemoriaDatos,
           salidaMuxDireccionMemoriaDatos;

mux2#(7) muxDirecionMemoriaDatos(entrada1MuxDireccionMemoriaDatos[6:0],
                                 entrada2MuxDireccionMemoriaDatos[6:0],
                                 selectorMuxDirecionMemoriaDatos,
                                 salidaMuxDireccionMemoriaDatos[6:0]);

assign entrada1MuxDireccionMemoriaDatos[6:0] = salidaDatosMemoriaPrograma[6:0];
assign entrada2MuxDireccionMemoriaDatos[6:0] = salidaDatosMemoriaPrograma[10:4];
assign direccionMemoriaDatos = salidaMuxDireccionMemoriaDatos[6:0];

endmodule
