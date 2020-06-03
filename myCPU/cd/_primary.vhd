library verilog;
use verilog.vl_types.all;
entity cd is
    generic(
        ins             : vl_logic_vector(0 to 15) := (Hi1, Hi1, Hi1, Hi0, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1)
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        we3             : in     vl_logic;
        wez             : in     vl_logic;
        s_inc           : in     vl_logic;
        selectorMuxSaltoR: in     vl_logic;
        selectorMuxRegistros: in     vl_logic;
        guardarMemoriaDatos: in     vl_logic;
        activarMemoriaDatos: in     vl_logic;
        selectorMuxDireccionesMemoriaDatos: in     vl_logic;
        activarPilaSubR : in     vl_logic;
        pushPilaSubR    : in     vl_logic;
        selectorMuxPilaSubR: in     vl_logic;
        activarPilaDatos: in     vl_logic;
        pushPilaDatos   : in     vl_logic;
        selectorMuxPilaDatos: in     vl_logic;
        selectorMuxAluMem: in     vl_logic;
        op_alu          : in     vl_logic_vector(2 downto 0);
        interrupciones  : in     vl_logic_vector(2 downto 0);
        z               : out    vl_logic;
        opcode          : out    vl_logic_vector(5 downto 0);
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
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of ins : constant is 1;
end cd;
