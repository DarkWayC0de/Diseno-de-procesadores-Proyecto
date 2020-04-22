module entradaSalida(input wire clk,
                     input wire reset,
                     input wire [7:0] entradaDispositivo1,
                     output wire [7:0] salidaDispositivo1,
                     input wire [7:0] entradaDispositivo2,
                     output wire [7:0] salidaDispositivo2,
                     input wire [7:0] entradaDispositivo3,
                     output wire [7:0] salidaDispositivo3,
                     input wire [7:0] entradaDispositivo4,
                     output wire [7:0] salidaDispositivo4,
                     input wire [7:0] entradaDispositivo5,
                     output wire [7:0] salidaDispositivo5,
                     input wire [7:0] entradaEntradaSalida,
                     input wire [6:0] direccionEntradaSalida,
                     output wire [7:0] salidaEntradaSalida,
                     input activarEntradaSalida,
                     input escribirEntradaSalida
                     );
reg [7:0] regSalidaDispositivos0;
reg [7:0] regSalidaDispositivos1;
reg [7:0] regSalidaDispositivos2;
reg [7:0] regSalidaDispositivos3;
reg [7:0] regSalidaDispositivos4;
reg [7:0] datoALeer;

always @(reset)
if (reset)
begin
  regSalidaDispositivos0[7:0]=8'b00;
  regSalidaDispositivos1[7:0]=8'b00;
  regSalidaDispositivos2[7:0]=8'b00;
  regSalidaDispositivos3[7:0]=8'b00;
  regSalidaDispositivos4[7:0]=8'b00;
end

initial
begin
  regSalidaDispositivos0[7:0]=8'b00;
  regSalidaDispositivos1[7:0]=8'b00;
  regSalidaDispositivos2[7:0]=8'b00;
  regSalidaDispositivos3[7:0]=8'b00;
  regSalidaDispositivos4[7:0]=8'b00;
end

assign salidaEntradaSalida[7:0] = datoALeer[7:0];

assign salidaDispositivo1[7:0] = regSalidaDispositivos0[7:0];
assign salidaDispositivo2[7:0] = regSalidaDispositivos1[7:0];
assign salidaDispositivo3[7:0] = regSalidaDispositivos2[7:0];
assign salidaDispositivo4[7:0] = regSalidaDispositivos3[7:0];
assign salidaDispositivo5[7:0] = regSalidaDispositivos4[7:0];

always @(clk)
if (activarEntradaSalida && !reset)
begin  
  if (escribirEntradaSalida)
  begin
    case (direccionEntradaSalida)
      6'b000000: begin
        regSalidaDispositivos0[7:0] = entradaEntradaSalida[7:0];
      end
      6'b000001: begin
        regSalidaDispositivos1[7:0] = entradaEntradaSalida[7:0];
      end
      6'b000010: begin
        regSalidaDispositivos2[7:0] = entradaEntradaSalida[7:0];
      end
      6'b000011: begin
        regSalidaDispositivos3[7:0] = entradaEntradaSalida[7:0];
      end
      6'b000100: begin
        regSalidaDispositivos4[7:0] = entradaEntradaSalida[7:0];
      end
    endcase
  end
  else begin   
    case (direccionEntradaSalida)
      6'b000000: begin
        datoALeer[7:0] = salidaDispositivo1[7:0];
      end
      6'b000001: begin
        datoALeer[7:0] = salidaDispositivo2[7:0];
      end
      6'b000010: begin
        datoALeer[7:0] = salidaDispositivo3[7:0];
      end
      6'b000011: begin
        datoALeer[7:0] = salidaDispositivo4[7:0];
      end
      6'b000100: begin
        datoALeer[7:0] = salidaDispositivo5[7:0];
      end
      default:
        datoALeer[7:0] = salidaDispositivo1[7:0];
    endcase 
  end
end
endmodule
