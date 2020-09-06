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
			input wire enable_whisbone,
			output wire [7:0] cpu_data_o);
reg r_cyc_o,r_stb_o;
always @(posedge rst_i) begin
    r_cyc_o = 'b0;
    r_stb_o = 'b0;
end

initial begin
  r_cyc_o = 'b0;
  r_stb_o = 'b0;
end


assign cyc_o = r_cyc_o;
assign stb_o = r_stb_o;
assign cpu_data_o = dat_i;
assign dat_o = cpu_data_i;
assign we_o = cpu_wr;
assign stb_o = enable_whisbone;
assign cyc_o = enable_whisbone;

endmodule
