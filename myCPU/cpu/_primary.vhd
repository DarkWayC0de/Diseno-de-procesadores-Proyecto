library verilog;
use verilog.vl_types.all;
entity cpu is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        interrupciones  : in     vl_logic_vector(2 downto 0);
        entradaDispositivo1: in     vl_logic_vector(7 downto 0);
        salidaDispositivo1: out    vl_logic_vector(7 downto 0);
        entradaDispositivo2: in     vl_logic_vector(7 downto 0);
        salidaDispositivo2: out    vl_logic_vector(7 downto 0);
        entradaDispositivo3: in     vl_logic_vector(7 downto 0);
        salidaDispositivo3: out    vl_logic_vector(7 downto 0);
        entradaDispositivo4: in     vl_logic_vector(7 downto 0);
        salidaDispositivo4: out    vl_logic_vector(7 downto 0);
        entradaDispositivo5: in     vl_logic_vector(7 downto 0);
        salidaDispositivo5: out    vl_logic_vector(7 downto 0)
    );
end cpu;
