//Pila subRutina

module pilaSubRutina(input  wire clk, activa, push,
                     input  wire [9:0] entradaDirecciones,
                     output wire [9:0] entradaDirecciones);
  
  
  pila #(10) pilaSub(clk, activa, push, entradaDatos, salidaDatos);
  
  
endmodule
