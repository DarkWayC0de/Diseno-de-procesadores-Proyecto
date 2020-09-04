module whisbone_master( input wire rst_i,
			input wire clk_i,
			input wire ack_i,
			input wire err_i,
			input wire rty_i,
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
			output wire [7:0] cpu_data_o);

endmodule
