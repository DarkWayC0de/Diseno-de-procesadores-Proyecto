library verilog;
use verilog.vl_types.all;
entity demux1_8 is
    generic(
        WIDTH           : integer := 8
    );
    port(
        a_in            : in     vl_logic_vector;
        y_in            : in     vl_logic_vector;
        sel             : in     vl_logic;
        active          : in     vl_logic;
        reset           : in     vl_logic;
        y_out           : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WIDTH : constant is 1;
end demux1_8;
