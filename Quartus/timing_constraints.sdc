derive_clock_uncertainty
create_clock -name C50M -period "50 MHz" [get_ports clk]

set_false_path -from [get_ports resetN]
