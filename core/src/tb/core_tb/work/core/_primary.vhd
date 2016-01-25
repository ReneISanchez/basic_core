library verilog;
use verilog.vl_types.all;
library work;
entity core is
    generic(
        imem_addr_width_p: integer := 10;
        net_ID_p        : vl_logic_vector(0 to 9) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1)
    );
    port(
        clk             : in     vl_logic;
        n_reset         : in     vl_logic;
        net_packet_i    : in     work.definitions.net_packet_s;
        net_packet_o    : out    work.definitions.net_packet_s;
        from_mem_i      : in     work.definitions.mem_out_s;
        to_mem_o        : out    work.definitions.mem_in_s;
        barrier_o       : out    vl_logic_vector(2 downto 0);
        exception_o     : out    vl_logic;
        debug_o         : out    work.definitions.debug_s;
        data_mem_addr   : out    vl_logic_vector(31 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of imem_addr_width_p : constant is 1;
    attribute mti_svvh_generic_type of net_ID_p : constant is 1;
end core;
