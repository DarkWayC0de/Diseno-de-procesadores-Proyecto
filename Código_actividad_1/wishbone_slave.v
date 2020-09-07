module wishbone_slave(	input wire rst_i,
		       	input wire clk_i,
                       	input wire [11:0] adr_i,
		       	input wire we_i,
		      	input wire stb_i,
		       	input wire cyc_i,
		       	input wire [7:0] dat_i,
		       	output wire [7:0] dat_o,
		       	output wire ack_o,
			output wire mem_cs,
			output wire mem_we,
			output wire mem_oe,
			output wire [11:0] mem_dir,
			output wire [7:0] mem_indata,
                        input wire [7:0] mem_outdata);

assign ack_o = (cyc_i &stb_i);




assign mem_dir = adr_i;
assign mem_indata = dat_i;
assign dat_o = mem_outdata;
assign mem_cs = (ack_o?'b1: 'b0);
assign mem_we = we_i;
assign mem_oe = ~ we_i;
endmodule
