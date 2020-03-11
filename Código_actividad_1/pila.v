//Pila generica de programa, se inicializa y no se modifica
 
 module pila #(parameter DATA = 8)
              (input  wire clk, activa,push,
               input  wire [DATA-1:0] entradaDatos,
               output wire [DATA-1:0] salidaDatos);
    reg [8:0]  direccionPila;
   initial
   begin 
     direccionPila[8:0] = 9'b000000000;
   end
   

   reg [DATA-1:0] mem[0:511]; //memoria de 1024  palabras de 8 bits de ancho
 
   
   assign salidaDatos = mem[direccionPila];

   always @(posedge activa) 
     if(push)
       begin
         direccionPila = direccionPila + 9'b000000001;
         mem[direccionPila] = entradaDatos;
       end
     else
       begin
         direccionPila = direccionPila - 9'b000000001;
       end

 endmodule
  
   
