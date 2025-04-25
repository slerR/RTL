# Clock configuration
set_property PACKAGE_PIN W5 [get_ports {clk}]
set_property IOSTANDARD LVCMOS33 [get_ports {clk}]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {clk}]

## Input delay constraints
#set_input_delay -clock [get_clocks sys_clk_pin] 2.0 [get_ports input_data]
#set_input_delay -clock [get_clocks sys_clk_pin] 2.0 [get_ports srst]

## Output delay constraints
#set_output_delay -clock [get_clocks sys_clk_pin] 2.0 [get_ports start]
#set_output_delay -clock [get_clocks sys_clk_pin] 2.0 [get_ports output_data]
