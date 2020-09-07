module whisbone_master( input wire rst_i,
			input wire clk_i,
			input wire ack_i,
			input wire [7:0] dat_i,
			output wire [7:0] dat_o,
			output wire [15:0] adr_o,
			output wire we_o,
			output wire stb_o,
			output wire cyc_o,
			input wire cpu_rd,
			input wire cpu_wr,
			input wire [15:0] cpu_dir,
			input wire [7:0] cpu_data_i,
			input wire enable_wishbone,
			output wire [7:0] cpu_data_o);

assign adr_o = cpu_dir;
assign stb_o =(~rst_i?enable_wishbone:1'b0);
assign cyc_o =(~rst_i?enable_wishbone:1'b0);
assign cpu_data_o = dat_i;
assign dat_o = cpu_data_i;
assign we_o = cpu_wr;

endmodule
