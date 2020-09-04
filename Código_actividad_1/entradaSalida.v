module entradaSalida(input wire clk,
                     input wire reset,
                     input wire [7:0] inreg1,
                     input wire [7:0] inreg2,
                     input wire writeRgDir,
                     output wire [15:0] dir,
                     output wire [7:0] entradaDispositivoExt,
                     input wire [7:0] salidaDispositivoExt,
                     input wire [7:0]  salidaDispositivoInt,
                     output wire [7:0] entradaDispositivoInt,
                     input activarEntradaSalida,
                     input escribirEntradaSalida
                     );


reg [15:0] rdir;

initial begin
 rdir[15:0] =16'b00; 
end

always @(posedge clk)begin
  if (writeRgDir) begin
   rdir[7:0]  <= inreg1;
   rdir[15:8] <= inreg2;
  end 
end

assign dir = rdir;

assign entradaDispositivoExt = (activarEntradaSalida &&  escribirEntradaSalida)? salidaDispositivoInt : 8'bZ;
assign entradaDispositivoInt = (activarEntradaSalida && !escribirEntradaSalida)? salidaDispositivoExt : 8'bZ;




/*							
reg [63:0] regSalidaDispositivos00;

//always @(reset)
//if (reset)
//begin
//  regSalidaDispositivos00[63:0]=64'b00;
//end

initial
begin
  regSalidaDispositivos00[63:0]=64'b00;
end					 
reg [7:0] datoALeer;

assign salidaEntradaSalida[7:0] = datoALeer[7:0];

assign salidaDispositivo1[7:0] = regSalidaDispositivos00[7:0];
assign salidaDispositivo2[7:0] = regSalidaDispositivos00[15:8];
assign salidaDispositivo3[7:0] = regSalidaDispositivos00[23:16];
assign salidaDispositivo4[7:0] = regSalidaDispositivos00[31:24];
assign salidaDispositivo5[7:0] = regSalidaDispositivos00[39:32];

always @(clk) begin
if (activarEntradaSalida && !reset) begin  
  if (!escribirEntradaSalida) begin  
    case (direccionEntradaSalida)
      6'b000000: begin
        datoALeer[7:0] = entradaDispositivo1[7:0];
      end
      6'b000001: begin
        datoALeer[7:0] = entradaDispositivo2[7:0];
      end
      6'b000010: begin
        datoALeer[7:0] = entradaDispositivo3[7:0];
      end
      6'b000011: begin
        datoALeer[7:0] = entradaDispositivo4[7:0];
      end
      6'b000100: begin
        datoALeer[7:0] = entradaDispositivo5[7:0];
      end
      default:
        datoALeer[7:0] = entradaDispositivo1[7:0];
    endcase 
  end  else begin
	regSalidaDispositivos00[7:0] = (!direccionEntradaSalida[0] && !direccionEntradaSalida[1] && !direccionEntradaSalida[2])? entradaEntradaSalida[7:0]: regSalidaDispositivos00[7:0];
	regSalidaDispositivos00[15:8] = ( direccionEntradaSalida[0] && !direccionEntradaSalida[1] && !direccionEntradaSalida[2])? entradaEntradaSalida[7:0]: regSalidaDispositivos00[15:8];
	regSalidaDispositivos00[23:16] = (!direccionEntradaSalida[0] &&  direccionEntradaSalida[1] && !direccionEntradaSalida[2])? entradaEntradaSalida[7:0]: regSalidaDispositivos00[23:14];
	regSalidaDispositivos00[31:24] = ( direccionEntradaSalida[0] &&  direccionEntradaSalida[1] && !direccionEntradaSalida[2])? entradaEntradaSalida[7:0]: regSalidaDispositivos00[31:24];
	regSalidaDispositivos00[39:32] = (!direccionEntradaSalida[0] && !direccionEntradaSalida[1] &&  direccionEntradaSalida[2])? entradaEntradaSalida[7:0]: regSalidaDispositivos00[39:32];
  end
end
  
end */
endmodule
