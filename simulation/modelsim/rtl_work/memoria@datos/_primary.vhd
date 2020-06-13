library verilog;
use verilog.vl_types.all;
entity memoriaDatos is
    port(
        clk             : in     vl_logic;
        guardar         : in     vl_logic;
        activa          : in     vl_logic;
        direccionMemoria: in     vl_logic_vector(6 downto 0);
        entradaDatos    : in     vl_logic_vector(7 downto 0);
        salidaDatos     : out    vl_logic_vector(7 downto 0)
    );
end memoriaDatos;
