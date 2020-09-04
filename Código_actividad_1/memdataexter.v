module memdata(input wire clk,
               input wire cs,
               input wire we,
               input wire oe,
               input wire [11:0] dir,
               input wire [7:0] indata,
               output wire [7:0] outdata
               );

reg  [7:0] mem[0:(12*1024)-1]; //memoria de 12K palablas de 8 bits de ancho

always @(posedge clk)
  if (cs && we) mem[dir] <= indata;

assign  outdata = (cs ? (oe ? mem[dir]: 8'bZ):8'bZ);

endmodule
