# Usage: vivado -mode batch -source scripts/build.tcl -tclargs 7 [synth|bitstream]
set root [file normalize [file join [file dirname [info script]] ..]]
set labs {lab01-full-adder lab02-seven-segment lab03-alu lab04-counter lab05-digital-clock lab06-keypad lab07-digital-device}
set tops {full_adder bcd_display alu4 top digital_clock top_keypad_system top_lab7}
if {$argc < 1 || ![string is integer -strict [lindex $argv 0]] || [lindex $argv 0] < 1 || [lindex $argv 0] > 7} {
    error "Specify lab number 1..7 and optionally synth or bitstream"
}
set index [expr {[lindex $argv 0] - 1}]
set stage [lindex $argv 1]
if {$stage eq ""} {set stage synth}
if {$stage ni {synth bitstream}} {error "Stage must be synth or bitstream"}
set lab [lindex $labs $index]
set top [lindex $tops $index]
set project [file join $root projects $lab]
set out [file join $root build $lab]
file mkdir $out
create_project -in_memory -part xc7a35tcpg236-1
read_verilog [glob [file join $root rtl common *.v]]
read_verilog [glob [file join $project rtl *.v]]
read_xdc [file join $project constraints basys3.xdc]
synth_design -top $top -part xc7a35tcpg236-1
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]
report_utilization -file [file join $out utilization.rpt]
report_drc -file [file join $out synthesis-drc.rpt]
write_checkpoint -force [file join $out synthesized.dcp]
if {$stage eq "bitstream"} {
    opt_design
    place_design
    route_design
    report_timing_summary -file [file join $out timing.rpt]
    report_drc -file [file join $out implementation-drc.rpt]
    write_bitstream -force [file join $out $top.bit]
}
