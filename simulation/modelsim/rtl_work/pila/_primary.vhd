library verilog;
use verilog.vl_types.all;
entity pila is
    generic(
        DATA            : integer := 8
    );
    port(
        clk             : in     vl_logic;
        activa          : in     vl_logic;
        push            : in     vl_logic;
        entradaDatos    : in     vl_logic_vector;
        salidaDatos     : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of DATA : constant is 1;
end pila;
