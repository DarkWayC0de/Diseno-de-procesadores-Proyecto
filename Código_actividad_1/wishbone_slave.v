module whishbone_slave(	input wire rst_i,
		       	input wire clk_i,
                       	input wire [11:0] adr_i,
		       	input wire we_i,
		      	input wire stb_i,
		       	input wire cyc_i,
		       	input wire [7:0] dat_i,
		       	output wire [7:0] dat_o,
		       	output wire ack_o,
		       	output wire err_o,
                       	output wire rty_o,
			output wire mem_cs,
			output wire mem_we,
			output wire mem_oe,
			output wire [11:0] mem_dir,
			output wire [7:0] mem_indata,
                        input wire [7:0] mem_outdata);



endmodule
