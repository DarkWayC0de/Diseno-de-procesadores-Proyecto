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
wire enable_wisbone, cpu_wait;
// CPU
cpu micpu(clk, 
          reset,
          interrupciones[2:0],
	  enable_wishbone,
          rd, wr,
          dir[15:0],
          entradaDispositivo[7:0],
          salidaDispositivo[7:0],
          cpu_wait);

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
wire we_master1,
     stb_master1,
     ack_master1,
     cyc_master1;
wire we_master2,
     stb_master2,
     ack_master2,
     cyc_master2;

wire [7:0] data_master1_o;
wire [7:0] data_master2_o;
wire [15:0] dir_master1;
wire [15:0] dir_master2;


whisbone_master master_cpu(	rst_syscom,
				clk_syscom,
				ack_master1,
				data_wishbone_master_i[7:0],
 				data_master1_o[7:0],
				dir_master1[15:0],
				we_master1,
				stb_master1,
				cyc_master1,
				rd,
				wr,
				dir[15:0],
				salidaDispositivo[7:0],
				enable_wishbone,
				entradaDispositivo[7:0],
                                cpu_wait);
wire enable_wishbone2,
     rd2,
     wr2,
     cpu_wait2;
wire [15:0] dir2; 
wire [7:0]  data_master2_2,salidaDispositivo2,entradaDispositivo2;

// WISBONE ARBITRATOR

whisbone_master_arbitrator2 arbitrator(	data_wishbone_master_o[7:0],
					dir_wishbone[15:0],
					we_wishbone,
					stb_wishbone,
					cyc_wishbone,
                                        ack_wishbone,
 					data_master1_o[7:0],
					dir_master1[15:0],
					we_master1,
					stb_master1,
					cyc_master1,
					ack_master1,
 					data_master2_o[7:0],
					dir_master2[15:0],
					we_master2,
					stb_master2,
					cyc_master2,
                                        ack_master2);
//CPU 2     
cpu micpu2(clk, 
          reset,
          interrupciones[2:0],
	  enable_wishbone2,
          rd2, wr2,
          dir2[15:0],
          entradaDispositivo2[7:0],
          salidaDispositivo2[7:0],
          cpu_wait2);

whisbone_master master_cpu2(	rst_syscom,
				clk_syscom,
				ack_master2,
				data_wishbone_master_i[7:0],
 				data_master2_o[7:0],
				dir_master2[15:0],
				we_master2,
				stb_master2,
				cyc_master2,
				rd2,
				wr2,
				dir2[15:0],
				salidaDispositivo2[7:0],
				enable_wishbone2,
				entradaDispositivo2[7:0],
                                cpu_wait2);

wire	mem_cs,	mem_we,	mem_oe;
wire [11:0] mem_dir;
wire [7:0] mem_indata;
wire [7:0] mem_outdata;
//MEM 1
wishbone_slave memslav(rst_syscom,
			clk_syscom,
			dir_wishbone[15:0],
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
// MEM 2
wire	mem_cs2,mem_we2,mem_oe2;
wire [11:0] mem_dir2;
wire [7:0] mem_indata2;
wire [7:0] mem_outdata2;

wishbone_slave #(4'b0001) memslav2(rst_syscom,
				   clk_syscom,
			           dir_wishbone[15:0],
			           we_wishbone,
			           stb_wishbone,
			           cyc_wishbone,
			           data_wishbone_master_o[7:0],
			           data_wishbone_master_i[7:0],
			           ack_wishbone,
			           mem_cs2,
			           mem_we2,
			           mem_oe2,
			           mem_dir2[11:0],
			           mem_indata2[7:0],
			           mem_outdata2[7:0]);


memdata memextern2(	clk,
			mem_cs2,
			mem_we2,
			mem_oe2,
			mem_dir2[11:0],
			mem_indata2[7:0],
			mem_outdata2[7:0]);
// MEM 3
wire	mem_cs3,mem_we3,mem_oe3;
wire [11:0] mem_dir3;
wire [7:0] mem_indata3;
wire [7:0] mem_outdata3;

wishbone_slave #(4'b0010)  memslav3(rst_syscom,
				   clk_syscom,
			           dir_wishbone[15:0],
			           we_wishbone,
			           stb_wishbone,
			           cyc_wishbone,
			           data_wishbone_master_o[7:0],
			           data_wishbone_master_i[7:0],
			           ack_wishbone,
			           mem_cs3,
			           mem_we3,
			           mem_oe3,
			           mem_dir3[11:0],
			           mem_indata3[7:0],
			           mem_outdata3[7:0]);


memdata memextern3(	clk,
			mem_cs3,
			mem_we3,
			mem_oe3,
			mem_dir3[11:0],
			mem_indata3[7:0],
			mem_outdata3[7:0]);

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
