library verilog;
use verilog.vl_types.all;
entity uc is
    port(
        opcode          : in     vl_logic_vector(5 downto 0);
        z               : in     vl_logic;
        clk             : in     vl_logic;
        we3             : out    vl_logic;
        wez             : out    vl_logic;
        s_inc           : out    vl_logic;
        selectorMuxSaltoR: out    vl_logic;
        selectorMuxRegistros: out    vl_logic;
        guardarMemoriaDatos: out    vl_logic;
        activarMemoriaDatos: out    vl_logic;
        selectorMuxDireccionesMemoriaDatos: out    vl_logic;
        activarPilaSubR : out    vl_logic;
        pushPilaSubR    : out    vl_logic;
        selectorMuxPilaSubR: out    vl_logic;
        activarPilaDatos: out    vl_logic;
        pushPilaDatos   : out    vl_logic;
        selectorMuxPilaDatos: out    vl_logic;
        selectorMuxAluMem_E_S: out    vl_logic;
        op_alu          : out    vl_logic_vector(2 downto 0)
    );
end uc;
