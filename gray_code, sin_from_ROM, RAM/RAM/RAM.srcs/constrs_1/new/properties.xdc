#Clock
set_property PACKAGE_PIN W5 [get_ports {clk}]
set_property IOSTANDARD LVCMOS33 [get_ports {clk}]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {clk}]

# Switches
set_property PACKAGE_PIN V17 [get_ports {we}]
set_property IOSTANDARD LVCMOS33 [get_ports {we}]
set_property PACKAGE_PIN V16 [get_ports {address[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {address[0]}]
set_property PACKAGE_PIN W16 [get_ports {address[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {address[1]}]
set_property PACKAGE_PIN W17 [get_ports {din[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {din[0]}]
set_property PACKAGE_PIN W15 [get_ports {din[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {din[1]}]
set_property PACKAGE_PIN V15 [get_ports {din[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {din[2]}]

# LEDs
set_property PACKAGE_PIN U16 [get_ports {dout[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {dout[0]}]
set_property PACKAGE_PIN E19 [get_ports {dout[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {dout[1]}]
set_property PACKAGE_PIN U19 [get_ports {dout[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {dout[2]}]


