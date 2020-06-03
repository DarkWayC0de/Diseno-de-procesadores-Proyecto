library verilog;
use verilog.vl_types.all;
entity timer is
    port(
        reset           : in     vl_logic;
        clock           : in     vl_logic;
        selector        : in     vl_logic_vector(2 downto 0);
        salida          : out    vl_logic
    );
end timer;
