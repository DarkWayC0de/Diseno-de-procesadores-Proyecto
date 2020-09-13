module whisbone_master_arbitrator2(     output wire [7:0] dat_o,
					output wire [15:0] adr_o,
					output wire we_o,
					output wire stb_o,
					output wire cyc_o,
                                        input  wire ack_i,
					input wire [7:0] dat_o1,
					input wire [15:0] adr_o1,
					input wire we_o1,
					input wire stb_o1,
					input wire cyc_o1,
                                        output wire ack_i1,
					input wire [7:0] dat_o2,
					input wire [15:0] adr_o2,
					input wire we_o2,
					input wire stb_o2,
					input wire cyc_o2,
                                        output wire ack_i2);
reg selector;
wire [1:0]cyc_oSel;
assign cyc_oSel = {cyc_o1,cyc_o2};

always @(cyc_o,cyc_o1,cyc_o2)
case(cyc_oSel)
  2'b00: begin
    selector = 'b0;
  end
  2'b01: begin
    selector = 'b1;
  end
  2'b10: begin
    selector = 'b0;
  end
  2'b11: begin
    selector = 'b0;
  end
endcase

mux2 #(8) dat_oMux(dat_o1,dat_o2,
                   selector,     
                   dat_o);

mux2 #(16) adr_oMux(adr_o1,adr_o2,
                   selector,
                   adr_o);

mux2 #(1) we_oMux(we_o1, we_o2,
                 selector,
                 we_o);

mux2 #(1) stb_oMux(stb_o1, stb_o2,
                   selector,
                   stb_o);

mux2 #(1) cyc_oMux(cyc_o1,cyc_o2,
                   selector,
                   cyc_o);
assign ack_i1 = (~selector? ack_i:'b0);
assign ack_i2 = (selector? ack_i:'b0);

endmodule
