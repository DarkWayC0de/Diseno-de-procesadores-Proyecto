`timescale 1 ns / 10 ps

module cpu_tb;


reg clk, reset;
reg [2:0] interrupciones;


// generación de reloj clk
always //siempre activo, no hay condición de activación
begin
  clk = 1'b1;
  #30;
  clk = 1'b0;
  #30;
end

//wire salidaTimer;
wire [7:0] entradaDispositivo;
wire [7:0] salidaDispositivo;
wire [15:0] dir;

// instanciación del procesador
cpu micpu(clk, 
          reset,
          interrupciones[2:0],
          rd, wr,
          dir[15:0],
          entradaDispositivo[7:0],
          salidaDispositivo[7:0]);

wire 	rst_syscom,
	clk_syscom,
	ack_wishbone,
	we_wishbone,
	stb_wishbone,
	cyc_wishbone;

wire [7:0] 	data_wishbone_master_i;
wire [7:0] 	data_wishbone_master_o;
wire [15:0]	dir_wishbone;

syscon mysyscon(clk,
		reset, 
		clk_syscom,
		rst_syscom);

whisbone_master master_cpu(	rst_syscom,
				clk_syscom,
				ack_wishbone,
				data_wishbone_master_i[7:0],
				data_wishbone_master_o[7:0],
				dir_wishbone[15:0],
				we_wishbone,
				stb_wishbone,
				cyc_wishbone,
				rd,
				wr,
				dir[15:0],
				salidaDispositivo[7:0],
				entradaDispositivo[7:0]);

wire	mem_cs,	mem_we,	mem_oe;
wire [11:0] mem_dir;
wire [7:0] mem_indata;
wire [7:0] mem_outdata;

whishbone_slave memslav(rst_syscom,
			clk_syscom,
			dir_wishbone[11:0],
			we_wishbone,
			stb_wishbone,
			cyc_wishbone,
			data_wishbone_master_o[7:0],
			data_wishbone_master_i[7:0],
			ack_wishbone,
			mem_cs,
			mem_we,
			mem_oe,
			mem_dir[11:0],
			mem_indata[7:0],
			mem_outdata[7:0]);


memdata memextern(	clk,
			mem_cs,
			mem_we,
			mem_oe,
			mem_dir[11:0],
			mem_indata[7:0],
			mem_outdata[7:0]);

/*reg [2:0] timerselctor;
reg activetimer;
timer mitimer(reset,
	      activetimer,
              clk,
	      timerselctor,
              salidaTimer); */

initial
begin
  $dumpfile("cpu_tb.vcd");
  $dumpvars;
  reset = 1;  //a partir del flanco de subida del reset empieza el funcionamiento normal
  #10;
  reset = 0;  //bajamos el reset 
end

initial
begin
  #(60*900);  //Esperamos 9 ciclos o 9 instrucciones
  $finish;
end
initial
begin
interrupciones = 3'b000;
//timerselctor = 3'b011;
end

endmodule
