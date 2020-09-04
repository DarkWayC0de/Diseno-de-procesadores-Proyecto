module syscon(input clk, reset,
              output clk_o, rst_o);
assign clk_o = clk;
assign rst_o = reset;

endmodule
