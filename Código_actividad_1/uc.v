module uc(input wire [5:0] opcode, 
          input wire z,clk, 
          output reg we3,
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
                      selectorMuxAluMem_E_S, 
          output reg [2:0] op_alu);
always @ (opcode,z,clk)
casex(opcode)
  6'b0xxxxx: begin // s = a
     we3 = 1'b1;
     wez = 1'b1;
     s_inc = 1'b1;
     selectorMuxSaltoR = 1'b0;
     selectorMuxRegistros = 1'b0;
     guardarMemoriaDatos = 1'b0;
     activarMemoriaDatos = 1'b0;
     selectorMuxDireccionesMemoriaDatos = 1'b0;
     activarPilaSubR = 1'b0;
     pushPilaSubR = 1'b0;
     selectorMuxPilaSubR = 1'b0;
     activarPilaDatos = 1'b0;
     pushPilaDatos = 1'b0;
     selectorMuxPilaDatos = 1'b0;
     selectorMuxAluMem_E_S = 1'b0;
     op_alu[2:0] = opcode[4:2];
  end
  6'b1000xx: begin //Carga Inmediato
     we3 = 1'b1;
     wez = 1'b0;
     s_inc = 1'b1;
     selectorMuxSaltoR = 1'b0;
     selectorMuxRegistros = 1'b1;
     guardarMemoriaDatos = 1'b0;
     activarMemoriaDatos = 1'b0;
     selectorMuxDireccionesMemoriaDatos = 1'b0;
     activarPilaSubR = 1'b0;
     pushPilaSubR = 1'b0;
     selectorMuxPilaSubR = 1'b0;
     activarPilaDatos = 1'b0;
     pushPilaDatos = 1'b0;
     selectorMuxPilaDatos = 1'b0;
     selectorMuxAluMem_E_S = 1'b0;
     op_alu[2:0] = opcode[4:2]; 
  end
  6'b1001xx: begin //push dato
     we3 = 1'b0;
     wez = 1'b0;
     s_inc = 1'b1;
     selectorMuxSaltoR = 1'b0;
     selectorMuxRegistros = 1'b0;
     guardarMemoriaDatos = 1'b0;
     activarMemoriaDatos = 1'b0;
     selectorMuxDireccionesMemoriaDatos = 1'b0;
     activarPilaSubR = 1'b0;
     pushPilaSubR = 1'b0;
     selectorMuxPilaSubR = 1'b0;
     activarPilaDatos = 1'b1;
     pushPilaDatos = 1'b1;
     selectorMuxPilaDatos = 1'b1;
     selectorMuxAluMem_E_S = 1'b0;
     op_alu[2:0] = opcode[4:2];
  end
  6'b1010xx: begin //pop dato
     we3 = 1'b1;
     wez = 1'b0;
     s_inc = 1'b1;
     selectorMuxSaltoR = 1'b0;
     selectorMuxRegistros = 1'b0;
     guardarMemoriaDatos = 1'b0;
     activarMemoriaDatos = 1'b0;
     selectorMuxDireccionesMemoriaDatos = 1'b0;
     activarPilaSubR = 1'b0;
     pushPilaSubR = 1'b0;
     selectorMuxPilaSubR = 1'b0;
     activarPilaDatos = 1'b1;
     pushPilaDatos = 1'b0;
     selectorMuxPilaDatos = 1'b1;
     selectorMuxAluMem_E_S = 1'b0;
     op_alu[2:0] = opcode[4:2];
  end
  6'b1011xx: begin //cargar dato desde memoria
     we3 = 1'b1;
     wez = 1'b0;
     s_inc = 1'b1;
     selectorMuxSaltoR = 1'b0;
     selectorMuxRegistros = 1'b0;
     guardarMemoriaDatos = 1'b0;
     activarMemoriaDatos = 1'b1;
     selectorMuxDireccionesMemoriaDatos = 1'b1;
     activarPilaSubR = 1'b0;
     pushPilaSubR = 1'b0;
     selectorMuxPilaSubR = 1'b0;
     activarPilaDatos = 1'b0;
     pushPilaDatos = 1'b0;
     selectorMuxPilaDatos = 1'b0;
     selectorMuxAluMem_E_S = 1'b1;
     op_alu[2:0] = opcode[4:2];
  end
  6'b1100xx: begin //guardar memoria de datos
     we3 = 1'b0;
     wez = 1'b0;
     s_inc = 1'b1;
     selectorMuxSaltoR = 1'b0;
     selectorMuxRegistros = 1'b0;
     guardarMemoriaDatos = 1'b1;
     activarMemoriaDatos = 1'b1;
     selectorMuxDireccionesMemoriaDatos = 1'b0;
     activarPilaSubR = 1'b0;
     pushPilaSubR = 1'b0;
     selectorMuxPilaSubR = 1'b0;
     activarPilaDatos = 1'b0;
     pushPilaDatos = 1'b0;
     selectorMuxPilaDatos = 1'b0;
     selectorMuxAluMem_E_S = 1'b1;
     op_alu[2:0] = opcode[4:2];
  end
  6'b1101xx: begin //LIBRE
  end
  6'b111000: begin //libre

  end
  6'b111001: begin //Libre

  end
  6'b111010: begin //return
     we3 = 1'b0;
     wez = 1'b0;
     s_inc = 1'b0;
     selectorMuxSaltoR = 1'b1;
     selectorMuxRegistros = 1'b0;
     guardarMemoriaDatos = 1'b0;
     activarMemoriaDatos = 1'b0;
     selectorMuxDireccionesMemoriaDatos = 1'b0;
     activarPilaSubR = 1'b1;
     pushPilaSubR = 1'b0;
     selectorMuxPilaSubR = 1'b1;
     activarPilaDatos = 1'b0;
     pushPilaDatos = 1'b0;
     selectorMuxPilaDatos = 1'b0;
     selectorMuxAluMem_E_S = 1'b0;
     op_alu[2:0] = opcode[4:2];
  end
  6'b111011: begin //call 
     we3 = 1'b0;
     wez = 1'b0;
     s_inc = 1'b0;
     selectorMuxSaltoR = 1'b0;
     selectorMuxRegistros = 1'b0;
     guardarMemoriaDatos = 1'b0;
     activarMemoriaDatos = 1'b0;
     selectorMuxDireccionesMemoriaDatos = 1'b0;
     activarPilaSubR = 1'b1;
     pushPilaSubR = 1'b1;
     selectorMuxPilaSubR = 1'b0;
     activarPilaDatos = 1'b0;
     pushPilaDatos = 1'b0;
     selectorMuxPilaDatos = 1'b0;
     selectorMuxAluMem_E_S = 1'b0;
     op_alu[2:0] = opcode[4:2];
  end
  6'b111100: begin //J
     we3 = 1'b0;
     wez = 1'b0;
     s_inc = 1'b0;
     selectorMuxSaltoR = 1'b0;
     selectorMuxRegistros = 1'b0;
     guardarMemoriaDatos = 1'b0;
     activarMemoriaDatos = 1'b0;
     selectorMuxDireccionesMemoriaDatos = 1'b0;
     activarPilaSubR = 1'b0;
     pushPilaSubR = 1'b0;
     selectorMuxPilaSubR = 1'b0;
     activarPilaDatos = 1'b0;
     pushPilaDatos = 1'b0;
     selectorMuxPilaDatos = 1'b0;
     selectorMuxAluMem_E_S = 1'b0;
     op_alu[2:0] = opcode[4:2];
  end
  6'b111101: begin //JZ
    if (z==0) begin
       s_inc = 1'b0;
    end
    else begin
       s_inc =1'b1;
    end      
     we3 = 1'b0;
     wez = 1'b0;
     selectorMuxSaltoR = 1'b0;
     selectorMuxRegistros = 1'b0;
     guardarMemoriaDatos = 1'b0;
     activarMemoriaDatos = 1'b0;
     selectorMuxDireccionesMemoriaDatos = 1'b0;
     activarPilaSubR = 1'b0;
     pushPilaSubR = 1'b0;
     selectorMuxPilaSubR = 1'b0;
     activarPilaDatos = 1'b0;
     pushPilaDatos = 1'b0;
     selectorMuxPilaDatos = 1'b0;
     selectorMuxAluMem_E_S = 1'b0;
     op_alu[2:0] = opcode[4:2];
  end
  6'b111110: begin //JNZ
    if (z == 1) begin
       s_inc = 1'b0;
    end
    else begin
       s_inc =1'b1;
    end      
     we3 = 1'b0;
     wez = 1'b0;
     selectorMuxSaltoR = 1'b0;
     selectorMuxRegistros = 1'b0;
     guardarMemoriaDatos = 1'b0;
     activarMemoriaDatos = 1'b0;
     selectorMuxDireccionesMemoriaDatos = 1'b0;
     activarPilaSubR = 1'b0;
     pushPilaSubR = 1'b0;
     selectorMuxPilaSubR = 1'b0;
     activarPilaDatos = 1'b0;
     pushPilaDatos = 1'b0;
     selectorMuxPilaDatos = 1'b0;
     selectorMuxAluMem_E_S = 1'b0;
     op_alu[2:0] = opcode[4:2];
  end
  6'b111111: begin //JR
     we3 = 1'b0;
     wez = 1'b0;
     s_inc = 1'b1;
     selectorMuxSaltoR = 1'b1;
     selectorMuxRegistros = 1'b0;
     guardarMemoriaDatos = 1'b0;
     activarMemoriaDatos = 1'b0;
     selectorMuxDireccionesMemoriaDatos = 1'b0;
     activarPilaSubR = 1'b0;
     pushPilaSubR = 1'b0;
     selectorMuxPilaSubR = 1'b0;
     activarPilaDatos = 1'b0;
     pushPilaDatos = 1'b0;
     selectorMuxPilaDatos = 1'b0;
     selectorMuxAluMem_E_S = 1'b0;
     op_alu[2:0] = opcode[4:2];
  end
endcase
endmodule
