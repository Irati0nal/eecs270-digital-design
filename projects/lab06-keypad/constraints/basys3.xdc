# ----------------------------------------------------------------------------
# Clock Signal
# ----------------------------------------------------------------------------
set_property PACKAGE_PIN W5 [get_ports clk]
	set_property IOSTANDARD LVCMOS33 [get_ports clk]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

# ----------------------------------------------------------------------------
# Hardware Reset (Central Push Button on Board)
# ----------------------------------------------------------------------------
set_property PACKAGE_PIN U18 [get_ports reset]
	set_property IOSTANDARD LVCMOS33 [get_ports reset]

# ----------------------------------------------------------------------------
# Pmod JA for Keypad Rows and Columns Interface
# ----------------------------------------------------------------------------
# Keypad Row inputs with Internal Pulldowns (JA Pins 1, 2, 3, 4)
set_property PACKAGE_PIN J1 [get_ports {row[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {row[0]}]
	set_property PULLDOWN true [get_ports {row[0]}]

set_property PACKAGE_PIN L2 [get_ports {row[1]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {row[1]}]
	set_property PULLDOWN true [get_ports {row[1]}]

set_property PACKAGE_PIN J2 [get_ports {row[2]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {row[2]}]
	set_property PULLDOWN true [get_ports {row[2]}]

set_property PACKAGE_PIN G2 [get_ports {row[3]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {row[3]}]
	set_property PULLDOWN true [get_ports {row[3]}]

# Keypad Column outputs (JA Pins 7, 8, 9, 10)
set_property PACKAGE_PIN H1 [get_ports {col[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {col[0]}]

set_property PACKAGE_PIN K2 [get_ports {col[1]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {col[1]}]

set_property PACKAGE_PIN H2 [get_ports {col[2]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {col[2]}]

set_property PACKAGE_PIN G3 [get_ports {col[3]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {col[3]}]

# ----------------------------------------------------------------------------
# Onboard 7-Segment Display Cathodes (seg)
# ----------------------------------------------------------------------------
set_property PACKAGE_PIN W7 [get_ports {seg[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {seg[0]}]
set_property PACKAGE_PIN W6 [get_ports {seg[1]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {seg[1]}]
set_property PACKAGE_PIN U8 [get_ports {seg[2]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {seg[2]}]
set_property PACKAGE_PIN V8 [get_ports {seg[3]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {seg[3]}]
set_property PACKAGE_PIN U5 [get_ports {seg[4]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {seg[4]}]
set_property PACKAGE_PIN V5 [get_ports {seg[5]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {seg[5]}]
set_property PACKAGE_PIN U7 [get_ports {seg[6]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {seg[6]}]

# ----------------------------------------------------------------------------
# Onboard 7-Segment Display Anodes (an)
# ----------------------------------------------------------------------------
set_property PACKAGE_PIN U2 [get_ports {an[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {an[0]}]
set_property PACKAGE_PIN U4 [get_ports {an[1]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {an[1]}]
set_property PACKAGE_PIN V4 [get_ports {an[2]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {an[2]}]
set_property PACKAGE_PIN W4 [get_ports {an[3]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {an[3]}]
