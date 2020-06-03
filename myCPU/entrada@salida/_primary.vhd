library verilog;
use verilog.vl_types.all;
entity entradaSalida is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        entradaDispositivo1: in     vl_logic_vector(7 downto 0);
        salidaDispositivo1: out    vl_logic_vector(7 downto 0);
        entradaDispositivo2: in     vl_logic_vector(7 downto 0);
        salidaDispositivo2: out    vl_logic_vector(7 downto 0);
        entradaDispositivo3: in     vl_logic_vector(7 downto 0);
        salidaDispositivo3: out    vl_logic_vector(7 downto 0);
        entradaDispositivo4: in     vl_logic_vector(7 downto 0);
        salidaDispositivo4: out    vl_logic_vector(7 downto 0);
        entradaDispositivo5: in     vl_logic_vector(7 downto 0);
        salidaDispositivo5: out    vl_logic_vector(7 downto 0);
        entradaEntradaSalida: in     vl_logic_vector(7 downto 0);
        direccionEntradaSalida: in     vl_logic_vector(6 downto 0);
        salidaEntradaSalida: out    vl_logic_vector(7 downto 0);
        activarEntradaSalida: in     vl_logic;
        escribirEntradaSalida: in     vl_logic
    );
end entradaSalida;
