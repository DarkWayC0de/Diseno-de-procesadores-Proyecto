module cd (input wire clk, 
                      reset,
                      we3,
                      wez,
                      s_inc,
                      selectorMuxSaltoR,
                      selectorMuxRegistros,
                      guardarMemoriaDatos,
                      activarMemoriaDatos,
                      selectorMuxDireccionesMemoriaDatos,
                      activarPilaSubR,
                      pushPilaSubR,
                      selectorMuxPilaSubR,
                      activarPilaDatos,
                      pushPilaDatos,
                      selectorMuxPilaDatos,
                      selectorMuxAluMem, 
           input wire [2:0] op_alu,
           input wire [2:0] interrupciones, 
           output wire z, 
           output wire [5:0] opcode,
           output wire rd, wr,
           output wire [15:0] dir,
           input wire [7:0] entradaDispositivo,
           output wire [7:0] salidaDispositivo
           );
//Camino de datos de instrucciones de un solo ciclo

wire [9:0] entradaDatosMemoriaPrograma;
reg [15:0] instruccion;
wire [15:0] salidaDatosMemoriaPrograma;

parameter ins = 16'b1110111111111111; 

memprog memoriaPrograma(clk, 
                        entradaDatosMemoriaPrograma[9:0], 
                        salidaDatosMemoriaPrograma[15:0]);
always @(interrupciones,reset,salidaDatosMemoriaPrograma)
begin
  if(reset)
    begin
    instruccion[15:0] <= 16'b00;
    end
  else
  begin
  if(interrupciones == 3'b000) 
    begin
      instruccion[15:0] <= salidaDatosMemoriaPrograma[15:0];
    end
  else
    begin
      case(interrupciones)
        3'b001: begin
          instruccion[15:0] <= ins;
        end
        3'b010: begin
          instruccion[15:0] <= ins -16'b1;
        end
        3'b011: begin
          instruccion[15:0] <= ins -16'b10;
        end
        3'b100: begin
          instruccion[15:0] <= ins -16'b11;
        end
        3'b101: begin
          instruccion[15:0] <= ins -16'b100;
        end
        3'b110: begin
          instruccion[15:0] <= ins -16'b101;
        end
        3'b111: begin
          instruccion[15:0] <= ins -16'b110;
        end
      endcase      
    end
    end
end

assign opcode[5:0] = instruccion[15:10];

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

assign direccionSalidaRegistro1[3:0] = instruccion[11:8];
assign direccionSalidaRegistro2[3:0] = instruccion[7:4];
assign direccionRegistroEscritura[3:0] = instruccion[3:0];
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
assign z = salidadFFZ;

wire [9:0] entrada1MuxPC,
           entrada2MuxPC,
           salidaMuxPC;
wire selectorMuxPC;

mux2 #(10) muxPC(entrada1MuxPC[9:0],
                 entrada2MuxPC[9:0],
                 selectorMuxPC,
                 salidaMuxPC[9:0]);

assign entrada1MuxPC[9:0] = instruccion[9:0];
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
assign entrada2MuxSaltoR[9:0] = instruccion[9:0];


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

wire [7:0] entrada1MuxRegistros,
           entrada2MuxRegistros,
           salidaMuxRegistros;

mux2 #(8) muxRegistros(entrada1MuxRegistros[7:0],
                       entrada2MuxRegistros[7:0],
                       selectorMuxRegistros,
                       salidaMuxRegistros[7:0]);

assign entrada2MuxRegistros[7:0] = instruccion[11:04];


wire [6:0] direccionMemoriaDatos;
wire [7:0] entradaMemoriaDatos,
           salidaMemoriaDatos;
wire activarMemoria;

memoriaDatos memoriaDeDatos(clk,
                            guardarMemoriaDatos,
                            activarMemoria,
                            direccionMemoriaDatos[6:0],
                            entradaMemoriaDatos[7:0],
                            salidaMemoriaDatos[7:0]);

assign entradaMemoriaDatos = datoSalidaRegistro1[7:0];


wire [7:0] entrada1MuxDireccionMemoriaDatos,
           entrada2MuxDireccionMemoriaDatos,
           salidaMuxDireccionMemoriaDatos;

mux2#(8) muxDirecionMemoriaDatos(entrada1MuxDireccionMemoriaDatos[7:0],
                                 entrada2MuxDireccionMemoriaDatos[7:0],
                                 selectorMuxDireccionesMemoriaDatos,            
                                 salidaMuxDireccionMemoriaDatos[7:0]);

assign entrada1MuxDireccionMemoriaDatos[7:0] = instruccion[7:0];
assign entrada2MuxDireccionMemoriaDatos[7:0] = instruccion[11:4];
assign direccionMemoriaDatos = salidaMuxDireccionMemoriaDatos[6:0];
assign activarMemoria = activarMemoriaDatos && !salidaMuxDireccionMemoriaDatos[7:7];

