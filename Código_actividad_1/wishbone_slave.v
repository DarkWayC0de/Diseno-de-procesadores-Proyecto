module whishbone_slave(	input wire rst_i,
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
reg r_ack_o, r_mem_cs;

assign ack_o = r_ack_o;

always @(negedge stb_i) begin 
  r_ack_o = 'b0;
end

initial begin 
  r_ack_o = 'b0;
end

always @(posedge clk_i) begin
 r_ack_o = (cyc_i & stb_i);
end

assign mem_dir = adr_i;
assign mem_indata = dat_i;
assign dat_o = mem_outdata;
assign mem_cs = (r_ack_o?'b1: 'b0);
assign mem_we = we_i;
assign mem_oe = ~ we_i;
endmodule