wire [7:0] datosSalidaEntradaSalida;
wire activarEntradaSalida;
assign activarEntradaSalida = activarMemoriaDatos && salidaMuxDireccionMemoriaDatos[7:7];

/*entradaSalida dispositivosEntradaSalida(clk,
                                        reset,
                                        rd, 
                                        wr,
                                        dir[15:0],
                                        entradaDispositivo[7:0],
                                        salidaDispositivo[7:0]
                                        );
                                        entradaDispositivo1 [7:0],
                                        salidaDispositivo1 [7:0],
                                        entradaDispositivo2 [7:0],
                                        salidaDispositivo2 [7:0],
                                        entradaDispositivo3 [7:0],
                                        salidaDispositivo3 [7:0],
                                        entradaDispositivo4 [7:0],
                                        salidaDispositivo4 [7:0],
                                        entradaDispositivo5 [7:0],
                                        salidaDispositivo5 [7:0],
                                        datoSalidaRegistro1[7:0], 
                                        salidaMuxDireccionMemoriaDatos [6:0],
                                        datosSalidaEntradaSalida [7:0],
                                        activarEntradaSalida,
                                        guardarMemoriaDatos
                                        );  */

wire [9:0] entradaPilaSubRutinas,
           salidaPilaSubRutinas;

pila #(10) pilaSubRutinas(clk, 
                         activarPilaSubR, 
                         pushPilaSubR,
                         entradaPilaSubRutinas[9:0], 
                         salidaPilaSubRutinas[9:0]);


assign entradaPilaSubRutinas[9:0] = salidaSumadorPC[9:0];

wire [9:0] entrada1MuxPilaSubRutinas,
           entrada2MuxPilaSubRutinas,
           salidaMuxPilaSubRutinas;

mux2#(10) muxPilaSubrutinas(entrada1MuxPilaSubRutinas[9:0],
                            entrada2MuxPilaSubRutinas[9:0],
                            selectorMuxPilaSubR,
                            salidaMuxPilaSubRutinas[9:0]);

assign entrada1MuxPilaSubRutinas[9:0] = salidaMuxPC[9:0];
assign entrada2MuxPilaSubRutinas[9:0] = salidaPilaSubRutinas[9:0];
assign entradaPC[9:0] = salidaMuxPilaSubRutinas[9:0];


wire [9:0]  entradaPilaDatos,
             salidaPilaDatos;

pila #(8) pilaDatos(clk,
                    activarPilaDatos,
                    pushPilaDatos,
                    entradaPilaDatos[7:0],
                    salidaPilaDatos[7:0]);

assign entradaPilaDatos[7:0] =  datoSalidaRegistro1[7:0];

wire [7:0] entrada1MuxPilaDatos,
           entrada2MuxPilaDatos,
           salidaMuxPilaDatos;

mux2#(8) muxPilaDatos(entrada1MuxPilaDatos[7:0],
                      entrada2MuxPilaDatos[7:0],
                      selectorMuxPilaDatos,
                      salidaMuxPilaDatos[7:0]);

assign entrada1MuxPilaDatos [7:0] = salidaMuxRegistros[7:0];
assign entrada2MuxPilaDatos [7:0] = salidaPilaDatos[7:0];
assign datoAEscribir[7:0] = salidaMuxPilaDatos[7:0];      
 
wire selectorMuxMem_E_S;
wire [7:0] entrada1MuxMem_E_S,
           entrada2MuxMem_E_S,
           salidaMuxMem_E_S;

mux2#(8) muxMem_E_S(entrada1MuxMem_E_S[7:0],
                    entrada2MuxMem_E_S[7:0],
                    selectorMuxMem_E_S,
                    salidaMuxMem_E_S[7:0]);

assign entrada1MuxMem_E_S[7:0] = salidaMemoriaDatos[7:0];
//assign entrada2MuxMem_E_S[7:0] = //Salida_E_S[7:0];
assign entrada2MuxMem_E_S[7:0] = datosSalidaEntradaSalida[7:0];
assign selectorMuxMem_E_S = salidaMuxDireccionMemoriaDatos[7:7];

wire [7:0] entrada1MuxALU_Mem,
           entrada2MuxALU_Mem,
           salidaMuxALU_Mem;

mux2#(8) muxALU_Mem(entrada1MuxALU_Mem[7:0],
                    entrada2MuxALU_Mem[7:0],
                    selectorMuxAluMem,
                    salidaMuxALU_Mem[7:0]);

assign entrada1MuxRegistros[7:0] = salidaMuxALU_Mem[7:0];
assign entrada1MuxALU_Mem[7:0] = salidaALU[7:0];
assign entrada2MuxALU_Mem[7:0] = salidaMuxMem_E_S[7:0];

endmodule 
